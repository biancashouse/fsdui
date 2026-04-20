import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/fancy_tree/tree_controller.dart';
import 'package:fsdui/src/snippet/fancy_tree/tree_indentation.dart';
import 'package:fsdui/src/snippet/fancy_tree/tree_view.dart';
import 'package:fsdui/src/snippet/snode_widget.dart';
import '../../bloc/snippet_being_edited.dart' show SnippetBeingEdited;

class SnippetTreeView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final SnippetTreeController? treeC = snippetBeingEdited.treeC;
    if (treeC == null) {
      return Error(
        "SnippetTreeView",
        color: Colors.green,
        size: 32,
        errorMsg: "null treeC!",
        key: GlobalKey(),
      );
    }
    return TreeView<SNode>(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      treeController: treeC,
      nodeBuilder: (BuildContext context, TreeEntry<SNode> entry) =>
          _treeIndentation(entry, treeC),
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
      snippetName: snippetBeingEdited.getRootNode().name ?? 'snippet name ?',
      treeController: treeC,
      entry: entry,
    ),
  );
}
