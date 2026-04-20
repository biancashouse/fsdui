import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

part 'inlinespan_node.mapper.dart';

const List<Type> inlinespanSubClasses = [TextSpanNode, WidgetSpanNode];

@MappableClass(discriminatorKey: 'DK:is', includeSubClasses: inlinespanSubClasses,
  hook: PropertyRenameHook('is', 'DK:is'), // 'first_name' -> JSON key, 'firstName' -> Dart field name
)
abstract class InlineSpanNode extends SNode with InlineSpanNodeMappable {
  InlineSpanNode({super.name});

  InlineSpan toInlineSpan(BuildContext context) {
    // superclasses must override
    throw UnimplementedError();
  }

  // String toSource(
  //   BuildContext context, {
  //   bool isRoot = false,
  // });

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) => const Text('InlineSpan is a Node!');
}
