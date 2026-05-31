// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

part 'article_listview_node.mapper.dart';

@MappableClass()
class ArticleListViewNode extends SNode with ScrollViewNode, BoxScrollViewNode, ArticleListViewNodeMappable {
  @override
  AxisEnum scrollDirection;
  @override
  bool? shrinkWrap;
  @override
  EdgeInsets? padding;

  List<SNode> children;

  ArticleListViewNode({
    super.name,
    this.scrollDirection = AxisEnum.vertical,
    this.shrinkWrap,
    this.padding,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    ...svPropertyNodes(context, parentSNode),
    ...bsvPropertyNodes(context, parentSNode),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);
    List<Widget> listViewChildren = children.map((childNode) {
      return fsdui.isArticleEditor() || fsdui.canEditAnyContent()
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: BannerListTile(
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  bannerText: childNode is MarkdownNode
                      ? 'md'
                      : childNode is QuillTextNode
                      ? 'text'
                      : childNode is YTNode
                      ? 'YTube'
                      : '?',
                  bannerColor: childNode is MarkdownNode
                      ? Colors.green[900]
                      : childNode is QuillTextNode
                      ? Colors.black
                      : childNode is YTNode
                      ? Colors.red
                      : Colors.white,
                  bannerTextColor: childNode is MarkdownNode
                      ? Colors.white
                      : childNode is QuillTextNode
                      ? Colors.white
                      : childNode is YTNode
                      ? Colors.white
                      : Colors.white,
                  subtitle: childNode.build(context, this),
                  trailing: IconButton(
                    onPressed: () {
                      fsdui.capiBloc.add(DeleteArticle(articleSnippet: childNode));
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
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
      padding: padding,
      children: listViewChildren,
    );
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "ArticleListView";
}
