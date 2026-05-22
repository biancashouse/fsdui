import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

sealed class CAPIEvent {
  CAPIEvent();
  factory CAPIEvent.verifiedEa({required String ea}) = VerifiedEa;
  factory CAPIEvent.signedInAsSuperEditor() = SignedInAsSuperEditor;
  factory CAPIEvent.signedInAsArticleEditor() = SignedInAsArticleEditor;
  factory CAPIEvent.signedInAsGuestEditor() = SignedInAsGuestEditor;
  factory CAPIEvent.signedOut() = SignedOut;
  factory CAPIEvent.overrideTargetGK({required String wName, required int index, required GlobalKey gk}) = OverrideTargetGK;
  factory CAPIEvent.forceRefresh({bool onlyTargetsWrappers = false}) => ForceRefresh(onlyTargetsWrappers: onlyTargetsWrappers);
  factory CAPIEvent.toggleSnippetVisibility({SnippetName? snippetName}) = ToggleSnippetVisibility;
  factory CAPIEvent.clearClipboard() = ClearClipboard;
  factory CAPIEvent.publishSnippet({required SnippetName snippetName, required VersionId versionId}) = PublishSnippet;
  factory CAPIEvent.revertSnippet({required SnippetName snippetName, required VersionId versionId}) = RevertSnippet;
  factory CAPIEvent.deletePage({required String pathName}) = DeletePage;
  factory CAPIEvent.toggleAutoPublishingOfSnippet({required SnippetName snippetName}) = ToggleAutoPublishingOfSnippet;
  factory CAPIEvent.autoPublishDefault({required bool b}) = AutoPublishDefault;
  factory CAPIEvent.setPanelSnippet({required SnippetName snippetName, required PanelName panelName}) = SetPanelSnippet;
  factory CAPIEvent.enterSelectWidgetMode({required SnippetName snippetName}) = EnterSelectWidgetMode;
  factory CAPIEvent.updateTappableRects() = UpdateTappableRects;
  factory CAPIEvent.exitSelectWidgetMode() = ExitSelectWidgetMode;
  factory CAPIEvent.pushSnippetEditor({required SNode rootNode, SNode? selectedNode}) = PushSnippetEditor;
  factory CAPIEvent.changedSnippet() = ChangedSnippet;
  factory CAPIEvent.popSnippetEditor({bool save = false}) => PopSnippetEditor(save: save);
  factory CAPIEvent.showDirectoryTree() = ShowDirectoryTree;
  factory CAPIEvent.removeDirectoryTree({bool save = false}) => RemoveDirectoryTree(save: save);
  factory CAPIEvent.selectNode({required SNode node}) = SelectNode;
  factory CAPIEvent.clearNodeSelection() = ClearNodeSelection;
  factory CAPIEvent.saveNodeAsSnippet({required SNode node, required String newSnippetName}) = SaveNodeAsSnippet;
  factory CAPIEvent.replaceSelectionWith({Type? nodeType, SNode? testNode}) = ReplaceSelectionWith;
  factory CAPIEvent.wrapSelectionWith({Type? nodeType, SNode? testNode}) = WrapSelectionWith;
  factory CAPIEvent.appendChild({Type? nodeType, SNode? testNode}) = AppendChild;
  factory CAPIEvent.prependArticle({required ArticleListViewNode listNode, Type? nodeType, SNode? testNode}) = PrependArticle;
  factory CAPIEvent.addSiblingBefore({Type? nodeType, SNode? testNode}) = AddSiblingBefore;
  factory CAPIEvent.addSiblingAfter({Type? nodeType, SNode? testNode}) = AddSiblingAfter;
  factory CAPIEvent.pasteReplacement() = PasteReplacement;
  factory CAPIEvent.pasteChild() = PasteChild;
  factory CAPIEvent.pasteSiblingBefore() = PasteSiblingBefore;
  factory CAPIEvent.pasteSiblingAfter() = PasteSiblingAfter;
  factory CAPIEvent.deleteNodeTapped() = DeleteNodeTapped;
  factory CAPIEvent.deleteArticle({required SNode articleSnippet}) = DeleteArticle;
  factory CAPIEvent.completeDeletion() = CompleteDeletion;
  factory CAPIEvent.copySnippetJsonToClipboard({required SNode rootNode}) = CopySnippetJsonToClipboard;
  factory CAPIEvent.replaceSnippetFromJson({required String snippetBeingReplaced, required String? snippetJson}) = ReplaceSnippetFromJson;
  factory CAPIEvent.copyNode({required SNode node}) = CopyNode;
  factory CAPIEvent.cutNode({required SNode node}) = CutNode;
  factory CAPIEvent.selectedDirectoryOrNode({required SnippetName snippetName, required SNode? selectedNode}) = SelectedDirectoryOrNode;
  factory CAPIEvent.imageChanged({Uint8List? newBytes}) = ImageChanged;
  factory CAPIEvent.undo() = Undo;
  factory CAPIEvent.redo() = Redo;
  factory CAPIEvent.forceSnippetRefresh() = ForceSnippetRefresh;
  factory CAPIEvent.reorderSibling({required SNode node, required int newSiblingIndex}) = ReorderSibling;
  factory CAPIEvent.toggleNodeProperties() = ToggleNodeProperties;
}

