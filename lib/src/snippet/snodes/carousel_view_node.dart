// ignore_for_file: constant_identifier_names
import 'dart:async';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/bool_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';

import '../pnodes/color_pnode.dart' show ColorPNode;
import '../pnodes/edgeinsets_pnode.dart' show EdgeInsetsPNode;
import '../pnodes/enum_pnode.dart' show EnumPNode;
import '../pnodes/fyi_pnodes.dart' show FlutterDocPNode;

// import 'package:fsdui/src/snippet/pnodes/enum_pnode.dart';
// import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

// import '../pnodes/color_pnode.dart';
// import '../pnodes/edgeinsets_pnode.dart';
// import '../pnodes/string_pnode.dart';

part 'carousel_view_node.mapper.dart';

List<String> kDemoImages = [
  'lib/assets/images/carousel-demo/2-carnations.jpeg',
  'lib/assets/images/carousel-demo/blue-jug.jpeg',
  'lib/assets/images/carousel-demo/cherries.jpeg',
  'lib/assets/images/carousel-demo/grapes.jpeg',
  'lib/assets/images/carousel-demo/honey.jpeg',
  'lib/assets/images/carousel-demo/jug.webp',
  'lib/assets/images/carousel-demo/lamp.jpeg',
  'lib/assets/images/carousel-demo/pears.jpg',
];

@MappableClass()
class CarouselViewNode extends SNode with MC, CarouselViewNodeMappable {
  @override
  List<SNode> children;

  Color? backgroundColor;
  Color? overlayColor;
  EdgeInsets? margin;
  EdgeInsets? padding;

  // double? height;
  double? elevation;
  bool itemSnapping;
  double shrinkExtent;
  AxisEnum scrollDirection;
  double? itemExtent;

  // bool consumeMaxWeight;
  // bool enableSplash;
  bool infinite;

  // String flexWeights;

  bool autoPlay;
  double autoPlayIntervalSecs;

