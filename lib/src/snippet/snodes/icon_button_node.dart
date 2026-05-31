// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/snodes/button_style_hook.dart';

part 'icon_button_node.mapper.dart';

@MappableClass()
class IconButtonNode extends SNode with SC, ButtonNode, IconButtonNodeMappable {
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

  int? iconCodePoint;
  String? iconFontFamily;
  String? iconFontPackage;
  int? iconColor;
  double? iconSize;

  IconButtonNode({
    super.name,
    this.iconCodePoint,
    this.iconFontFamily,
    this.iconFontPackage,
    this.iconColor,
    this.iconSize,
    this.destinationRoutePathSnippetName,
    required this.bsPropGroup,
    this.onTapHandlerName,
    this.child,
  });

  @override
  ButtonStyle? defaultButtonStyle() => IconButton.styleFrom();

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    ...btnPropertyNodes(context, parentSNode),
    FlutterDocPNode(
        buttonLabel: 'IconButton',
        webLink: 'https://api.flutter.dev/flutter/material/IconButton-class.html',
        snode: this,
        name: 'fyi'),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {

    // possible handler
    void Function(BuildContext)? f = onTapHandlerName != null ? fsdui.namedHandler(onTapHandlerName!) : null;
    setParent(parentNode);

    final gk = createNodeWidgetGK();

    ButtonStyle? btnStyle = bsPropGroup.toButtonStyle(context, defaultButtonStyle: defaultButtonStyle());

    IconButton button = IconButton(
      onPressed: ()=>onPressed(context, gk),
      style: btnStyle,
      icon: child?.build(context, this) ?? const Icon(Icons.warning, color: Colors.red),
    );

    return Container(
      // container only for possble selection gk
      key: gk,
      child: kDebugMode
          ? GestureDetector(
              onLongPress: () {
                      f?.call(context);
                    },
              child: button)
          : button,
    );
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "IconButton";
}
