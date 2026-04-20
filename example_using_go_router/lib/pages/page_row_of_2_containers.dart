import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

class Page_RowOf2Containers extends StatelessWidget {
  const Page_RowOf2Containers({super.key});

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
                name: 'container-5',
                padding: EdgeInsetsValue(
                  top: 30,
                  left: 30,
                  bottom: 30,
                  right: 30,
                ),
                child: ContainerNode(csPropGroup: ContainerStyleProperties()),
              ),
            ),
          ),
          Expanded(
            child: SnippetBuilder(
              // panelName: 'panel2',
              initialValue: CenterNode(name: 'container-6'),
            ),
          ),
        ],
      ),
    );
  }
}
