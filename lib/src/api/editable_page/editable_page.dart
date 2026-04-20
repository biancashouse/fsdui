import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/api/editable_page/snippet_editor_side_panel.dart';
import 'package:fsdui/src/api/editable_page/tappable_node_borders.dart';
import 'package:fsdui/src/snippet/snode_widget.dart';
import 'package:fsdui/src/snippet/snodes/hotspots/widgets/hotspot_target_config_toolbar/hotspot_target_config_toolbar.dart';

class EditablePage extends StatefulWidget {
  final RoutePath routePath;
  final Widget child;

  // final bool provideNamedScrollController;

  const EditablePage({
    required this.routePath,
    required this.child,
    // this.provideNamedScrollController = false,
    // this.dontShowLockIcon = false,
    required super.key, // provides access to state later - see initState and fco.pageGKs
  });

  // allow a page widget to find its parent EditablePage
  static EditablePageState? of(BuildContext context) => context.mounted
      ? context.findAncestorStateOfType<EditablePageState>()
      : null;

  // static ScrollController? ancestorSc(BuildContext context, Axis? axis) {
  //   ScrollableState? scrollableState = Scrollable.maybeOf(context, axis: axis);
  //   return scrollableState?.widget.controller;
  // }

  @override
  State<EditablePage> createState() => EditablePageState();
}

class EditablePageState extends State<EditablePage> {
  List<NodeRenderData> borderRects = [];
  bool _needsToPopulateRects = false;
  GlobalKey zoomerGk = GlobalKey();

  @override
  void initState() {
    super.initState();
    fsdui.currentEditablePagePath = widget.routePath;
  }

  @override
  void dispose() {
    SnippetEditorSidePanel.hideSidePanelOverlay();
    super.dispose();
  }

  // also allow for a selected node
  void _populateNodeBorderRects() {
    if (fsdui.capiBloc.state.activeSnippetName == null &&
        fsdui.capiBloc.aSnippetIsNotBeingEdited()) {
      return;
    }
    List<SNode> nodes = [];
    SNode? rootNode;
    // not yet editing, show all widget borderRects
    SnippetInfoModel? snippetInfo = fsdui.appInfo.cachedSnippetInfo(
      fsdui.capiBloc.state.activeSnippetName != null
          ? fsdui.capiBloc.state.activeSnippetName!
          : fsdui.capiBloc.state.snippetBeingEdited?.getRootNode().name ?? '???',
    );
    rootNode = snippetInfo?.currentVersionInCache();
    // traverse node
    borderRects.clear();
    if (rootNode != null) {
      nodes = rootNode.findDescendantNodes();
      // print('found ${nodes.length} nodes in snippet $snippetName');
      for (SNode node in nodes) {
        if (node is! QuillTextNode && node is! MarkdownNode) {
          Rect? borderRect = node.calcBorderRect();
          if (borderRect != null) {
            borderRects.add(NodeRenderData(node: node, rect: borderRect));
          }
        }
      }
    }
    // print('populateNodeBorderRects measured ${borderRects.length} nodes.');
    // for (NodeRenderData data in borderRects) {
    //   print('rect: ${data.rect}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    // print('build - borderRects: ${borderRects.length}');
    return BlocConsumer<CAPIBloC, CAPIState>(
      listenWhen: (prev, curr) =>
          prev.activeSnippetName != curr.activeSnippetName ||
          (prev.snippetBeingEdited == null) !=
              (curr.snippetBeingEdited == null) ||
          prev.snippetBeingEdited?.selectedNode !=
              curr.snippetBeingEdited?.selectedNode,
      listener: (lcontext, state) {
        if (state.activeSnippetName != null &&
            state.snippetBeingEdited == null) {
          // entered node selection mode
          _needsToPopulateRects = true;
        } else if (state.snippetBeingEdited != null &&
            state.activeSnippetName == null) {
          // entered editing mode — show panel overlay and populate rects
          SnippetEditorSidePanel.showSidePanelOverlay(context);
          fsdui.afterNextBuildDo(() {
            _needsToPopulateRects = true;
          });
        } else if (state.snippetBeingEdited == null &&
            state.activeSnippetName == null) {
          // left editing mode — remove panel overlay
          SnippetEditorSidePanel.hideSidePanelOverlay();
        } else if (state.snippetBeingEdited?.selectedNode != null) {
          // node selected within editing — refresh border rects
          if (fsdui.anyPresent(['quill-te', 'uml-te', 'markdown-te'])) return;
          fsdui.dismissAll();
          fsdui.afterNextBuildDo(() {
            _needsToPopulateRects = true;
          });
        }
      },
      buildWhen: (previous, current) {
        if (_needsToPopulateRects) return true;
        if (previous.activeSnippetName != current.activeSnippetName)
          return true;
        if ((previous.snippetBeingEdited == null) !=
            (current.snippetBeingEdited == null))
          return true;
        // update border rects on selection change
        if (previous.snippetBeingEdited?.selectedNode !=
            current.snippetBeingEdited?.selectedNode)
          return true;
        if ((previous.isSignedInAsSuperEditor !=
                current.isSignedInAsSuperEditor) &&
            !fsdui.canEditAnyContent())
          return true;
        if (current.onlyTargetsWrappers) return false;
        return false;
      },
      builder: (BuildContext context, CAPIState state) {
        final bloc = context.read<CAPIBloC>();
        final builtWidget = GestureDetector(
          onTap: () {
            if (bloc.showTappableBorderRects()) {
              bloc.add(CAPIEvent.exitNodeSelectionMode());
            }
          },
          child: Material(child: _pageStack(bloc)),
        );
        return fsdui.isAndroid
            ? fsdui.androidAwareBuild(context, builtWidget)
            : builtWidget;
      },
    );
  }

