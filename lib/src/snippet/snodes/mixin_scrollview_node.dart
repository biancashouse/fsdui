import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/bool_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/enum_pnode.dart';

import '../pnodes/fyi_pnodes.dart';

mixin ScrollViewNode on SNode {
  abstract AxisEnum scrollDirection;
  abstract bool? shrinkWrap;

  @JsonKey(includeFromJson: false, includeToJson: false)
  ScrollController sc = ScrollController();

  @override
  bool canAppendAChild() => true;

  List<PNode> svPropertyNodes(BuildContext context, SNode? parentSNode) => [
    EnumPNode<AxisEnum?>(
      snode: this,
      name: 'scrollDirection',
      valueIndex: scrollDirection.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => scrollDirection = AxisEnum.of(newValue) ?? AxisEnum.vertical,
      ),
    ),
    BoolPNode(
      snode: this,
      name: 'shrinkWrap',
      boolValue: shrinkWrap,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => shrinkWrap = newValue),
    ),
    FlutterDocPNode(
      buttonLabel: 'ScrollView',
      webLink: 'https://api.flutter.dev/flutter/widgets/ScrollView-class.html',
      snode: this,
      name: 'fyi',
    ),
  ];
}
