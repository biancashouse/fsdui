import 'dart:convert';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/model/quill_target_model.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_target_pointer_type.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillTextToolbar extends StatefulWidget {
  final QuillTextNode parentSNode;
  final FocusNode focusNode;
  final QuillController controller;

  const QuillTextToolbar({
    required this.parentSNode,
    required this.focusNode,
    required this.controller,

    super.key,
  });

  static void show({
    required QuillTextNode parentSNode,
    required FocusNode focusNode,
    required QuillController controller,
  }) {
    fsdui.showOverlay(
      onReadyF: () {},
      calloutConfig: CalloutConfig(
        cId: parentSNode.quillTextToolbarCID,

        decorationFillColors: ColorOrGradient.color(Colors.purpleAccent),
        initialCalloutW: 1200,
        initialCalloutH: 90,
        decorationShape: DecorationShape.rounded_rectangle(),
        decorationBorderRadius: 16,
        animatePointer: false,
        targetPointerType: TargetPointerType.none(),
        initialCalloutPos: OffsetModel.fromOffset(fsdui.quillTextToolbarPos()),
        onDragEndedF: (newPos) {
          fsdui.setQuillTextToolbarPos(newPos);
        },
        dragHandleHeight: 30,
        followScroll: false,
        onDismissedF: () {},
      ),
      calloutContent: QuillTextToolbar(
        parentSNode: parentSNode,
        focusNode: focusNode,
        controller: controller,
      ),
    );
  }

  @override
  State<QuillTextToolbar> createState() => QuillTextToolbarState();
}

