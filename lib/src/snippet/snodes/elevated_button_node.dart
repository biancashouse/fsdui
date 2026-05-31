// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/snodes/button_style_hook.dart';

part 'elevated_button_node.mapper.dart';

@MappableClass()
class ElevatedButtonNode extends SNode with SC, ButtonNode, ElevatedButtonNodeMappable {
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

  ElevatedButtonNode({
    super.name,
    this.destinationRoutePathSnippetName,
    required this.bsPropGroup,
    this.onTapHandlerName,
    this.child,
  });

  @override
  ButtonStyle? defaultButtonStyle() => ElevatedButton.styleFrom();

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    ...btnPropertyNodes(context, parentSNode),
    FlutterDocPNode(
        buttonLabel: 'ElevatedButton',
        webLink: 'https://api.flutter.dev/flutter/material/ElevatedButton-class.html',
        snode: this,
        name: 'fyi'),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {

    try {
      ButtonStyle? btnStyle = bsPropGroup.toButtonStyle(context, defaultButtonStyle: defaultButtonStyle());
      // possible handler
      void Function(BuildContext)? f = onTapHandlerName != null ? fsdui.namedHandler(onTapHandlerName!) : null;

      setParent(parentNode);

      final gk = createNodeWidgetGK();

      return Container(
            // container only for possble selection gk
            key: gk,
            child: ElevatedButton(
              onPressed: ()=>onPressed(context, gk),
              onLongPress: () => f?.call(context),
              style: btnStyle,
              child: child?.build(context, this),
            ),
          );
    } catch (e) {
      return Error(key: createNodeWidgetGK(), FLUTTER_TYPE, color: Colors.red, size: 16, errorMsg: e.toString());
    }
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "ElevatedButton";
}