final class VerifiedEa extends CAPIEvent {
  final String ea;

  VerifiedEa({required this.ea});
}

final class SignedInAsSuperEditor extends CAPIEvent {
SignedInAsSuperEditor();
}

final class SignedInAsArticleEditor extends CAPIEvent {
SignedInAsArticleEditor();
}

final class SignedInAsGuestEditor extends CAPIEvent {
SignedInAsGuestEditor();
}

final class SignedOut extends CAPIEvent {
SignedOut();
}

final class OverrideTargetGK extends CAPIEvent {
OverrideTargetGK({
    required this.wName,
    required this.index,
    required this.gk,
  });
  final String wName;
  final int index;
  final GlobalKey gk;
}

final class ForceRefresh extends CAPIEvent {
ForceRefresh({this.onlyTargetsWrappers = false});
  final bool onlyTargetsWrappers;
}

final class ToggleSnippetVisibility extends CAPIEvent {
ToggleSnippetVisibility({this.snippetName});
  final SnippetName? snippetName;
}

final class ClearClipboard extends CAPIEvent {
ClearClipboard();
}

final class PublishSnippet extends CAPIEvent {
PublishSnippet({
    required this.snippetName,
    required this.versionId,
  });
  final SnippetName snippetName;
  final VersionId versionId;
}

final class RevertSnippet extends CAPIEvent {
RevertSnippet({
    required this.snippetName,
    required this.versionId,
  });
  final SnippetName snippetName;
  final VersionId versionId;
}

final class DeletePage extends CAPIEvent {
DeletePage({required this.pathName});
  final String pathName;
}

final class ToggleAutoPublishingOfSnippet extends CAPIEvent {
ToggleAutoPublishingOfSnippet({required this.snippetName});
  final SnippetName snippetName;
}

final class AutoPublishDefault extends CAPIEvent {
AutoPublishDefault({required this.b});
  final bool b;
}

final class SetPanelSnippet extends CAPIEvent {
SetPanelSnippet({
    required this.snippetName,
    required this.panelName,
  });
  final SnippetName snippetName;
  final PanelName panelName;
}

final class EnterSelectWidgetMode extends CAPIEvent {
EnterSelectWidgetMode({required this.snippetName});
  final SnippetName snippetName;
}

final class UpdateTappableRects extends CAPIEvent {
UpdateTappableRects();
}

final class ExitSelectWidgetMode extends CAPIEvent {
ExitSelectWidgetMode();
}

final class PushSnippetEditor extends CAPIEvent {
  PushSnippetEditor({
    required this.rootNode,
    this.selectedNode,
  });
  final SNode rootNode;
  final SNode? selectedNode;
}

final class ChangedSnippet extends CAPIEvent {
ChangedSnippet();
}

