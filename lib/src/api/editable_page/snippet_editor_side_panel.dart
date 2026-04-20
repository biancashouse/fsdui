import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/api/editable_page/snippet_properties_tree_view.dart';
import 'package:fsdui/src/api/editable_page/snippet_tree_view.dart';
import 'package:fsdui/src/snippet/snode_widget.dart';
import 'package:fsdui/src/snippet/snodes/hotspots/widgets/hotspot_target_config_toolbar/hotspot_target_config_toolbar.dart';

const double kSidePanelWidth = 420.0;

/// Self-contained side panel shown over the live page during snippet editing.
/// The page content remains fully visible behind the panel.
class SnippetEditorSidePanel extends StatefulWidget {
  const SnippetEditorSidePanel({super.key});

  // only ever one side panel
  static OverlayEntry? _overlayEntry;

  static void showSidePanelOverlay(BuildContext context) {
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (_) => BlocProvider.value(
        value: fsdui.capiBloc,
        child: const SnippetEditorSidePanel(),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideSidePanelOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  State<SnippetEditorSidePanel> createState() => _SnippetEditorSidePanelState();
}

class _SnippetEditorSidePanelState extends State<SnippetEditorSidePanel> {
  late bool _isRight;

  @override
  void initState() {
    super.initState();
    // Restore the last known panel side so the overlay clip stays correct
    // across panel close/reopen cycles.
    _isRight = fsdui.snippetEditorPanelOnRight;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: _isRight ? Alignment.centerRight : Alignment.centerLeft,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      child: SizedBox(
        width: kSidePanelWidth,
        height: double.infinity,
        child: Material(
          elevation: 8,
          child: Column(
            children: [
              _PanelHeader(
                isRight: _isRight,
                onFlip: () => setState(() {
                  _isRight = !_isRight;
                  fsdui.snippetEditorPanelOnRight = _isRight;
                  // Recreate the selected-node overlay with the updated clip region.
                  fsdui.dismiss('pink-overlay');
                  fsdui.afterNextBuildDo(
                    () => SNodeWidget.pointOutSelectedNode(),
                  );
                }),
              ),
              const Expanded(child: _PanelBody()),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  final bool isRight;
  final VoidCallback onFlip;

  const _PanelHeader({required this.isRight, required this.onFlip});

  @override
  Widget build(BuildContext context) {
    final snippetName = fsdui.snippetBeingEdited?.getRootNode().name ?? '?';
    final snippetInfo = fsdui.appInfo.cachedSnippetInfo(snippetName);

    return Container(
      color: Colors.purple,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 48,
      child: Row(
        children: [
          if (isRight)
            IconButton(
              tooltip: 'Move panel to left',
              icon: Icon(Icons.arrow_circle_left, color: Colors.white),
              onPressed: onFlip,
            ),
          Expanded(
            child: fsdui.coloredText(
              snippetName,
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          _UndoRedoButtons(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => _close(snippetName, snippetInfo),
          ),
          if (!isRight)
            IconButton(
              tooltip: 'Move panel to right',
              icon: Icon(Icons.arrow_circle_right, color: Colors.white),
              onPressed: onFlip,
            ),
        ],
      ),
    );
  }

  void _close(String snippetName, SnippetInfoModel? snippetInfo) {
    if (SNode.isHotspotCalloutContent(snippetName)) {
      fsdui.dismissAll();
    } else {
      fsdui.dismiss('selected-node');
      fsdui.unhide(HotspotTargetConfigToolbar.CID);
      fsdui.appInfo.hideClipboard();
    }
    fsdui.dismissAll();
    fsdui.capiBloc.add(const CAPIEvent.popSnippetEditor());
    final rootNode = snippetInfo?.currentVersionInCache();
    if (rootNode != null) {
      snippetInfo!.getChangeNotifier().value = rootNode.toJson();
    }
  }
}

class _UndoRedoButtons extends StatelessWidget {
  const _UndoRedoButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CAPIBloC, CAPIState>(
      buildWhen: (prev, curr) => prev.force != curr.force,
      builder: (context, state) {
        final undoRedo = state.snippetBeingEdited?.undoRedo;
        final canUndo = undoRedo?.canUndo ?? false;
        final canRedo = undoRedo?.canRedo ?? false;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Undo (${undoRedo?.undoCount ?? 0})',
              icon: const Icon(Icons.undo, size: 24),
              color: Colors.white,
              disabledColor: Colors.white24,
              onPressed: canUndo
                  ? () => fsdui.capiBloc.add(const CAPIEvent.undo())
                  : null,
            ),
            IconButton(
              tooltip: 'Redo (${undoRedo?.redoCount ?? 0})',
              icon: const Icon(Icons.redo, size: 24),
              color: Colors.white,
              disabledColor: Colors.white24,
              onPressed: canRedo
                  ? () => fsdui.capiBloc.add(const CAPIEvent.redo())
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _PanelBody extends StatelessWidget {
  const _PanelBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CAPIBloC, CAPIState>(
      // selectedNode is mutated in-place before emit, so reference comparisons
      // always appear equal. Use force (which _selectNode always increments)
      // as the actual rebuild signal, same pattern as the BlocListener.
      buildWhen: (prev, curr) => prev.force != curr.force,
      builder: (context, state) {
        final selectedNode = state.snippetBeingEdited?.selectedNode;
        final pTreeC = selectedNode?.pTreeC(context, {});

        return Column(
          children: [
            Expanded(child: _TreeArea()),
            if (pTreeC != null) ...[
              const Divider(height: 1, thickness: 1, color: Colors.purple),
              Expanded(
                child: _PropertiesArea(
                  selectedNode: selectedNode!,
                  pTreeC: pTreeC,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TreeArea extends StatefulWidget {
  const _TreeArea();

  @override
  State<_TreeArea> createState() => _TreeAreaState();
}

class _TreeAreaState extends State<_TreeArea> {
  final ScrollController _scrollController = ScrollController();
  SNode? _lastScrolledNode;

  @override
  void initState() {
    super.initState();
    // BlocListener only fires on changes, so handle the initial selection here.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final node = fsdui.capiBloc.state.snippetBeingEdited?.selectedNode;
      if (node != null) {
        _lastScrolledNode = node;
        _scrollToSelectedNode(node);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedNode(SNode node) {
    // Defer to post-frame so layout has settled (properties panel appearing
    // changes the tree's available height before we scroll).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctx = node.nodeGK?.currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: 0.5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CAPIBloC, CAPIState>(
      // _selectNode mutates snippetBeingEdited in-place then bumps force,
      // so selectedNode comparisons see the same mutated value on both sides.
      // Listen on force instead and guard with our own last-scrolled tracker.
      listenWhen: (prev, curr) => prev.force != curr.force,
      listener: (_, state) {
        final node = state.snippetBeingEdited?.selectedNode;
        if (node != null && node != _lastScrolledNode) {
          _lastScrolledNode = node;
          _scrollToSelectedNode(node);
        }
      },
      builder: (BuildContext context, CAPIState state) => GestureDetector(
        onTap: () {
          fsdui.dismissAll();
          fsdui.capiBloc.add(CAPIEvent.clearNodeSelection());
          fsdui.hide('floating-clipboard');
        },
        child: Material(
          color: Colors.purple.shade200,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            child: SnippetTreeView(shrinkWrap: true, snippetBeingEdited: state.snippetBeingEdited!),
          ),
        ),
      ),
    );
  }
}

class _PropertiesArea extends StatelessWidget {
  final SNode selectedNode;
  final PNodeTreeController pTreeC;

  const _PropertiesArea({required this.selectedNode, required this.pTreeC});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
        title: fsdui.coloredText('Properties', color: Colors.white),
      ),
      body: Material(
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InteractiveViewer(
            transformationController: fsdui.propertiesTreeTC,
            alignment: Alignment.topLeft,
            constrained: false,
            child: SizedBox(
              width: kSidePanelWidth - 20,
              height: 1000,
              child: PropertiesTreeView(treeC: pTreeC, sNode: selectedNode),
            ),
          ),
        ),
      ),
    );
  }
}
