import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/edgeinsets_pnode.dart';

import '../pnodes/fyi_pnodes.dart';

mixin BoxScrollViewNode on SNode {
  abstract EdgeInsets? padding;

  List<PNode> bsvPropertyNodes(BuildContext context, SNode? parentSNode) => [
    PNode(
      snode: this,
      name: 'padding',
      children: [
        EdgeInsetsPNode(
          snode: this,
          name: 'padding',
          ei: padding,
          onEIChangedF: (newValue) {
            padding = newValue;
          },
        ),
      ],
    ),
    FlutterDocPNode(
      buttonLabel: 'BoxScrollView',
      webLink: 'https://api.flutter.dev/flutter/widgets/BoxScrollView-class.html',
      snode: this,
      name: 'fyi',
    ),
  ];
}
