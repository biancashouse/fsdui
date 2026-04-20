import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

class Page_RowOf2Panels extends StatelessWidget {
  const Page_RowOf2Panels({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SnippetBuilder(
              // panelName: 'panel1',
              initialValue: PaddingNode(
                name: 'panels-demo1-panel1',
                padding: EdgeInsetsValue(
                  top: 30,
                  left: 30,
                  bottom: 30,
                  right: 30,
                ),
                child: AssetImageNode(assetPath: 'assets/images/flowers.jpg'),
              ),
            ),
          ),
          Expanded(
            child: SnippetBuilder(
              // panelName: 'panel2',
              initialValue: CarouselNode(
                name: 'panels-demo2-panel2',
                children: [
                  AssetImageNode(assetPath: 'assets/images/frog.jpg'),
                  AssetImageNode(assetPath: 'assets/images/hummingbird.jpg'),
                  AssetImageNode(assetPath: 'assets/images/indian-chat.jpg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