  void _tappedToEditSnippetAndSelectNode(SNode node) {
    SNode? rootNode = node.rootNodeOfSnippet();
    if (rootNode == null) return;
    SnippetName? snippetName = rootNode.name;
    // maybe a page snippet, so check name in appInfo: maybe prefix with /
    // var names = fco.appInfo.snippetNames;
    if (fsdui.appInfo.snippetNames.contains('/$snippetName')) {
      snippetName = '/$snippetName';
    }

    if (SNode.isHotspotCalloutContent(snippetName!)) {
      final cc = fsdui.findOE(snippetName)?.calloutConfig;
      cc?.rebuild(() {
        cc
          ..barrier = null
          ..targetPointerType = TargetPointerType.none();
      });
    }

    pushThenShowNamedSnippetWithNodeSelected(rootNode, node);
  }

  void pushThenShowNamedSnippetWithNodeSelected(
    SNode rootNode,
    SNode selectedNode, {
    HotspotTargetModel? targetBeingConfigured,
  }) {
    var snippetRootContext = rootNode.nodeWidgetGK?.currentContext;
    if (snippetRootContext == null) {
      fsdui.showToast(
        msg: "This node is not visible right now",
        bgColor: Colors.white,
        textColor: Colors.red,
        removeAfterMs: 5000,
      );
      return;
    }

    context.read<CAPIBloC>().add(
      CAPIEvent.pushSnippetEditor(
        rootNode: rootNode,
        selectedNode: selectedNode,
      ),
    );
    fsdui.afterNextBuildDo(() {
      if (fsdui.snippetBeingEdited != null) {
        if (!fsdui.appInfo.clipboardIsEmpty) {
          fsdui.appInfo.showFloatingClipboard();
        }
        fsdui.hide(HotspotTargetConfigToolbar.CID);
      }

      // point out the selected node widget
      var selectedNodeContext = selectedNode.nodeWidgetGK?.currentContext;
      if (selectedNodeContext != null) {
        SNodeWidget.pointOutSelectedNode();
      }

      // // point out the selected node in the snippet tree
      // fco.afterMsDelayDo(1000, () {
      //   var cc = selectedNode.nodeGK?.currentContext;
      //   if (cc != null) {
      //     Scrollable.ensureVisible(
      //       cc,
      //       duration: const Duration(milliseconds: 500),
      //       curve: Curves.easeOut,
      //       alignment: .5,
      //     );
      //   }
      // });
    });
  }

  /// Unified page stack for all three modes:
  /// - Normal: Zoomer(child) only
  /// - Node selection: SnippetBuilder + TappableNodeBorders
  /// - Editing: SnippetBuilder + TappableNodeBorders + SnippetEditorSidePanel
  Widget _pageStack(CAPIBloC bloc) {
    final showSnippet =
        bloc.showTappableBorderRects() || bloc.aSnippetIsBeingEdited();
    final snippetName =
        bloc.state.activeSnippetName ??
        bloc.state.snippetBeingEdited?.getRootNode().name;

    return Stack(
      children: [
        if (!showSnippet) Zoomer(key: zoomerGk, child: widget.child),
        if (showSnippet)
          SnippetBuilder(
            // the snippet should already exist in the cache at this point
            initialValue: TextNode(
              name: snippetName,
              text: 'Missing Snippet: $snippetName !',
              tsPropGroup: TextStyleProperties(color: ColorModel.red())
            ),
            onLayoutDone: () {
              if (_needsToPopulateRects && mounted) {
                if (bloc.showTappableBorderRects()) {
                  fsdui.showToast(
                    msg: 'tap a node to start editing,\n<Esc> to cancel',
                    removeAfterMs: 5000,
                    bgColor: Colors.purpleAccent.withValues(alpha: .8),
                    textColor: Colors.yellow,
                    width: 240,
                    height: 120,
                  );
                }
                setState(() {
                  _populateNodeBorderRects();
                  _needsToPopulateRects = false;
                });
              }
            },
            onScrollF: (_) => setState(_populateNodeBorderRects),
          ),
        if (showSnippet && borderRects.isNotEmpty)
          TappableNodeBorders(
            renderData: borderRects,
            onNodeTapped: (node) {
              if (bloc.aSnippetIsBeingEdited()) {
                fsdui.dismiss('pink-overlay');
                bloc.add(CAPIEvent.selectNode(node: node));
                fsdui.afterNextBuildDo(() => SNodeWidget.pointOutSelectedNode());
              } else {
                if (node is QuillTextNode || node is MarkdownNode) return;
                _tappedToEditSnippetAndSelectNode(node);
              }
            },
          ),
      ],
    );
  }