class QuillTextToolbarState extends State<QuillTextToolbar> {
  // @override
  @override
  Widget build(BuildContext context) {
    // final name = widget.parentSNode.rootNodeOfSnippet()?.name;
    // final snippetInfo = fco.appInfo.cachedSnippetInfo(name!);
    // ValueNotifier<String>? notifier = snippetInfo?.getChangeNotifier();
    // IconData? closeOrSaveIcon(String newDeltaJson) => snippetInfo!.changesPending(newDeltaJson)
    //     ? Icons.save : Icons.close;

    final fontFamilyItems = {
      'merriweather': GoogleFonts.merriweather().fontFamily!,
      'hand-writing': GoogleFonts.damion().fontFamily!,
    };

    final fontSizeItems = {
      'Clear': 'clear',
      '10': '10',
      '12': '12',
      '14': '14',
      '16': '16',
      '18': '18',
      '24': '24',
      '36': '36',
    };

    final headerStyleItems = {
      'Normal': 'clear',
      'Heading 1': '1',
      'Heading 2': '2',
      'Heading 3': '3',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // CircleAvatar(backgroundColor:Colors.purple, minRadius: 20, child: toolbarVFlipIcon()),
        toolbarVFlipIcon(),
        const VerticalDivider(color: Colors.white, width: 2),

        IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: Container(
            color: Colors.purpleAccent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QuillAttributeMenuButton(
                  items: fsdui.googleFontMap, //fontFamilyItems,
                  controller: widget.controller,
                  attributeKey: Attribute.font.key,
                  defaultDisplayText: 'Font',
                  tooltip: 'font family',
                  parseValue: (raw) => raw,
                ),
                _QuillAttributeMenuButton(
                  items: fontSizeItems,
                  controller: widget.controller,
                  attributeKey: Attribute.size.key,
                  defaultDisplayText: 'Size',
                  tooltip: 'font size',
                  parseValue: (raw) =>
                      raw == 'clear' ? null : double.parse(raw),
                  formatUnmatchedValue: (value) => value is num
                      ? (value == value.roundToDouble()
                            ? value.toInt().toString()
                            : value.toString())
                      : value.toString(),
                ),
                _QuillAttributeMenuButton(
                  items: headerStyleItems,
                  controller: widget.controller,
                  attributeKey: Attribute.header.key,
                  defaultDisplayText: 'Normal',
                  tooltip: 'header style',
                  parseValue: (raw) => raw == 'clear' ? null : int.parse(raw),
                ),
                QuillSimpleToolbar(
                  controller: widget.controller,
                  config: QuillSimpleToolbarConfig(
                    decoration: const BoxDecoration(color: Colors.purpleAccent),
                    toolbarIconAlignment: WrapAlignment.start,
                    toolbarIconCrossAlignment: WrapCrossAlignment.start,
                    showFontFamily: false,
                    showFontSize: false,
                    showHeaderStyle: false,
                    showClipboardCopy: true,
                    showClipboardPaste: true,
                    showSubscript: false,
                    showSuperscript: false,
                    showStrikeThrough: false,
                    showListCheck: false,
                    showInlineCode: false,
                    showCodeBlock: false,
                    showIndent: false,
                    showLink: false,
                    showSearchButton: false,
                    customButtons: [_helpIconBtn(widget.controller)],
                    buttonOptions: QuillSimpleToolbarButtonOptions(
                      base: QuillToolbarBaseButtonOptions(
                        afterButtonPressed: () {
                          final isDesktop = {
                            TargetPlatform.linux,
                            TargetPlatform.windows,
                            TargetPlatform.macOS,
                          }.contains(defaultTargetPlatform);
                          if (isDesktop) {
                            widget.focusNode.requestFocus();
                          }
                        },
                      ),
                      linkStyle: QuillToolbarLinkStyleButtonOptions(
                        validateLink: (link) => true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const VerticalDivider(color: Colors.white, width: 2),
        IconButton(
          tooltip: 'close this toolbar',
          icon: const Icon(Icons.close, color: Colors.white, size: 48),
          // icon: ValueListenableBuilder(
          //   valueListenable: notifier!,
          //   builder: (context, value, child) {
          //     return Icon(
          //         closeOrSaveIcon(value),
          //         color: Colors.white);
          //   }
          // ),
          onPressed: () {
            final rootNode = widget.parentSNode.rootNodeOfSnippet();
            if (rootNode != null) {
              // notify possible changes to the quill text (controller)
              fsdui.appInfo
                  .cachedSnippetInfo(rootNode.name!)
                  ?.notifyChange(rootNode);
            }
            fsdui.removeParentCallout(context);
            // fco.dismiss(widget.parentSNode.quillTextToolbarCID, skipOnDismiss: true);
            fsdui.quillTextToolbarCIDVN.value = null;
          },
        ),
        const VerticalDivider(color: Colors.white, width: 2),
        toolbarVFlipIcon(),
      ],
    );
  }

  Widget toolbarVFlipIcon() => IconButton(
    onPressed: () {
      fsdui.dismiss(
        widget.parentSNode.quillTextToolbarCID,
        skipOnDismiss: true,
      );
      fsdui.quillTextToolbarAtTopOfScreen =
          !fsdui.quillTextToolbarAtTopOfScreen;
      QuillTextToolbar.show(
        parentSNode: widget.parentSNode,
        focusNode: widget.focusNode,
        controller: widget.controller,
      );
    },
    tooltip: fsdui.quillTextToolbarAtTopOfScreen
        ? 'move toolbar down'
        : 'move toolbar up',
    icon: Icon(
      fsdui.quillTextToolbarAtTopOfScreen
          ? Icons.arrow_downward
          : Icons.arrow_upward,
      color: Colors.white,
      size: 48,
    ),
  );

  QuillToolbarCustomButtonOptions _helpIconBtn(
    QuillController controller,
  ) => QuillToolbarCustomButtonOptions(
    icon: SizedBox(
      width: 30,
      child: Stack(
        children: const [
          Icon(Icons.info_outline_rounded, size: 20),
          Align(
            alignment: AlignmentGeometry.topRight,
            child: Icon(Icons.add, size: 10, color: Colors.white),
          ),
        ],
      ),
    ),
    tooltip: 'Insert a help Button',
    onPressed: () {
      QuillTargetModel? qt = _createQuillTarget();
      if (qt == null) return;

      final index = controller.selection.baseOffset;
      final length = controller.selection.extentOffset - index;

      controller.replaceText(
        index,
        length,
        BlockEmbed.custom(
          CustomBlockEmbed('quill-help-icon-button', jsonEncode(qt.toMap())),
        ),
        null,
      );

      widget.parentSNode.deltaJsonString = jsonEncode(
        controller.document.toDelta().toJson(),
      );

      var snippet = widget.parentSNode.rootNodeOfSnippet();
      if (snippet != null) {
        // fco.modelRepo.saveNewVersionOfSnippet(snippet);
        fsdui.appInfo.cachedSnippetInfo(snippet.name!)?.notifyChange(snippet);
      }
    },
  );

  QuillTargetModel? _createQuillTarget() {
    if (!fsdui.canEditAnyContent()) return null;

    TargetId newTargetId = DateTime.now().millisecondsSinceEpoch;
    return QuillTargetModel(
      uid: newTargetId,
      calloutDurationMs: 2000,
      calloutFillColors: UpTo6Colors(color1: Colors.white),
      targetPointerTypeEnum: TargetPointerTypeEnum.WAVY,
    );
  }
}

// Built by hand (rather than relying on flutter_quill's built-in font-family
// / font-size buttons) so we can observe MenuAnchor's onOpen/onClose
// directly. That popup renders in its own OverlayEntry — a structural
// sibling of this toolbar, not a focus/widget-tree descendant — so there's
// no other reliable way to tell FocusAwareQuillEditor's focus-loss handler
// "a popup is open, don't dismiss the toolbar".
//
// Uses InkWell (sized to fit its label + arrow) rather than IconButton:
// IconButton forces its `icon` into a small fixed square, so a
// variable-width label like a font name would overflow outside the actual
// tappable area — the label would be visible but not tappable.
class _QuillAttributeMenuButton extends StatefulWidget {
  final Map<String, String> items;
  final QuillController controller;
  final String attributeKey;
  final String defaultDisplayText;
  final String tooltip;

  // Converts a selected item's raw value into the value stored via
  // Attribute.fromKeyValue. Return null to clear the attribute.
  final dynamic Function(String rawValue) parseValue;

  // Formats the current attribute value for display when it's set but
  // doesn't match any preset in [items] (e.g. a font size from pasted/
  // imported content that isn't one of the dropdown's fixed choices).
  // If omitted, an unmatched value falls back to [defaultDisplayText].
  final String Function(dynamic value)? formatUnmatchedValue;

  const _QuillAttributeMenuButton({
    required this.items,
    required this.controller,
    required this.attributeKey,
    required this.defaultDisplayText,
    required this.tooltip,
    required this.parseValue,
    this.formatUnmatchedValue,
  });

  @override
  State<_QuillAttributeMenuButton> createState() =>
      _QuillAttributeMenuButtonState();
}

class _QuillAttributeMenuButtonState extends State<_QuillAttributeMenuButton> {
  final _menuController = MenuController();

  String get _currentValue {
    final attribute = widget.controller
        .getSelectionStyle()
        .attributes[widget.attributeKey];
    if (attribute == null) return widget.defaultDisplayText;
    for (final entry in widget.items.entries) {
      if (widget.parseValue(entry.value) == attribute.value) return entry.key;
    }
    return widget.formatUnmatchedValue?.call(attribute.value) ??
        widget.defaultDisplayText;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(_QuillAttributeMenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _menuController,
      onOpen: () => fsdui.quillToolbarOpenPopupCount++,
      onClose: () => fsdui.quillToolbarOpenPopupCount--,
      menuChildren: [
        for (final entry in widget.items.entries)
          MenuItemButton(
            onPressed: () => widget.controller.formatSelection(
              Attribute.fromKeyValue(
                widget.attributeKey,
                widget.parseValue(entry.value),
              ),
            ),
            child: Text(entry.key),
          ),
      ],
      builder: (context, menuController, child) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (menuController.isOpen) {
              menuController.close();
            } else {
              menuController.open();
            }
          },
          child: Tooltip(
            message: widget.tooltip,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _currentValue,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
