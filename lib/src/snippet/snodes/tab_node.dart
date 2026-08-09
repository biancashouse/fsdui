// // ignore_for_file: constant_identifier_names
//
// import 'package:dart_mappable/dart_mappable.dart';
// import 'package:flutter/material.dart';
// import 'package:fsdui/fsdui.dart';
// import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
//
// part 'tab_node.mapper.dart';
//
// // class TextStyleHook extends MappingHook {
// //   const TextStyleHook();
// //
// //   @override
// //   Object? beforeDecode(Object? value) {
// //     return value ?? {'tsPropGroup': TextStyleProperties().toJson()};
// //   }
// // }
//
// @MappableClass()
// class TabNode extends SNode with SC, TabNodeMappable {
//   @override
//   SNode? child;
//
//   @override
//   bool canAppendAChild() => child == null;
//
//   TabNode({
//     super.name,
//     this.child,
//   });
//
//   @override
//   List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) {
//     // fco.logger.i('textStyleName is "$textStyleName"');
//     return [
//       FlutterDocPNode(
//         buttonLabel: 'Tab',
//         webLink: 'https://api.flutter.dev/flutter/material/Tab-class.html',
//         snode: this,
//         name: 'fyi',
//       ),
//     ];
//   }
//
//   @override
//   Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
//     setParent(parentNode);
//
//     if (child is TextNode) {
//       TextNode tn = child as TextNode;
//       if (tn.text == 'home') {
//         return Icon(Icons.home, size: 24);
//       }
//     }
//
//     return Tab(
//       key: createNodeWidgetGK(),
//       child: child?.build(context, this),
//     );
//   }
//
//   // @override
//   // String toSource(BuildContext context) {
//   //   return '''Text(
//   //       $text,
//   //       style: ${textStyle?.toSource(context, namedTextStyle: namedTextStyle)},
//   //       textAlign: ${textAlign?.toSource()},
//   //     )''';
//   // }
//
//   @override
//   String toString() => FLUTTER_TYPE;
//
//   static const String FLUTTER_TYPE = "Tab";
// }
