// ignore_for_file: constant_identifier_names
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/measuring/size_aware_widget.dart';
import 'package:fsdui/src/snippet/pnodes/bool_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
// import 'package:fsdui/src/snippet/pnodes/enum_pnode.dart';
// import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

// import '../pnodes/color_pnode.dart';
// import '../pnodes/edgeinsets_pnode.dart';
// import '../pnodes/string_pnode.dart';

part 'carousel_view_node.mapper.dart';

@MappableClass()
class CarouselViewNode extends SNode with MC, CarouselViewNodeMappable {
  @override
  List<SNode> children;

  // Color? backgroundColor;
  // EdgeInsets? padding;
  double height;
  // double? elevation;
  // bool itemSnapping;
  bool autoPlay;
  // double shrinkExtent;
  // AxisEnum scrollDirection;
  // bool consumeMaxWeight;
  // bool enableSplash;
  // bool infinite;
  // String flexWeights;

  // Cache each item's measured size so _offsetForIndex can compute accurate
  // scroll offsets for auto-play without querying intrinsic dimensions.
  final Map<int, Size> _itemSizeCache = {};

  CarouselViewNode({
    super.name,
    // this.backgroundColor,
    // this.padding,
    this.height = 200,
    // this.elevation,
    // this.itemSnapping = false,
    // this.scrollDirection = AxisEnum.horizontal,
    // this.shrinkExtent = 0.0,
    // this.consumeMaxWeight = true,
    // this.enableSplash = true,
    // this.infinite = false,
    // this.flexWeights = '[1]',
    this.autoPlay = false,
    required this.children,
  });