final class PopSnippetEditor extends CAPIEvent {
PopSnippetEditor({this.save = false});
  final bool save;
}

final class ShowDirectoryTree extends CAPIEvent {
ShowDirectoryTree();
}

final class RemoveDirectoryTree extends CAPIEvent {
RemoveDirectoryTree({this.save = false});
  final bool save;
}

final class SelectNode extends CAPIEvent {
  SelectNode({required this.node});
  final SNode node;
}

final class ClearNodeSelection extends CAPIEvent {
ClearNodeSelection();
}

final class SaveNodeAsSnippet extends CAPIEvent {
  SaveNodeAsSnippet({
    required this.node,
    required this.newSnippetName,
  });
  final SNode node;
  final String newSnippetName;
}

final class ReplaceSelectionWith extends CAPIEvent {
  ReplaceSelectionWith({this.nodeType, this.testNode});
  final Type? nodeType;
  final SNode? testNode;
}

final class WrapSelectionWith extends CAPIEvent {
  WrapSelectionWith({this.nodeType, this.testNode});
  final Type? nodeType;
  final SNode? testNode;
}

final class AppendChild extends CAPIEvent {
  AppendChild({this.nodeType, this.testNode});
  final Type? nodeType;
  final SNode? testNode;
}

final class PrependArticle extends CAPIEvent {
  PrependArticle({
    required this.listNode,
    this.nodeType,
    this.testNode,
  });
  final ArticleListViewNode listNode;
  final Type? nodeType;
  final SNode? testNode;
}

final class AddSiblingBefore extends CAPIEvent {
  AddSiblingBefore({this.nodeType, this.testNode});
  final Type? nodeType;
  final SNode? testNode;
}

final class AddSiblingAfter extends CAPIEvent {
  AddSiblingAfter({this.nodeType, this.testNode});
  final Type? nodeType;
  final SNode? testNode;
}

final class PasteReplacement extends CAPIEvent {
PasteReplacement();
}

final class PasteChild extends CAPIEvent {
PasteChild();
}

final class PasteSiblingBefore extends CAPIEvent {
PasteSiblingBefore();
}

final class PasteSiblingAfter extends CAPIEvent {
PasteSiblingAfter();
}

final class DeleteNodeTapped extends CAPIEvent {
DeleteNodeTapped();
}

final class DeleteArticle extends CAPIEvent {
  DeleteArticle({required this.articleSnippet});
  final SNode articleSnippet;
}

final class CompleteDeletion extends CAPIEvent {
CompleteDeletion();
}

final class CopySnippetJsonToClipboard extends CAPIEvent {
  CopySnippetJsonToClipboard({required this.rootNode});
  final SNode rootNode;
}

final class ReplaceSnippetFromJson extends CAPIEvent {
ReplaceSnippetFromJson({
    required this.snippetBeingReplaced,
    required this.snippetJson,
  });
  final String snippetBeingReplaced;
  final String? snippetJson;
}

final class CopyNode extends CAPIEvent {
  CopyNode({required this.node});
  final SNode node;
}

final class CutNode extends CAPIEvent {
  CutNode({required this.node});
  final SNode node;
}

final class SelectedDirectoryOrNode extends CAPIEvent {
  SelectedDirectoryOrNode({
    required this.snippetName,
    required this.selectedNode,
  });
  final SnippetName snippetName;
  final SNode? selectedNode;
}

final class ImageChanged extends CAPIEvent {
  final Uint8List? newBytes;
  ImageChanged({this.newBytes});
}

final class Undo extends CAPIEvent {
Undo();
}

final class Redo extends CAPIEvent {
Redo();
}

final class ForceSnippetRefresh extends CAPIEvent {
ForceSnippetRefresh();
}

final class ReorderSibling extends CAPIEvent {
  ReorderSibling({required this.node, required this.newSiblingIndex});
  final SNode node;
  final int newSiblingIndex;
}

final class ToggleNodeProperties extends CAPIEvent {
  ToggleNodeProperties();
}
