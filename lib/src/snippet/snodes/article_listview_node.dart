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
                  // onTap: () {},
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
                  // imageContainer: const Image(
                  //   image: NetworkImage(
                  //     "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb1.2.1&auto=format&fit=crop&w=387&q=80",
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),

                  // title: const Text(
                  //   "Monalisa",
                  //   style: TextStyle(fontSize: 24, color: Colors.white),
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  // ),
                  subtitle: childNode.build(context, this),
                  trailing: IconButton(
                    onPressed: () {
                      fsdui.capiBloc.add(CAPIEvent.deleteArticle(articleSnippet: childNode));
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
      padding: padding?.toEdgeInsets(),
      children: listViewChildren,
    );
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "ArticleListView";
}
