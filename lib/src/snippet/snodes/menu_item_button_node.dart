// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/snodes/button_style_hook.dart';

part 'menu_item_button_node.mapper.dart';

@MappableClass()
class MenuItemButtonNode extends SNode with SC, ButtonMixin, MenuItemButtonNodeMappable {
  @override
  String? destinationRoutePathSnippetName;
  @override
  SNode? child;

  @override
  bool canAppendAChild() => child == null;
  @MappableField(hook: ButtonStyleHook())
  @override
  ButtonStyleProperties bsPropGroup;
  @override
  String? onTapHandlerName;

  MenuItemButtonNode({
    super.name,
    this.destinationRoutePathSnippetName,
    required this.bsPropGroup,
    this.onTapHandlerName,
    this.child,
  });

  @override
  ButtonStyle? defaultButtonStyle() => MenuItemButton.styleFrom();

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    ...btnPropertyNodes(context, parentSNode),
    FlutterDocPNode(
        buttonLabel: 'MenuItemButton',
        webLink: 'https://api.flutter.dev/flutter/material/MenuItemButton-class.html',
        snode: this,
        name: 'fyi'),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {

    try {
      setParent(parentNode); // propagating parents down from root
      final gk = createNodeWidgetGK();
      return MenuItemButton(
            key: gk,
            onPressed: () {
                if (destinationRoutePathSnippetName != null) {
                onPressed(context, gk);
              }
            },
            style: fsdui.buttonStyle(30),
            child: child?.build(context, this),
          );
    } catch (e) {
      return Error(key: createNodeWidgetGK(), FLUTTER_TYPE, color: Colors.red, size: 16, errorMsg: e.toString());
    }
  }

  @override
  String toSource(BuildContext context) {
    return '''MenuItemButton(
      )''';
  }

  @override
  List<Type> replaceWithOnly() => [SubmenuButton];

  @override
  List<Type> wrapCandidates() => [SubmenuButtonNode, MenuBarNode];

  @override
  List<Type> wrapWithOnly() => [MenuBarNode, SubmenuButtonNode];

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "MenuItemButton";
}