  // @override
  // List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    // ColorPNode(
    //   snode: this,
    //   name: 'background color',
    //   color: backgroundColor,
    //   onColorChange: (newValue) =>
    //       refreshWithUpdate(context, () => backgroundColor = newValue),
    // ),
    // EdgeInsetsPNode(
    //   snode: this,
    //   name: 'padding',
    //   ei: padding,
    //   onEIChangedF: (newEI) =>
    //       refreshWithUpdate(context, () => padding = newEI),
    // ), //   DecimalPNode(
    DecimalPNode(
      snode: this,
      name: 'height',
      decimalValue: height,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => height = newValue??200),
    ),
    // DecimalPNode(
    //   snode: this,
    //   name: 'shrinkExtent',
    //   decimalValue: shrinkExtent,
    //   onDoubleChange: (newValue) =>
    //       refreshWithUpdate(context, () => shrinkExtent = newValue ?? 0.0),
    // ),
    // BoolPNode(
    //   snode: this,
    //   name: 'itemSnapping',
    //   boolValue: itemSnapping,
    //   onBoolChange: (newValue) =>
    //       refreshWithUpdate(context, () => itemSnapping = newValue ?? true),
    // ),
    BoolPNode(
      snode: this,
      name: 'autoPlay',
      boolValue: autoPlay,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => autoPlay = newValue ?? false),
    ), //     snode: this,
    // DecimalPNode(
    //   snode: this,
    //   name: 'elevation',
    //   decimalValue: height,
    //   onDoubleChange: (newValue) =>
    //       refreshWithUpdate(context, () => elevation = newValue),
    // ),
    // EnumPNode<AxisEnum?>(
    //   snode: this,
    //   name: 'scrollDirection',
    //   valueIndex: scrollDirection.index,
    //   onIndexChange: (newValue) => refreshWithUpdate(
    //     context,
    //     () => scrollDirection = AxisEnum.of(newValue) ?? AxisEnum.horizontal,
    //   ),
    // ), //     name: 'aspectRatio',
    // BoolPNode(
    //   snode: this,
    //   name: 'consumeMaxWeight',
    //   boolValue: consumeMaxWeight,
    //   onBoolChange: (newValue) =>
    //       refreshWithUpdate(context, () => consumeMaxWeight = newValue ?? true),
    // ),
    // BoolPNode(
    //   snode: this,
    //   name: 'enableSplash',
    //   boolValue: enableSplash,
    //   onBoolChange: (newValue) =>
    //       refreshWithUpdate(context, () => enableSplash = newValue ?? true),
    // ),
    // BoolPNode(
    //   snode: this,
    //   name: 'infinite',
    //   boolValue: infinite,
    //   onBoolChange: (newValue) =>
    //       refreshWithUpdate(context, () => infinite = newValue ?? false),
    // ), //     decimalValue: aspectRatio,
    // StringPNode(
    //   snode: this,
    //   name: 'flexWeights',
    //   nameOnSeparateLine: true,
    //   expands: true,
    //   numLines: 3,
    //   stringValue: flexWeights,
    //   onStringChange: (newValue) {
    //     refreshWithUpdate(context, () => flexWeights = newValue ?? '[1]');
    //   },
    //   calloutButtonSize: const Size(280, 70),
    //   calloutWidth: 300,
    // ),
    // FlutterDocPNode(
    //   buttonLabel: 'CarouselView',
    //   webLink: 'https://pub.dev/packages/carousel_slider',
    //   snode: this,
    //   name: 'fyi',
    // ),
  ];

  @override
  String toSource(BuildContext context) => '''CarouselView(
        children: children.map((child) => child.toWidget(context, this)).toList(),
      );
  ''';

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);
      List<Widget> widgets = children.isEmpty
          ? kDemoImages
                .map(
                  (name) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: kElevationToShadow[2],
                        image: DecorationImage(
                          image: AssetImage(name, package: 'fsdui'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
          : children.map((SNode node) {
              final w = node.build(context, this);
              // ListView / GridView / CustomScrollView render as RenderViewport,
              // which asserts on computeMinIntrinsicWidth. Pre-wrap them in a
              // SizedBox so _AutoPlayingListView's IntrinsicWidth measures the
              // SizedBox (safe) rather than the viewport directly.
              if (node is ListViewNode ||
                  node is GridViewNode ||
                  node is CustomScrollViewNode) {
                return SizedBox(width: height, child: w);
              }
              return w;
            }).toList();

      Widget view = _AutoPlayingListView(
        key: createNodeWidgetGK(),
        autoPlay: autoPlay,
        itemSizeCache: _itemSizeCache,
        children: widgets,
      );

      // CarouselView lays out via a Viewport that needs a bounded
      // cross-axis extent (height, for the default horizontal
      // scrollDirection). Without it, ancestors that hand out unbounded
      // height (e.g. a Column) trigger a hasSize assertion failure.
      return /* height == null ? view : */ SizedBox(height: height, child: view);
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

  List<int> convert2List(String s) => s
      .replaceAll(']', '') // Removes trailing bracket
      .replaceAll(
        '[',
        '',
      ) // Safely handles it if a leading bracket is added later
      .split(',') // Splits into ['1', '1', '2']
      .map(
        (e) => int.tryParse(e.trim()) ?? 1,
      ) // Falls back to 1 on invalid input
      .toList(); // Converts the Iterable back to a List<int>

  @override
  bool canRemove() => children.isEmpty;

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "CarouselView";
}

/// Horizontal item list that, when [autoPlay] is on, advances to the next
/// item on a timer. Uses [ListView] (not [ListView.builder]) so all items
/// are built and laid out eagerly in one pass — this prevents the
/// "Cannot hit test a render box with no size" error that occurs when
/// [ListView.builder] lazily constructs items mid-scroll and a pointer event
/// arrives before their layout is complete.
class _AutoPlayingListView extends StatefulWidget {
  final List<Widget> children;
  final Map<int, Size> itemSizeCache;
  final bool autoPlay;

  const _AutoPlayingListView({
    super.key,
    required this.children,
    required this.itemSizeCache,
    required this.autoPlay,
  });

  @override
  State<_AutoPlayingListView> createState() => _AutoPlayingListViewState();
}

class _AutoPlayingListViewState extends State<_AutoPlayingListView> {
  final _scrollController = ScrollController();
  Offset _slideOffset = const Offset(0.5, 0);

  @override
  void initState() {
    super.initState();
    if (widget.autoPlay && widget.children.length > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _slideOffset = Offset.zero);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget list = ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: [
        for (var i = 0; i < widget.children.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizeAwareWidget(
              onSizeAvailable: (size) => widget.itemSizeCache[i] = size,
              child: IntrinsicWidth(child: widget.children[i]),
            ),
          ),
      ],
    );

    if (!widget.autoPlay) return list;

    return ClipRect(
      child: AnimatedSlide(
        offset: _slideOffset,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: list,
      ),
    );
  }
}
