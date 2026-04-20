import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/text_styles/container_style_suggestions.dart';
import 'package:fsdui/src/text_styles/style_name_editor.dart';

class ContainerStyleNameSearchAnchor extends StatefulWidget {
  final CalloutId? parentCId;
  final ContainerStyleProperties buttonStyle;
  final StyleNameChangeCallback onHoveredF;
  final StyleNameChangeCallback onSelectionF;
  final Debouncer debouncer;
  final String tooltipMsg;

  const ContainerStyleNameSearchAnchor({
    this.parentCId,
    required this.buttonStyle,
    required this.onHoveredF,
    required this.onSelectionF,
    required this.debouncer,
    required this.tooltipMsg,
    super.key,
  });

  static ContainerStyleNameSearchAnchorState? of(BuildContext context) {
    if (!context.mounted) {
      fsdui.logger.i('context not mounted!');
    }
    var result = context.findAncestorStateOfType<ContainerStyleNameSearchAnchorState>();
    if (result == null) {
      fsdui.logger.i('SearchAnchor not found!');
    }
    return result;
  }

  @override
  // ignore: no_logic_in_create_state
  State<ContainerStyleNameSearchAnchor> createState() => ContainerStyleNameSearchAnchorState();
}

class ContainerStyleNameSearchAnchorState extends State<ContainerStyleNameSearchAnchor> {
  final layerLink = LayerLink();
  OverlayEntry? entry;
  late TextEditingController searchStringTEC;
  final FocusNode focusNode = FocusNode();

  String? originalStyleName;
  late bool madeASelection;

  @override
  void initState() {
    super.initState();
    madeASelection = false;
    originalStyleName = fsdui.findContainerStyleName(fsdui.appInfo, widget.buttonStyle);
    searchStringTEC = TextEditingController(text: originalStyleName);
  }

  @override
  void dispose() {
    super.dispose();
    dismissSuggestionsOverlay();
    if (!madeASelection) {
      widget.onSelectionF(originalStyleName);
    }
  }

  @override
  Widget build(BuildContext context) {
    fsdui.afterMsDelayDo(50, () {
      focusNode.requestFocus();
    });
    return TapRegion(
      onTapInside: (e) {
        showContainerStyleSuggestionsOverlay();
      },
      // onTapOutside: (e) {
      //   dismissSuggestionsOverlay();
      // },
      child: CompositedTransformTarget(
        link: layerLink,
        child: StyleNameEditor(
          teC: searchStringTEC,
          focusNode: focusNode,
          onChangeF: (s) {
            widget.buttonStyle.lastSearchString = s;
            dismissSuggestionsOverlay();
            showContainerStyleSuggestionsOverlay();
          },
          onEditingCompleteF: () {},
          label: 'Container Style Search',
          tooltip: widget.tooltipMsg,
        ),
      ),
    );
  }

  void showContainerStyleSuggestionsOverlay() {
    if (entry == null) {
      fsdui.logger.d('showSuggestionsOverlay()');
      final renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      entry = OverlayEntry(builder: (_) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + renderBox.size.height + 16,
          width: renderBox.size.width,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, renderBox.size.height),
            child: ContainerStyleNameSuggestions(
              anchorContext: context,
              searchString: searchStringTEC.text, //widget.textStyle.lastSearchString??'',
              suggestions: fsdui.namedContainerStyles.keys.toList(),
              onHoverF: (hoveredContainerStyleName) {
                if (widget.buttonStyle.lastHoveredSuggestion != hoveredContainerStyleName) {
                  widget.debouncer.run(() {
                    if (widget.parentCId == null || fsdui.anyPresent([
                      widget.parentCId!
                    ])) {
                      setState(() {
                        fsdui.logger.d('onHoverF - suggestedContainerStyleName = $hoveredContainerStyleName');
                        widget.buttonStyle.lastHoveredSuggestion = hoveredContainerStyleName;
                        fsdui.afterNextBuildDo(() {
                          widget.onHoveredF(hoveredContainerStyleName);
                        });
                      });
                    }
                  });
                }
              },
              onSelectionF: (selectedContainerStyleName) {
                setState(() {
                  madeASelection = true;
                  widget.debouncer.cancel();
                  // widget.searchStringTEC.text = suggestedTextStyleName;
                  widget.onSelectionF(selectedContainerStyleName);
                  dismissSuggestionsOverlay();
                  if (widget.parentCId != null) {
                    fsdui.dismiss(widget.parentCId!);
                  }
                });
              },
            ),
          ),
        );
      });
      Overlay.of(context).insert(entry!);
    } else {
      fsdui.logger.d('showSuggestionsOverlay() SKIPPED');
    }
  }

  void dismissSuggestionsOverlay() {
    if (entry != null) {
      entry!.remove();
      entry = null;
    }
  }

  bool get isShowingSuggestionsOverlay => entry != null;
}
