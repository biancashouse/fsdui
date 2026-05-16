import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/fancy_tree/tree_controller.dart';
import 'package:fsdui/src/snippet/fancy_tree/tree_indentation.dart';
import 'package:fsdui/src/snippet/fancy_tree/tree_view.dart';
import 'package:fsdui/src/snippet/snode_widget.dart';
import '../../bloc/snippet_being_edited.dart' show SnippetBeingEdited;

class SnippetTreeView extends StatefulWidget {
  /// When true, all rows are built eagerly (no lazy rendering) and the caller
  /// is expected to wrap this in a [SingleChildScrollView] for scrolling.
  /// Required for [Scrollable.ensureVisible] to work on any node.
  final bool shrinkWrap;
  final SnippetBeingEdited snippetBeingEdited;

  const SnippetTreeView({
    super.key,
    this.shrinkWrap = false,
    required this.snippetBeingEdited,
  });

  @override
  State<SnippetTreeView> createState() => _SnippetTreeViewState();
}

class _SnippetTreeViewState extends State<SnippetTreeView> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode _, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;
    if (key != LogicalKeyboardKey.arrowUp &&
        key != LogicalKeyboardKey.arrowDown) {
      return KeyEventResult.ignored;
    }
    final selected = fsdui.selectedNode;
    if (selected == null) return KeyEventResult.ignored;
    final siblings = selected.maybeSiblings();
    if (siblings == null || siblings.length <= 1) return KeyEventResult.ignored;
    final idx = siblings.indexOf(selected);
    if (idx < 0) return KeyEventResult.ignored;

    if (key == LogicalKeyboardKey.arrowUp && idx > 0) {
      fsdui.dismissAll();
      fsdui.capiBloc.add(ReorderSibling(node: selected, newSiblingIndex: idx - 1));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowDown && idx < siblings.length - 1) {
      fsdui.dismissAll();
      fsdui.capiBloc.add(ReorderSibling(node: selected, newSiblingIndex: idx + 1));
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final SnippetTreeController treeC = widget.snippetBeingEdited.treeC;
    return BlocListener<CAPIBloC, CAPIState>(
      // Claim keyboard focus whenever a node is selected so arrow-key
      // reordering works immediately after a tap without a second click.
      listenWhen: (prev, curr) => prev.force != curr.force,
      listener: (context, state) {
        if (!context.mounted) return;
        if (fsdui.aNodeIsSelected) {
          // Defer past the current frame so requestFocus() never races with
          // the setState scheduled by treeC.rebuild() in the same event.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _focusNode.requestFocus();
          });
        }
      },
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        child: TreeView<SNode>(
          shrinkWrap: widget.shrinkWrap,
          physics: widget.shrinkWrap ? const NeverScrollableScrollPhysics() : null,
          treeController: treeC,
          nodeBuilder: (BuildContext context, TreeEntry<SNode> entry) =>
              _treeIndentation(entry, treeC),
        ),
      ),
    );
  }

  TreeIndentation _treeIndentation(
    TreeEntry<SNode> entry,
    SnippetTreeController treeC,
  ) => TreeIndentation(
    guide: IndentGuide.connectingLines(
      color: fsdui.aNodeIsSelected && entry.node == fsdui.selectedNode
          ? Colors.purpleAccent
          : Colors.white,
      indent: 40.0,
    ),
    entry: entry,
    child: SNodeWidget(
      snippetName: widget.snippetBeingEdited.getRootNode().name ?? 'snippet name ?',
      treeController: treeC,
      entry: entry,
    ),
  );
}