  CarouselViewNode({
    super.name,
    this.backgroundColor,
    this.overlayColor,
    this.padding,
    this.margin,
    // this.height,
    this.elevation,
    this.itemSnapping = false,
    this.scrollDirection = AxisEnum.horizontal,
    this.shrinkExtent = 0.0,
    this.itemExtent = 600.0,
    // this.consumeMaxWeight = true,
    // this.enableSplash = true,
    this.infinite = false,
    this.autoPlay = false,
    this.autoPlayIntervalSecs = 3.0,
    // this.flexWeights = '[1]',
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    EdgeInsetsPNode(
      snode: this,
      name: 'margin',
      ei: margin,
      onEIChangedF: (newEI) => refreshWithUpdate(context, () => margin = newEI),
    ),
    EdgeInsetsPNode(
      snode: this,
      name: 'padding',
      ei: padding,
      onEIChangedF: (newEI) =>
          refreshWithUpdate(context, () => padding = newEI),
    ),
    ColorPNode(
      snode: this,
      name: 'background color',
      color: backgroundColor,
      onColorChange: (newValue) =>
          refreshWithUpdate(context, () => backgroundColor = newValue),
    ),
    ColorPNode(
      snode: this,
      name: 'overlay color',
      color: overlayColor,
      onColorChange: (newValue) =>
          refreshWithUpdate(context, () => overlayColor = newValue),
    ),
    // EdgeInsetsPNode(
    //   snode: this,
    //   name: 'padding',
    //   ei: padding,
    //   onEIChangedF: (newEI) =>
    //       refreshWithUpdate(context, () => padding = newEI),
    // ), //   DecimalPNode(
    // DecimalPNode(
    //   snode: this,
    //   name: 'height',
    //   decimalValue: height,
    //   onDoubleChange: (newValue) =>
    //       refreshWithUpdate(context, () => height = newValue ?? 200),
    // ),
    DecimalPNode(
      snode: this,
      name: 'shrinkExtent',
      decimalValue: shrinkExtent,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => shrinkExtent = newValue ?? 0.0),
    ),
    DecimalPNode(
      snode: this,
      name: 'itemExtent',
      decimalValue: itemExtent,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => itemExtent = newValue ?? 100.0),
    ),
    BoolPNode(
      snode: this,
      name: 'itemSnapping',
      boolValue: itemSnapping,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => itemSnapping = newValue ?? true),
    ),
    //     snode: this,
    DecimalPNode(
      snode: this,
      name: 'elevation',
      decimalValue: elevation,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => elevation = newValue),
    ),
    EnumPNode<AxisEnum?>(
      snode: this,
      name: 'scrollDirection',
      valueIndex: scrollDirection.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => scrollDirection = AxisEnum.of(newValue) ?? AxisEnum.horizontal,
      ),
    ),
    BoolPNode(
      snode: this,
      name: 'infinite',
      boolValue: infinite,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => infinite = newValue ?? false),
    ),
    BoolPNode(
      snode: this,
      name: 'autoPlay',
      boolValue: autoPlay,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => autoPlay = newValue ?? false),
    ),
    DecimalPNode(
      snode: this,
      name: 'autoPlayIntervalSecs',
      decimalValue: autoPlayIntervalSecs,
      onDoubleChange: (newValue) => refreshWithUpdate(
        context,
        () => autoPlayIntervalSecs = newValue ?? 3.0,
      ),
    ),
    FlutterDocPNode(
      buttonLabel: 'CarouselView',
      webLink: 'https://pub.dev/packages/carousel_slider',
      snode: this,
      name: 'fyi',
    ),
  ];

  // @override
  // String toSource(BuildContext context) => '''CarouselView(
  //       children: children.map((child) => child.toWidget(context, this)).toList(),
  //     );
  // ''';

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);
      List<Widget> widgets = children.isEmpty
          ? kDemoImages
                .map(
                  (name) => Padding(
                    padding: padding ?? EdgeInsets.zero,
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
              final w = Padding(
                padding: padding ?? EdgeInsets.zero,
                child: node.build(context, this),
              );
              // ListView / GridView / CustomScrollView render as RenderViewport,
              // which asserts on computeMinIntrinsicWidth. Pre-wrap them in a
              // SizedBox so they get a bounded width instead of the viewport
              // being measured directly.
              if (node is ListViewNode ||
                  node is GridViewNode ||
                  node is CustomScrollViewNode) {
                return SizedBox(
                  width: fsdui.scrW / 2,
                  height: fsdui.scrH - 250,
                  child: w,
                );
              }
              return w;
            }).toList();

      // CarouselView lays out via a Viewport that needs a bounded
      // cross-axis extent (height, for the default horizontal
      // scrollDirection). Without it, ancestors that hand out unbounded
      // height (e.g. a Column) trigger a hasSize assertion failure.
      return Container(
        margin: margin ?? EdgeInsets.zero,
        width: fsdui.scrW / 2,
        height: fsdui.scrH - 250,
        child: fsdui.canEditAnyContent()
            ? CarouselSlider.builder(
                key: createNodeWidgetGK(),
                itemCount: widgets.length,
                options: CarouselOptions(
                  aspectRatio: 1.0,
                  height: fsdui.scrH - 250,
                ),
                itemBuilder: (context, itemIndex, realIndex) {
                  return widgets[itemIndex];
                },
              )
            : _AutoPlayingCarouselView(
                key: createNodeWidgetGK(),
                backgroundColor: backgroundColor,
                overlayColor: overlayColor,
                infinite: infinite,
                elevation: elevation,
                itemSnapping: itemSnapping,
                shrinkExtent: shrinkExtent,
                scrollDirection: scrollDirection.flutterValue,
                itemExtent: itemExtent ?? 600.0,
                autoPlay: autoPlay,
                autoPlayIntervalSecs: autoPlayIntervalSecs,
                children: widgets,
              ),
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

/// Wraps [CarouselView] with a [Timer]-driven [CarouselController] so it can
/// auto-advance. [CarouselView] itself has no autoplay concept — its
/// [CarouselView.infinite] flag only makes manual scroll gestures wrap
/// around indefinitely, it doesn't move anything on its own.
class _AutoPlayingCarouselView extends StatefulWidget {
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? overlayColor;
  final double? elevation;
  final bool itemSnapping;
  final double shrinkExtent;
  final Axis scrollDirection;
  final double itemExtent;
  final bool infinite;
  final bool autoPlay;
  final double autoPlayIntervalSecs;

  const _AutoPlayingCarouselView({
    super.key,
    required this.children,
    this.backgroundColor,
    this.overlayColor,
    this.elevation,
    required this.itemSnapping,
    required this.shrinkExtent,
    required this.scrollDirection,
    required this.itemExtent,
    required this.infinite,
    required this.autoPlay,
    required this.autoPlayIntervalSecs,
  });

  @override
  State<_AutoPlayingCarouselView> createState() =>
      _AutoPlayingCarouselViewState();
}

class _AutoPlayingCarouselViewState extends State<_AutoPlayingCarouselView> {
  final _controller = CarouselController();
  Timer? _timer;

  // Once the user taps or drags the carousel themselves, autoplay stops
  // for good rather than resuming later — resuming mid-interaction (or
  // after) would fight the user's own scroll position.
  bool _userInteracted = false;

  @override
  void initState() {
    super.initState();
    _restartTimer();
  }

  @override
  void didUpdateWidget(_AutoPlayingCarouselView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoPlay != oldWidget.autoPlay ||
        widget.autoPlayIntervalSecs != oldWidget.autoPlayIntervalSecs ||
        widget.children.length != oldWidget.children.length) {
      _restartTimer();
    }
  }

  void _restartTimer() {
    _timer?.cancel();
    if (_userInteracted || !widget.autoPlay || widget.children.length < 2) {
      return;
    }
    _timer = Timer.periodic(
      Duration(milliseconds: (widget.autoPlayIntervalSecs * 1000).round()),
      (_) => _advance(),
    );
  }

  // Any pointer-down on the carousel — whether it turns into a tap or a
  // drag — means the user is interacting with it, so autoplay should get
  // out of the way. Our own _advance()'s controller.animateTo() calls are
  // programmatic and never involve a pointer event, so they don't trigger
  // this.
  void _stopAutoPlayOnUserInteraction() {
    if (_userInteracted) return;
    _userInteracted = true;
    _timer?.cancel();
    _timer = null;
  }

  void _advance() {
    if (!mounted || !_controller.hasClients) return;
    final position = _controller.position;
    final next = position.pixels + widget.itemExtent;
    final loopBackToStart = !widget.infinite && next > position.maxScrollExtent;
    _controller.animateTo(
      loopBackToStart ? 0 : next,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _stopAutoPlayOnUserInteraction(),
      child: CarouselView.weighted(
        controller: _controller,
        // padding: const EdgeInsets.all(28.0),
        backgroundColor: widget.backgroundColor,
        overlayColor: widget.overlayColor != null
            ? WidgetStatePropertyAll(widget.overlayColor)
            : null,
        infinite: widget.infinite,
        elevation: widget.elevation,
        itemSnapping: widget.itemSnapping,
        shrinkExtent: widget.shrinkExtent,
        scrollDirection: widget.scrollDirection,
        flexWeights: const [6, 5, 2, 2],
        children: widget.children,
      ),
    );
  }
}
