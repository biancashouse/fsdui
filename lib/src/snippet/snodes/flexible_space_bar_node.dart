// ignore_for_file: constant_identifier_names
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/bool_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/edge_insets_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

part 'flexible_space_bar_node.mapper.dart';

@MappableClass()
class FlexibleSpaceBarNode extends CL with FlexibleSpaceBarNodeMappable {
  NamedSC title;
  NamedSC background;
  bool? centerTitle;
  EdgeInsetsValue? titlePadding;

  FlexibleSpaceBarNode({
    super.name,
    required this.title,
    required this.background,
    this.centerTitle,
    this.titlePadding,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) {
    // fco.logger.i("ContainerNode.properties()...");
    return [
      FlutterDocPNode(
        buttonLabel: 'FlexibleSpaceBar',
        webLink: 'https://api.flutter.dev/flutter/material/FlexibleSpaceBar-class.html',
        snode: this,
        name: 'fyi',
      ),
      BoolPNode(
        snode: this,
        name: 'centerTitle',
        boolValue: centerTitle,
        onBoolChange: (newValue) => refreshWithUpdate(
          context,
              () => centerTitle = newValue ?? true,
        ),
      ),
      PNode /*Group*/ (
        snode: this,
        name: 'titlePadding',
        children: [
          EdgeInsetsPNode(
            snode: this,
            name: 'margin',
            eiValue: titlePadding,
            onEIChangedF: (newValue) {
              refreshWithUpdate(
                context,
                    () => titlePadding = newValue,
              );
            },
          ),
        ],
      ),    ];
  }

  @override
  // no tabbar nor menubar
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode); // propagating parents down from root

      var titleWidget = title.build(
        context,
        this,
      );
      var backgroundWidget = background.build(context, this);

      try {
        var fsBar = FlexibleSpaceBar(
          key: createNodeWidgetGK(),
          title: titleWidget,
          centerTitle: centerTitle,
          titlePadding: titlePadding?.toEdgeInsets(),
          background: backgroundWidget,
        );
        return fsBar;
      } catch (e) {
        fsdui.logger.i('FlexibleSpaceBarNode.toWidget() failed!');
        return Material(
          textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                const Gap(10),
                fsdui.coloredText(e.toString()),
              ],
            ),
          ),
        );
      }
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

  // @override
  // List<Widget> menuAnchorWidgets_WrapWith(
  //   BuildContext context,
  //   NodeAction action,
  //   bool? skipHeading,
  //   
  // ) {
  //   return [
  //   ];
  // }

  // @override
  // bool canWrap() => false;

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "FlexibleSpaceBar";
}
