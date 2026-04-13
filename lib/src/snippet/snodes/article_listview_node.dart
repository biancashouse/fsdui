// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_content/flutter_content.dart';

part 'article_listview_node.mapper.dart';

@MappableClass()
class ArticleListViewNode extends ListViewNode
    with ArticleListViewNodeMappable {
  ArticleListViewNode({
    super.padding,
    super.shrinkWrap,
    required super.children,
  });

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "ArticleListView";
}
