import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

import '../pnodes/string_pnode.dart';

part 'markdown_node.mapper.dart';

@MappableClass()
class MarkdownNode extends CL with MarkdownNodeMappable {
  String? md;

  MarkdownNode({super.name, this.md});

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) =>
      [
        FlutterDocPNode(
          buttonLabel: 'Markdown Plus',
          webLink: 'https://pub.dev/packages/flutter_markdown_plus',
          snode: this,
          name: 'fyi',
        ),
        StringPNode(
          snode: this,
          name: 'markdown',
          nameOnSeparateLine: true,
          expands: true,
          numLines: 3,
          stringValue: md,
          onStringChange: (newValue) {
            refreshWithUpdate(context, () => md = newValue ?? '');
          },
          calloutButtonSize: const Size(280, 300),
          calloutWidth: 300,
        ),
      ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode); // propagating parents down from root
      return MarkdownBody(data: md ?? '');
    } catch (e) {
      return Error(
        key: createNodeWidgetGK(),
        FLUTTER_TYPE,
        color: Colors.red,
        size: 16,
        errorMsg: e.toString(),
      );
    }
  }

  @override
  String toString() => 'Markdown';

  static const String FLUTTER_TYPE = "Markdown";
}