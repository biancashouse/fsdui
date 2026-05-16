import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

sealed class CAPIEvent {}

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
