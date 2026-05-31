import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/button_style_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/string_pnode.dart';

mixin ButtonNode on SNode {
  // when navigating to path, which is also used as the page's snippet name
  abstract String? destinationRoutePathSnippetName;

  @override
  abstract SNode? child;

  abstract ButtonStyleProperties bsPropGroup;
  abstract String? onTapHandlerName;

  ButtonStyle? defaultButtonStyle();

  String? getTapHandlerName() => onTapHandlerName;

  void setTapHandlerName(String newName) => onTapHandlerName = newName;

  @override
  ButtonStyleProperties? buttonStyleProperties() => bsPropGroup;

  @override
  void setButtonStyleProperties(ButtonStyleProperties newProps) =>
      bsPropGroup = newProps;

  @override
  TextStyleProperties? textStyleProperties() => bsPropGroup.tsPropGroup;

  @override
  void setTextStyleProperties(TextStyleProperties newProps) =>
      bsPropGroup.tsPropGroup = newProps;

  List<PNode> btnPropertyNodes(BuildContext context, SNode? parentSNode) {
    return [
      PNode /*Group*/ (
        snode: this,
        name: 'goto Page...',
        children: [
          FYIPNode(
            label: "about page links...",
            msg:
                "tapping the button\nnavigates the user to\nthe page defined by\n'destination Route Path'",
            snode: this,
            name: 'page-linking',
          ),
          StringPNode(
            snode: this,
            name: 'destination Route Path',
            stringValue: destinationRoutePathSnippetName,
            onStringChange: (newValue) {
              refreshWithUpdate(
                context,
                () => destinationRoutePathSnippetName =
                    (newValue == null || newValue.startsWith('/')
                    ? newValue
                    : "/$newValue"),
              );
            },
            options: fsdui.pageList,
            calloutButtonSize: const Size(240, 70),
            calloutWidth: 280,
          ),
        ],
      ),
      ButtonStylePNode /*Group*/ (
        snode: this,
        name: 'buttonStyle',
        buttonStyleGroup: bsPropGroup,
        onGroupChange: (newValue, refreshPTree) {
          refreshWithUpdate(context, () {
            bsPropGroup = newValue;
            if (refreshPTree) {
              forcePropertyTreeRefresh(context);
            }
          });
        },
      ),
      if (fsdui.handlers().isNotEmpty)
        StringPNode(
          snode: this,
          name: 'onTapHandlerName',
          stringValue: onTapHandlerName,
          onStringChange: (newValue) =>
              refreshWithUpdate(context, () => onTapHandlerName = newValue),
          calloutButtonSize: const Size(240, 70),
          calloutWidth: 280,
        ),
    ];
  }

  void onPressed(
    BuildContext context,
    GlobalKey? gk,
  ) {
    if (onTapHandlerName != null) {
      fsdui.namedCallbacks[onTapHandlerName!]?.call(context, gk);
    }
  }

  Size get nodeAddersAndPropertiesCalloutSize => const Size(460, 600);
}