  static final String cid_EditorPassword = "editor-password";

  void editorPasswordDialog() {
    fsdui.registerKeystrokeHandler(cid_EditorPassword, (KeyEvent event) {
      // final key = event.logicalKey.keyLabel;

      // if (event is KeyDownEvent) {
      //   print("Key down: $key");
      // } else if (event is KeyUpEvent) {
      //   print("Key up: $key");
      // } else if (event is KeyRepeatEvent) {
      //   print("Key repeat: $key");
      // }

      if (event.logicalKey == LogicalKeyboardKey.escape) {
        fsdui.dismiss(cid_EditorPassword);
      }

      return false;
    });
    // final gk = GlobalKey();
    fsdui.showOverlay(
      calloutContent: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          margin: EdgeInsets.all(12),
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fsdui.purpleText(
                "Editor Access\n",
                fontSize: 24,
                family: 'Merriweather',
              ),

              StringOrNumberEditor(
                inputType: String,
                prompt: () => 'password',
                originalS: '',
                onTextChangedF: (String s) async {
                  // print(s);
                  if (fsdui.appInfo.superEditorPasswords.contains(s)) {
                    fsdui.dismissAll();
                    fsdui.capiBloc.add(CAPIEvent.signedInAsSuperEditor());
                  } else if (fsdui.appInfo.articleEditorPasswords.contains(s)) {
                    fsdui.dismissAll();
                    fsdui.capiBloc.add(CAPIEvent.signedInAsArticleEditor());
                  } else if (s == 'GUEST') {
                    fsdui.dismissAll();
                    fsdui.capiBloc.add(CAPIEvent.signedInAsGuestEditor());
                  }
                },
                onEscapedF: (_) {
                  fsdui.dismiss(cid_EditorPassword);
                },
                dontAutoFocus: false,
                isPassword: true,
                onEditingCompleteF: (s) {
                  // if (s == "lakebeachocean") {
                  //   FCO.om.remove("TrainerPassword".hashCode);
                  //   setState(() {
                  //     HydratedBloc.storage.write("trainerIsSignedIn", true);
                  //   });
                  // }
                },
              ),
              Text.rich(
                TextSpan(
                  text: '\n\nAnonymous Users:\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'If you\'d like to see how editing works in an\n'
                          'app built with our ',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: 'fsdui',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' package,\nuse password "GUEST".\n'
                          'Any changes you make will be discarded when\n'
                          'you leave this browser tab, or sign out.',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      calloutConfig: CalloutConfig(
        cId: cid_EditorPassword,
        // initialTargetAlignment: Alignment.bottomLeft,
        // initialCalloutAlignment: Alignment.topRight,
        // finalSeparation: 200,
        barrier: CalloutBarrierConfig(
          opacity: .5,
          onTappedF: () async {
            fsdui.dismiss(cid_EditorPassword);
          },
        ),
        // initialCalloutW: 300,
        // initialCalloutH: 240,
        // decorationBorderRadius: 12,
        // // arrowType: ArrowTypeEnumModel.THIN_REVERSED,
        // decorationFillColors: ColorOrGradient.color(Colors.white),
        onDismissedF: () {
          fsdui.removeKeystrokeHandler(cid_EditorPassword);
        },
      ),
      // targetGkF: ()=> fco.authIconGK,
      wrapInPointerInterceptor: true,
      // targetGK: gk,
    );
  }

  static final String cid_editablePageName = "user-editable-page-name";

  void showPageNameDialog() {
    fsdui.registerKeystrokeHandler(cid_editablePageName, (KeyEvent event) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        fsdui.dismiss(cid_editablePageName);
      }
      return false;
    });
    fsdui.showOverlay(
      calloutContent: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          fsdui.purpleText(
            fsdui.canEditAnyContent()
                ? 'Create an editable Page'
                : 'Create your own editable Page',
            fontSize: 24,
            family: 'Merriweather',
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: 480,
            height: 100,
            child: StringOrNumberEditor(
              inputType: String,
              prompt: () => 'Page name',
              originalS: '',
              onTextChangedF: (String s) async {},
              onEscapedF: (_) {
                fsdui.dismiss(cid_editablePageName);
              },
              dontAutoFocus: false,
              onEditingCompleteF: (s) async {
                String pageName = s.replaceAll(' ', '-').toLowerCase();
                pageName = pageName.startsWith('/') ? pageName : '/$pageName';
                // add to appInfo
                if (!fsdui.canEditAnyContent() &&
                    !fsdui.appInfo.anonymousUserEditablePages.contains(
                      pageName,
                    )) {
                  // jsArray issue
                  List<String> newList = fsdui.appInfo.anonymousUserEditablePages
                      .toList();
                  newList.add(pageName);
                  fsdui.appInfo.anonymousUserEditablePages = newList;
                  await fsdui.modelRepo.saveAppInfo();
                  fsdui.afterNextBuildDo(() {
                    fsdui.dismiss(cid_editablePageName);
                    fsdui.addSubRoute(newPath: pageName);
                    fsdui.afterMsDelayDo(1000, () {
                      fsdui.router?.go(pageName);
                    });
                  });
                } else if (fsdui.canEditAnyContent() &&
                    !fsdui.appInfo.snippetNames.contains(pageName)) {
                  // fco.dismiss('exit-editMode');
                  // bool userCanEdit = canEditContent.isTrue;
                  final snippetName = pageName;
                  // final rootNode = SnippetTemplateEnum.empty.clone()
                  //   ..name = snippetName;
                  // SnippetRootNode.loadSnippetFromCacheOrFromFBOrCreateFromTemplate(
                  //   snippetName: snippetName,
                  //   templateSnippetRootNode: rootNode,
                  // ).then((_) {
                  //   fco.dismiss(cid_editablePageName);
                  //   fco.addSubRoute(
                  //     newPath: snippetName,
                  //     template: rootNode,
                  //   );
                  //   fco.router.go(pageName);
                  // });
                  fsdui.dismiss(cid_editablePageName);
                  fsdui.addSubRoute(newPath: snippetName);
                  fsdui.afterMsDelayDo(1000, () {
                    fsdui.router?.go(pageName);
                  });
                } else {
                  if (context.mounted) {
                    context.go(pageName);
                  }
                }
                return;
              },
            ),
          ),
        ],
      ),
      calloutConfig: CalloutConfig(
        cId: cid_editablePageName,
        // initialTargetAlignment: Alignment.bottomLeft,
        // initialCalloutAlignment: Alignment.topRight,
        // finalSeparation: 200,
        barrier: CalloutBarrierConfig(
          opacity: .5,
          onTappedF: () async {
            fsdui.dismiss(cid_editablePageName);
          },
        ),
        initialCalloutW: 500,
        initialCalloutH: 180,
        decorationBorderRadius: 12,
        decorationFillColors: ColorOrGradient.color(Colors.white),
        onDismissedF: () {
          fsdui.removeKeystrokeHandler(cid_editablePageName);
        },
      ),
      // targetGkF: ()=> fco.authIconGK,
    );
  }
}

class SelectionCutoutPainter extends CustomPainter {
  final Rect cutoutRect;

  SelectionCutoutPainter({required this.cutoutRect});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Create the background paint
    final backgroundPaint = Paint()
      ..color = Colors.black
          .withValues(alpha: 0.6) // Semi-transparent black
      ..style = PaintingStyle.fill;

    // 2. Create the cutout path
    final cutoutPath = Path()..addRect(cutoutRect);

    // 3. Create the full canvas path
    final fullCanvasPath = Path()..addRect(Offset.zero & size);

    // 4. Combine the paths using difference
    final combinedPath = Path.combine(
      PathOperation.difference,
      fullCanvasPath,
      cutoutPath,
    );

    // 5. Draw the combined path
    canvas.drawPath(combinedPath, backgroundPaint);
    canvas.drawRect(
      cutoutRect,
      Paint()
        ..color = Colors
            .transparent // Semi-transparent black
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is SelectionCutoutPainter &&
        oldDelegate.cutoutRect != cutoutRect;
  }
}

// First, define this helper class either in the same file or a utility file.
// This class overrides the default scroll physics for all descendant scrollables.
