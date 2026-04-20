// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

part 'article_listview_node.mapper.dart';

@MappableClass()
class ArticleListViewNode extends ListViewNode
    with ArticleListViewNodeMappable {
  ArticleListViewNode({
    super.name,
    super.padding,
    super.shrinkWrap,
    required super.children,
  });

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);
    List<Widget> listViewChildren = children.map((childNode) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: childNode.build(context, this),
          ),
        ),
      );
    }).toList();
    return ListView(
      key: createNodeWidgetGK(),
      controller: sc,
      scrollDirection: scrollDirection.flutterValue,
      shrinkWrap: shrinkWrap ?? false,
      padding: padding?.toEdgeInsets(),
      children: listViewChildren,
    );
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "ArticleListView";
}
