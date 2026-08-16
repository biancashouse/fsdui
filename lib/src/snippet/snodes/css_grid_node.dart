// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

import '../pnodes/decimal_pnode.dart' show DecimalPNode;
import '../pnodes/enum_pnode.dart' show EnumPNode;
import '../pnodes/enums/enum_css_grid_auto_placement.dart';
import '../pnodes/enums/enum_css_grid_fit.dart';
import '../pnodes/fyi_pnodes.dart' show FlutterDocPNode;
import '../pnodes/string_pnode.dart' show StringPNode;
import 'css_grid/mondrian.dart';

part 'css_grid_node.mapper.dart';

@MappableClass()
class CSSGridNode extends SNode with MC, CSSGridNodeMappable {
  @override
  List<SNode> children;

  // Space-separated track sizes, CSS-grid-template-columns/rows style.
  // Each token is one of: "<n>fr" (flexible), "<n>px" or a bare number
  // (fixed pixels), or "auto" (sized to its content). e.g. "1fr 2fr 100px".
  String columnSizesSpec;
  String rowSizesSpec;

  double? columnGap;
  double? rowGap;

  CSSGridAutoPlacementEnumModel? autoPlacement;
  CSSGridFitEnumModel? gridFit;

  CSSGridNode({
    super.name,
    this.columnSizesSpec = '1fr 1fr',
    this.rowSizesSpec = 'auto',
    this.columnGap,
    this.rowGap,
    this.autoPlacement,
    this.gridFit,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    StringPNode(
      snode: this,
      name: 'columnSizesSpec',
      nameOnSeparateLine: true,
      stringValue: columnSizesSpec,
      onStringChange: (newValue) => refreshWithUpdate(
        context,
        () => columnSizesSpec = newValue ?? '1fr 1fr',
      ),
      calloutButtonSize: const Size(280, 30),
      calloutWidth: 300,
    ),
    StringPNode(
      snode: this,
      name: 'rowSizesSpec',
      nameOnSeparateLine: true,
      stringValue: rowSizesSpec,
      onStringChange: (newValue) => refreshWithUpdate(
        context,
        () => rowSizesSpec = newValue ?? 'auto',
      ),
      calloutButtonSize: const Size(280, 30),
      calloutWidth: 300,
    ),
    DecimalPNode(
      snode: this,
      name: 'columnGap',
      decimalValue: columnGap,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => columnGap = newValue),
    ),
    DecimalPNode(
      snode: this,
      name: 'rowGap',
      decimalValue: rowGap,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => rowGap = newValue),
    ),
    EnumPNode<CSSGridAutoPlacementEnumModel?>(
      snode: this,
      name: 'autoPlacement',
      valueIndex: autoPlacement?.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => autoPlacement = CSSGridAutoPlacementEnumModel.of(newValue),
      ),
    ),
    EnumPNode<CSSGridFitEnumModel?>(
      snode: this,
      name: 'gridFit',
      valueIndex: gridFit?.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => gridFit = CSSGridFitEnumModel.of(newValue),
      ),
    ),
    FlutterDocPNode(
      buttonLabel: 'LayoutGrid',
      webLink: 'https://pub.dev/packages/flutter_layout_grid',
      snode: this,
      name: 'fyi',
    ),
  ];

  static List<TrackSize> _parseTrackSizes(String spec) {
    final tokens = spec
        .split(RegExp(r'\s+'))
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty);
    final sizes = tokens.map(_parseTrackSize).toList();
    return sizes.isEmpty ? [const FlexibleTrackSize(1)] : sizes;
  }

  static TrackSize _parseTrackSize(String token) {
    final lower = token.toLowerCase();
    if (lower == 'auto') return const IntrinsicContentTrackSize();
    if (lower.endsWith('fr')) {
      final n = double.tryParse(lower.substring(0, lower.length - 2));
      return FlexibleTrackSize(n ?? 1);
    }
    if (lower.endsWith('px')) {
      final n = double.tryParse(lower.substring(0, lower.length - 2));
      return FixedTrackSize(n ?? 100);
    }
    final n = double.tryParse(lower);
    return n != null ? FixedTrackSize(n) : const FlexibleTrackSize(1);
  }

@override
Widget buildFlutterWidget(BuildContext context, SNode? parentNode) => PietPainting();

  Widget buildFlutterWidgetOLD(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);
      return LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxHeight == double.infinity
              ? Error(
                  key: createNodeWidgetGK(),
                  FLUTTER_TYPE,
                  color: Colors.red,
                  size: 16,
                  errorMsg:
                      'CSSGrid has infinite\nmaxHeight constraint!\nWrap in a SizedBox?',
                )
              : LayoutGrid(
                  key: createNodeWidgetGK(),
                  columnSizes: _parseTrackSizes(columnSizesSpec),
                  rowSizes: _parseTrackSizes(rowSizesSpec),
                  columnGap: columnGap ?? 0,
                  rowGap: rowGap ?? 0,
                  autoPlacement:
                      autoPlacement?.flutterValue ?? AutoPlacement.rowSparse,
                  gridFit: gridFit?.flutterValue ?? GridFit.expand,
                  children: children
                      .map((node) => node.build(context, this))
                      .toList(),
                );
        },
      );
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

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "CSSGrid";
}
