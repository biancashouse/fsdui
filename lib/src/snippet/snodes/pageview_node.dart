import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

import '../pnodes/fyi_pnodes.dart';
import '../pnodes/string_list_pnode.dart';

part 'pageview_node.mapper.dart';

@MappableClass()
class PageViewNode extends SNode with PageViewNodeMappable {
  List<String> childSnippetNames;

  // Paired 1:1 (by index) with childSnippetNames — an optional display title
  // for each page, used to customise the appbar's title. Kept in lockstep
  // length with childSnippetNames by every mutation path (the property
  // editor and onAddChildSnippetSelected below).
  List<String> childSnippetTitles;

  PageViewNode({
    super.name,
    this.childSnippetNames = const [],
    this.childSnippetTitles = const [],
  });

  // A PageView's children are meant to be whole pages, so only offer
  // existing page snippets (name starts with '/') when adding a child — no
  // generic widget types (Container, Text, ...).
  @override
  bool canAppendAChild() => true;

  @override
  List<Type> appendCandidates() => [];

  @override
  List<Type> recommendations(NodeAction action) =>
      action == NodeAction.addChild ? [] : super.recommendations(action);

  @override
  List<String> snippetCandidates(NodeAction action) {
    if (action != NodeAction.addChild) return super.snippetCandidates(action);
    return super
        .snippetCandidates(action)
        .where((name) => name.startsWith('/'))
        .toList();
  }

  // Picking a page snippet from the quick-pick just references it by name —
  // it doesn't embed a same-typed blank copy the way the base SNode behavior
  // does for ordinary child nodes.
  @override
  void onAddChildSnippetSelected(String snippetName, Type snippetType) {
    childSnippetNames = [...childSnippetNames, snippetName];
    childSnippetTitles = [...childSnippetTitles, ''];
    fsdui.capiBloc.add(ChangedSnippet());
  }

  List<String> _pageSnippetNames() =>
      fsdui.appInfo.snippetNames.where((name) => name.startsWith('/')).toList()
        ..sort();

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    FlutterDocPNode(
      buttonLabel: 'PageView',
      webLink: 'https://api.flutter.dev/flutter/widgets/PageView-class.html',
      snode: this,
      name: 'fyi',
    ),
    StringListPNode(
      snode: this,
      name: 'childSnippetNames',
      values: childSnippetNames,
      onListChange: (newValues) =>
          refreshWithUpdate(context, () => childSnippetNames = newValues),
      calloutButtonSize: const Size(220, 28),
      options: _pageSnippetNames(),
      secondaryValues: childSnippetTitles,
      onSecondaryListChange: (newTitles) =>
          refreshWithUpdate(context, () => childSnippetTitles = newTitles),
      secondaryHintText: 'title',
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);

    final childWidgets = childSnippetNames.map((s) {
      final Future<SNode?> snodeFuture = SNode.loadSnippetFromCacheOrFromFB(
        snippetName: s,
      );
      final Future<Widget> widgetFuture = snodeFuture.then(
        (snode) => snode?.build(context, this) ?? const Icon(Icons.warning),
      );
      return FutureBuilder<Widget>(
        future: widgetFuture,
        builder: (ctx, snapshot) {
          return snapshot.hasData
              ? snapshot.data!
              : const CircularProgressIndicator();
        },
      );
    }).toList();

    return _TitleSyncingPageView(
      key: createNodeWidgetGK(),
      titles: childSnippetTitles,
      children: childWidgets,
    );
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "PageView";
}

// Publishes the visible page's title to fsdui.currentPageTitleVN, so a
// SliverAppBar elsewhere in the tree can display it — the PageView is built
// deep inside the snippet tree, with no BuildContext relationship to
// whatever's showing its title, so a global ValueNotifier is the simplest
// bridge (mirrors fsdui.quillTextToolbarCIDVN elsewhere in this package).
// A stateful wrapper (rather than PageView's own onPageChanged) is needed so
// the first page's title is published once via initState, instead of on
// every rebuild of the parent PageViewNode.
class _TitleSyncingPageView extends StatefulWidget {
  final List<String> titles;
  final List<Widget> children;

  const _TitleSyncingPageView({
    super.key,
    required this.titles,
    required this.children,
  });

  @override
  State<_TitleSyncingPageView> createState() => _TitleSyncingPageViewState();
}

class _TitleSyncingPageViewState extends State<_TitleSyncingPageView> {
  @override
  void initState() {
    super.initState();
    _publishTitle(0);
  }

  void _publishTitle(int index) {
    final title = index < widget.titles.length ? widget.titles[index] : '';
    fsdui.afterNextBuildDo(() => fsdui.currentPageTitleVN.value = title);
  }

  @override
  Widget build(BuildContext context) =>
      PageView(onPageChanged: _publishTitle, children: widget.children);
}
