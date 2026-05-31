import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

const List<Type> inlinespanSubClasses = [TextSpanNode, WidgetSpanNode];

mixin InlineSpanNode on SNode {
  InlineSpan toInlineSpan(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) => const Text('InlineSpan is a Node!');
}
