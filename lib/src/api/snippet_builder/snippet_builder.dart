// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsdui/fsdui.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'snippet_menu_anchor.dart'
    show SnippetMenuAnchor, AnchorWidgetEnum;

const BODY_PLACEHOLDER = 'body-placeholder';

class SnippetBuilder extends StatefulWidget {
  // final String? panelName;

  // original snippet (tree of nodes) - root node will have the snippet name
  final SNode initialValue;

  final Map<String, void Function(BuildContext)>? handlers;

  final bool justPlaying;

  // final HotspotTargetModel? tc; // for when called to create a hotspot callout

  final void Function(ScrollNotification)? onScrollF;

  final VoidCallback? onLayoutDone;

  const SnippetBuilder({
    required this.initialValue,
    this.handlers,
    this.onScrollF,
    this.justPlaying = false,
    // this.tc,
    this.onLayoutDone,
    super.key,
  });

  // static SnippetBuilderState? of(BuildContext context) =>
  //     context.findAncestorStateOfType<SnippetBuilderState>();

  @override
  State<SnippetBuilder> createState() => SnippetBuilderState();
}

class SnippetBuilderState extends State<SnippetBuilder>
    with TickerProviderStateMixin {
  late String snippetName;
  Map<String, TabBarNode> tabBars = {};
  
  // ZoomerState? get parentTSState => Zoomer.of(context);

  // int countTabs() {
  //   SnippetRootNode? rootNode = FCO.capiBloc.state.rootNode("root");
  //   if (rootNode == null) return 0;
  //   TabBarNode? tabBarNode = FCO.capiBloc.state.snippetBeingEdited?.treeC.findNodeTypeInTree(rootNode, TabBarNode) as TabBarNode?;
  //   return tabBarNode?.children.length ?? 0;
  // }

  @override
  void initState() {
    super.initState();

    snippetName = widget.initialValue.name!;

    // register snippetBuilderState i.o.t. access its state
    fsdui.snippetBuilderStates[snippetName] = this;
    print('fsdui.snippetBuilderStates[$snippetName] = $this');
    
    widget.handlers?.forEach((key, value) {
      fsdui.registerHandler(key, value);
      fsdui.logger.i("registered handler '$key'");
    });

    // removed snippet place naming functionality - use tab bar instead
    // if (widget.panelName != null &&
    //     !fco.placeNames.contains(widget.panelName)) {
    //   fco.placeNames.add(widget.panelName!);
    // }
  }

  @override
  void dispose() {
    // fsdui.snippetBuilderStates.remove(snippetName);
    super.dispose();
  }

  // removed snippet place naming functionality - use tab bar instead
  // @override
  // void dispose() {
  //   if (widget.panelName != null && fco.placeNames.contains(widget.panelName)) {
  //     fco.placeNames.remove(widget.panelName!);
  //   }
  //   super.dispose();
  // }

  bool get pageIsEditable => EditablePage.of(context) != null;

  CAPIBloC get bloc => context.read<CAPIBloC>();

  @override
  Widget build(BuildContext context) {
    final notifier = fsdui.appInfo.cachedSnippetInfo(snippetName)?.getChangeNotifier();

    return fsdui.canEditAnyContent() && notifier != null
        ? ValueListenableBuilder<String>(
            // must assume snippetInfo will be in cache
            valueListenable: notifier,
            builder: (context, value, child) =>
                buildWithBloc(updatedSnippetJson: value),
          )
        : buildWithBloc(updatedSnippetJson: '');
  }

  Widget buildWithBloc({required String updatedSnippetJson}) {
    return BlocBuilder<CAPIBloC, CAPIState>(
      buildWhen: (previous, current) {
        bool result =
            (!current.onlyTargetsWrappers
            //     &&
            // previous.snippetNameShowingTappableOverlaysFor !=
            //     current.snippetNameShowingTappableOverlaysFor
            );
        // print('buildWhen is $result');
        return result;
      },
      builder: (context, state) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              // print(
              //   "A descendant widget scrolled to: ${notification.metrics.pixels}",
              // );
              widget.onScrollF?.call(notification);
              // if (fco.inNodeSelectionMode) {
              // Schedule the callback, but DO NOT pass the stale state into it.
              // fco.afterNextBuildDo(() {
              // Inside the callback, use the BuildContext to get the
              // LATEST state from the BLoC. The `context` here is from
              // the BlocBuilder's builder method and is always current.
              // Why This Works
              //   - context.read<CAPIBloC>().state: The context passed
              //   to the BlocBuilder's builder is "live" and is aware
              //   of its position in the widget tree. When you call
              //   context.read<T>(), it walks up the tree to find the
              //   nearest provider of type T (in this case, your CapiBloc)
              //   and gives you access to it.
              //   - Post-Build Accuracy: Because your afterNextBuildDo
              //   callback runs after the build cycle, when you call
              //   context.read<CAPIBloC>().state at that moment, you are
              //   guaranteed to receive the most up-to-date state object
              //   that was just used for the completed build.
              //
              // This pattern of fetching fresh state from the BuildContext
              // inside a post-frame callback is the standard and correct
              // way to avoid race conditions and stale state issues in
              // Flutter when dealing with asynchronous UI updates.
              // final CAPIBloC bloc = context.read<CAPIBloC>();
              // final CAPIState currentState = bloc.state;
              // TODO populateNodeBorderRects(snippetName());
              // });
              // return true;
              // }
            }
            // Return `true` to consume the notification and stop it from bubbling further up.
            // Return `false` to let it continue bubbling.
            return false;
          },
          child: Builder(
            builder: (context) {
              // optimise by first checking whether already in memory
              // can avoid unnecessary futurebuilder
              var appInfo = fsdui.appInfo;
              bool snippetExists = appInfo.snippetNames.contains(snippetName);
              if (!snippetExists) {
                // SNIPPET DOES NOT YET EXIST - use template to create
                // first version as a clone of the template
                fsdui.pageList.add(widget.initialValue.name!);
                VersionId newVersionId = SnippetInfoModel.createNewVersion(
                  widget.initialValue,
                );
                print(
                  'SnippetBuilder() created a brand new snippet from a template (${widget.initialValue.name}',
                );
                fsdui.modelRepo
                    .saveBrandNewSnippet(
                      snippetName: widget.initialValue.name!,
                      versionId: newVersionId,
                      initialVersion: widget.initialValue,
                    )
                    .then((b) {
                      fsdui.modelRepo.saveAppInfo();
                    });

                return _stackWidget(
                  widget.initialValue,
                  updatedSnippetJson,
                );
              }

              // ALREADY EXIST - SNIPPET MAY BE IN CACHE (avoid Future)
              SnippetInfoModel? snippetInfo = fsdui.appInfo.cachedSnippetInfo(
                snippetName,
              );
              if (snippetInfo != null) {
                // SNIPPET EXISTS, TRY TO GET FROM SNIPPET CACHE
                // A SNIPPET INFO ALWAYS HAS AT LEAST 1 VERSION
                SNode? snippet = snippetInfo.currentVersionInCache();
                if (snippet != null) {
                  return _stackWidget(snippet, updatedSnippetJson);
                }
              }

              // EXISTS, BUT NOT PRESENT IN CACHE, so go fetch...
              return FutureBuilder<SNode?>(
                future: SNode.loadSnippetFromCacheOrFromFB(
                  snippetName: snippetName,
                ),
                builder: (futureContext, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // SnippetInfoModel.debug();
                  // SnippetInfoModel? snippetInfo = SnippetInfoModel.snippetInfoCache[snippetName()];
                  // SnippetInfoModel.debug();

                  if (snapshot.data == null) {
                    return Error(
                      "SnippetBuilder",
                      color: Colors.red,
                      size: 18,
                      errorMsg:
                          "${snippetName}: ${snapshot.error.toString()}",
                      key: GlobalKey(),
                    );
                  }

                  SNode snippet = snapshot.data!;

                  return _stackWidget(snippet, updatedSnippetJson);
                },
              );
            },
          ),
        );
      },
    );
    //   },
    // );
  }

  Widget _stackWidget(SNode snippet, String updatedSnippetJson) {
    // triggers AFTER layout of this widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLayoutDone?.call();
    });

    late List<Widget> stackChildren;

    try {
      stackChildren = [snippet.build(context, null)];
    } catch (e) {
      stackChildren = [Icon(Icons.error, size: 40, color: Colors.purpleAccent)];
    }

    SnippetInfoModel snippetInfo = fsdui.appInfo.cachedSnippetInfo(
      snippetName,
    )!;

    bool isPublishedVersion = fsdui.isEditingVersionPublished(snippetName);

    Color triangleColor = Colors.purpleAccent; // in edit mode
    if (!isPublishedVersion) triangleColor = Colors.deepOrange;
    if (snippetInfo.changesPending(updatedSnippetJson)) {
      triangleColor = Colors.yellowAccent;
    }

    // orange indicator when not signed in and
    // showing an unpublished snippet
    if (!widget.justPlaying &&
        !isPublishedVersion &&
        !fsdui.canEditAnyContent()) {
      stackChildren.add(
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.deepOrange,
            height: 6,
            width: double.infinity,
          ),
        ),
      );
    }

    // show menu anchor if signed in and not selecting a
    // widget not editing a snippety
    if (fsdui.canEditAnyContent() &&
        bloc.dontShowTappableBorderRects() &&
        bloc.aSnippetIsNotBeingEdited() &&
        !fsdui.anyPresent([], startsWith: 'quill-toolbar-')) {
      stackChildren.add(
        Align(
          alignment: Alignment.topRight,
          child: PointerInterceptor(
            child: SnippetMenuAnchor(
              this,
              anchorWidget: AnchorWidgetEnum.Triangle,
              triangleColor: triangleColor,
              snippetInfo: snippetInfo,
            ),
          ),
        ),
      );
    }

    // show menu anchor for a hotspot's content
    // cId as a number means it's a hotspot content callout
    if (!widget.justPlaying &&
        fsdui.canEditAnyContent() &&
        bloc.dontShowTappableBorderRects() &&
        bloc.aSnippetIsNotBeingEdited() &&
        pageIsEditable &&
        SNode.isHotspotCalloutContent(snippetName)) {
      stackChildren.add(
        Align(
          alignment: Alignment.topRight,
          child: PointerInterceptor(
            child: Tooltip(
              message: isPublishedVersion
                  ? 'show Snippet menu\n${snippetInfo.name}'
                  : 'show Snippet menu\n${snippetInfo.name}\n*** NOT PUBLISHED ***',
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.topRight,
                child: SnippetMenuAnchor(
                  this,
                  anchorWidget: AnchorWidgetEnum.IconButton,
                  snippetInfo: snippetInfo,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Stack(children: stackChildren);
  }
}

// void _tappedTriangle(bool isCID) {
//   if ((!pageIsEditable && !isCID) || fco.snippetBeingEdited != null) {
//     return;
//   }
//
//   fco.capiBloc.add(CAPIEvent.enterSelectWidgetMode(snippetName: snippetName ?? widget.snippetRootNode!.name));
// }

// _renderSnippet(context) {
//   return FutureBuilder<void>(
//
//     future: SnippetRootNode.loadSnippetFromCacheOrFromFBOrCreateFromTemplate(snippetName: snippetName()),
//     builder: (futureContext, snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {
//         Widget snippetWidget;
//         try {
//           // in case did a revert, ignore snapshot data and use the AppInfo instead
//           SnippetRootNode? snippet = FCO.currentSnippet(snippetName());
//           snippet?.validateTree();
//           // SnippetRootNode? snippetRoot = cache?[editingVersionId];
//           snippetWidget =
//               snippet == null ? const Icon(Icons.error, color: Colors.redAccent) : snippet.child?.toWidget(futureContext, snippet) ?? const Placeholder();
//         } catch (e) {
//           fco.logger.i('snippetRootNode.toWidget() failed!');
//           snippetWidget = Material(
//             textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 12),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   const Icon(Icons.error, color: Colors.redAccent),
//                   Gap(10),
//                   FCO.coloredText(e.toString()),
//                 ],
//               ),
//             ),
//           );
//         }
//         return snippetWidget;
//       } else {
//         return const Center(child: CircularProgressIndicator());
//       }
//     });
// }
