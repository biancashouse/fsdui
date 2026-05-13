import 'dart:async' show Timer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/api/callouts/bubble_shape.dart';
import 'package:flutter_callouts/src/api/callouts/draggable_corner.dart';
import 'package:flutter_callouts/src/api/callouts/draggable_edge.dart';

// import 'package:flutter_callouts/src/api/callouts/pointing_line.dart';
// import 'package:flutter_callouts/src/api/callouts/scroll_config.dart';
import 'package:flutter_callouts/src/lines/pointing_line.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart'
    show PointerInterceptor;

// import 'package:pointer_interceptor/pointer_interceptor.dart';

// import 'package:transpare nt_pointer/transparent_pointer.dart';

// import 'callout_config_toolbar.dart';

class CalloutConfig implements TickerProvider {
  // final VoidCallback refreshOPParent;

  // ignore: constant_identifier_names
  final String cId;

  // if moved or resized, will bump every time
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueNotifier<int>? movedOrResizedNotifier = ValueNotifier(0);

  // will bump every time callout overlay moved or resized

  double? initialCalloutW;
  double? initialCalloutH;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Rect _targetRect;

  void setTargetRect(Rect newRect) => _targetRect = newRect;

  // Rect? tR() => _targetRect;

  final Alignment? gravity; // not null indictates Toast

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool showGotitButton;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Axis? gotitAxis;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Function? onGotitPressedF;

  final bool showcpi;

  final bool? onlyOnce;

  // final double scale;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ScrollConfig? scrollConfig;

  double scrollOffsetX() =>
      scrollConfig?.direction == Axis.horizontal
          ? scrollConfig!.controller?.offset ?? 0.0
          : 0.0;

  double scrollOffsetY() =>
      scrollConfig?.direction == Axis.vertical
          ? scrollConfig!.controller?.offset ?? 0.0
          : 0.0;

  Offset translateOffsetForScroll(Offset offset) =>
      offset.translate(
        scrollConfig?.direction == Axis.horizontal
            ? scrollConfig!.scrollOffset
            : 0.0,
        scrollConfig?.direction == Axis.vertical
            ? scrollConfig!.scrollOffset
            : 0.0,
      );

  Rect translateRectForScroll(Rect r) {
    return r.translate(
      scrollConfig?.direction == Axis.horizontal
          ? scrollConfig!.scrollOffset
          : 0.0,
      scrollConfig?.direction == Axis.vertical
          ? scrollConfig!.scrollOffset
          : 0.0,
    );
  }

  bool followScroll;

  @JsonKey(includeFromJson: false, includeToJson: false)
  // final GlobalKey? callerGK; // option, allowing caller context to be tracked
  // final VoidCallback? onHidden;
  // extend line in the to direction by delta
  double? fromDelta;

  // extend line in the from direction by delta
  double? toDelta;

  TargetPointerType? targetPointerType;

  // bubble
  Color? bubbleOrTargetPointerColor;
  double? bubbleBorderRadius;

  // arrow
  bool? animatePointer;
  Widget Function()? lineLabelBuilder;

  // optional decoration
  DecorationShape? decorationShape;
  ColorOrGradient? decorationFillColors;
  ColorOrGradient? decorationBorderColors;
  double? decorationBorderThickness;
  double? decorationBorderRadius;
  int? decorationStarPoints;

  final Alignment? initialTargetAlignment;
  final Alignment? initialCalloutAlignment;
  Offset? initialCalloutPos;

  Alignment? targetAlignment;
  Alignment? calloutAlignment;

  // Alignment? onScreenAlignment;

  @JsonKey(includeFromJson: false, includeToJson: false)
  CalloutBarrierConfig? barrier;

  // @JsonKey(includeFromJson: false, includeToJson: false)
  // final bool modal;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool showCloseButton;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Offset closeButtonPos;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onCloseButtonPressF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color closeButtonColor;

  // callout gets removed if on top of the overlay manager's stack when removeTop() Callout called.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool forceMeasure;

  final double? minWidth;
  final double? minHeight;

  final double lengthDeltaPc;
  final double? contentTranslateX;
  final double? contentTranslateY;
  final double? targetTranslateX;
  final double? targetTranslateY;
  final bool frameTarget;
  final double scaleTarget;

  double? finalSeparation;

  final double? dragHandleHeight;
  bool draggable;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool canToggleDraggable;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueChanged<Offset>? onDragF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onDragStartedF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueChanged<Offset>? onDragEndedF;

  final double elevation;
  final bool circleShape;
  final bool resizeableH;
  final bool resizeableV;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final ValueChanged<Size>? onResizeF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onDismissedF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TxtChangedF? onTickedF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onHiddenF;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final VoidCallback? onAcceptedF;

  final double draggableEdgeThickness = 16.0;
  final bool alwaysReCalcSize;
  Color? draggableColor;

  // final bool containsTextField;

  bool initialised = false;

  // overlay class must set this callback
  @JsonKey(includeFromJson: false, includeToJson: false)
  VoidCallback? _rebuildOverlayEntryF;

  // MAYBE reinstate
  // better to pass these in to overcome the unwelcome rebuilding of TextField
  // TextEditingController? teC = TextEditingController();
  @JsonKey(includeFromJson: false, includeToJson: false)
  FocusNode focusNode = FocusNode();

  // WidgetBuilder? _cachedCalloutContent;

  // double scrollOffsetX() => scrollConfig?.$2 == Axis.horizontal
  //     ? scrollConfig?.$1?.offset ?? 0.0
  //     : 0.0;
  //
  // double scrollOffsetY() =>
  //     scrollConfig?.$2 == Axis.vertical ? scrollConfig?.$1?.offset ?? 0.0 : 0.0;

  void setRebuildCallback(VoidCallback newCallback) =>
      _rebuildOverlayEntryF = newCallback;

  // transient
  @JsonKey(includeFromJson: false, includeToJson: false)
  BuildContext? opDescendantContext; // passed in by fca.wrapTarget
  // ZoomerState? _zoomer;
  // GlobalKey? _opGK;
  @JsonKey(includeFromJson: false, includeToJson: false)
  OverlayEntry? offstageEntry;

  // GlobalKey? offstageGK;

  @JsonKey(includeFromJson: false, includeToJson: false)
  double? _top;

  double? get top => _top;

  void set top(double? newTop) {
    // if ((newTop??0.0) < 0) {
    //   print('negative top!?');
    // }
    _top = newTop;
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? left;

  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? topEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? leftEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? bottomEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableEdge_OP? rightEdge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? topLeftCorner;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? topRightCorner;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? bottomLeftCorner;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DraggableCorner_OP? bottomRightCorner;

  double? _initialTop;
  double? _initialLeft;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Coord? lineLabelPos;

  // get size of callout - ignore locn - it comes from the offstage overlay - not useful
  // we'll be adding the callout to the overlay relative to the targetRect
  // Size get calloutSize => Size(_calloutW, _calloutH);

  // @JsonKey(includeFromJson: false, includeToJson: false)
  // late bool isHidden;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool needsToScrollH = false;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool needsToScrollV = false;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Offset dragCalloutOffset = Offset.zero;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool dragging = false;

  // for hiding / unhiding
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? savedTop;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? savedLeft;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late double actualTop;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late double actualLeft;

  // either supplied else measured
  double? _calloutW;
  double? _calloutH;

  // ignore: unnecessary_getters_setters
  double? get calloutW => _calloutW;

  // ignore: unnecessary_getters_setters
  double? get calloutH => _calloutH;

  set calloutW(double? newW) => _calloutW = newW;

  set calloutH(double? newH) => _calloutH = newH;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool ignoreCalloutResult;

  // int initialAnimatedPositionDurationMs;

  //Timer? _timer;

  // bool _animatingSeparation = false;
  bool _finishedAnimatingSeparation = false;
  bool _animatingTopLeft = false;
  double _separation = 0;

  // double _alignmentScale = 1.0;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late bool isDraggable;

  // can be set by children in the callout content
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool preventDrag = false;

  Rectangle cR() =>
      Rectangle.fromRect(
        _calloutRect().translate(
          followScroll ? -scrollOffsetX() : 0.0 + (contentTranslateX ?? 0.0),
          followScroll ? -scrollOffsetY() : 0.0 + (contentTranslateY ?? 0.0),
        ),
      );

  @JsonKey(includeFromJson: false, includeToJson: false)
  Timer? removalTimer;

  CalloutConfig({
    // required this.refreshOPParent,
    required this.cId,
    // this.callerGK,
    this.gravity,
    // this.scale = 1.0,
    this.followScroll = true,
    this.forceMeasure = false,
    this.initialCalloutW,
    this.initialCalloutH,
    this.minWidth,
    this.minHeight,

    this.decorationShape,
    this.decorationBorderRadius = 0,
    this.decorationBorderThickness = 0,
    this.decorationStarPoints,
    this.decorationFillColors,
    this.decorationBorderColors,

    this.lengthDeltaPc = 0.95,
    this.contentTranslateX,
    this.contentTranslateY,
    this.targetTranslateX,
    this.targetTranslateY,
    this.targetPointerType,
    this.bubbleOrTargetPointerColor,
    this.bubbleBorderRadius,
    this.barrier,
    // this.modal = false,
    this.showCloseButton = false,
    this.closeButtonPos = const Offset(10, 10),
    this.onCloseButtonPressF,
    this.closeButtonColor = Colors.red,
    this.initialTargetAlignment,
    this.initialCalloutAlignment,
    this.initialCalloutPos,
    // this.onScreenAlignment,
    this.animatePointer = false,
    this.toDelta,
    this.fromDelta,
    this.lineLabelBuilder,
    this.frameTarget = false,
    this.scaleTarget = 1.0,
    this.elevation = 0,
    this.circleShape = false,
    // this.dragHandle,
    this.dragHandleHeight,
    this.draggable = true,
    this.canToggleDraggable = false,
    this.onDragF,
    this.onDragEndedF,
    this.onDragStartedF,
    this.resizeableH = false,
    this.resizeableV = false,
    this.onResizeF,
    this.draggableColor,
    this.showGotitButton = false,
    this.gotitAxis,
    this.onGotitPressedF,
    this.showcpi = false,
    this.onlyOnce,
    // this.containsTextField = false,
    this.alwaysReCalcSize = false,
    this.ignoreCalloutResult = false,
    this.finalSeparation,
    this.onDismissedF,
    this.onTickedF,
    this.onHiddenF,
    this.onAcceptedF,
    // this.initialAnimatedPositionDurationMs = 150,
  }) {
    // fca.logger.i(
    //     'Feature: ${feature} CalloutConfig.decoration: ${decorationShape.toString()}');
    if (decorationShape?.name == DecorationShape.rectangle &&
        (decorationBorderRadius ?? 0.0) > 0.0) {
      decorationShape = DecorationShape.rounded_rectangle();
    }
    // fillColor = Color.fromColor(
    //     Colors.white); //FCallouts().FUCHSIA_X.withValues(alpha:.9);
    if (decorationFillColors != null &&
        !(decorationFillColors!.isAGradient()) &&
        decorationFillColors!.color1 == null) {
      bubbleOrTargetPointerColor ??= decorationFillColors!.color1;
    }

    // assert((dragHandle != null) && (dragHandleHeight != null), 'if using a drag handle, it must have height > 0.0 !');
    // assert((widthF != null && heightF != null) || context != null, 'if either widthF or heightF null, must provide a context for measuring !');
    // if ((widthF == null || heightF == null) && context == null) {
    //   fca.logger.i("doh!");
    // }
    // assert(context == null || (context!.mounted), 'context not mounted!');
    // assert(!fca.anyPresent([feature]) && !fca.alreadyGotit(feature, notUsingHydratedStorage: notUsingHydratedStorage));

    // originalWidth = width;
    // originalHeight = height;

    _calloutW ??= initialCalloutW;
    _calloutH ??= initialCalloutH;

    // in the case where no alignments nor pos are supplied,
    // assumption that the pos should be centre of screen
    targetAlignment = initialTargetAlignment;
    calloutAlignment = initialCalloutAlignment;
    // if (initialCalloutPos != null) {
    //   calloutAlignment = targetAlignment = null;
    // }

    // if (barrier != null) {
    //   barrier!.gradientColors = [];
    //   if (barrier!.opacity > 0.0) {} else {
    //     barrier!.gradientColors ??= const [Colors.black12, Colors.black12];
    //   }
    // }

    initialised = true;
    // set gotit automatically once used
    if (onlyOnce ?? false) {
      fca.gotit(cId);
    }

    isDraggable = draggable;

    // calloutColor = fillColor ?? Colors.white;
    draggableColor ??= Colors.blue.withValues(alpha: .1); //JIC ??

    _separation = finalSeparation ?? 0;

    // this will be used by: final ticker = tickerProvider.createTicker(elapsed)
    // final TickerProvider tickerProvider;
  }

  /// copy constructor
  CalloutConfig cloneWith({
    required String cId,
    ValueNotifier<int>? movedOrResizedNotifier,
    Alignment? gravity,
    double? scale,
    ScrollConfig? scrollConfig,
    bool? forceMeasure,
    double? suppliedCalloutW,
    double? suppliedCalloutH,
    double? minWidth,
    double? minHeight,

    DecorationShape? decorationShape,
    ColorOrGradient? decorationFillColors,
    ColorOrGradient? decorationBorderColors,
    double? decorationBorderThickness,
    double? decorationBorderRadius,
    int? decorationStarPoints,

    double? lengthDeltaPc,
    double? contentTranslateX,
    double? contentTranslateY,
    double? targetTranslateX,
    double? targetTranslateY,
    TargetPointerType? targetPointerType,
    Color? targetPointerColor,
    CalloutBarrierConfig? barrier,
    // bool? modal,
    bool? showCloseButton,
    Offset? closeButtonPos,
    VoidCallback? onCloseButtonPressF,
    Color? closeButtonColor,
    Alignment? initialTargetAlignment,
    Alignment? initialCalloutAlignment,
    Offset? initialCalloutPos,
    bool? animate,
    double? toDelta,
    double? fromDelta,
    Widget Function()? lineLabelBuilder,
    bool? frameTarget,
    double? scaleTarget,
    double? elevation,
    bool? circleShape,
    double? dragHandleHeight,
    bool? draggable,
    bool? canToggleDraggable,
    Function? onDragF,
    Function? onDragEndedF,
    Function? onDragStartedF,
    bool? resizeableH,
    bool? resizeableV,
    ValueChanged<Size>? onResize,
    Color? draggableColor,
    bool? showGotitButton,
    Axis? gotitAxis,
    VoidCallback? onGotitPressedF,
    bool? showcpi,
    bool? onlyOnce,
    // bool? containsTextField,
    bool? alwaysReCalcSize,
    bool? ignoreCalloutResult,
    double? finalSeparation,
    VoidCallback? onDismissedF,
    TxtChangedF? onTickedF,
    VoidCallback? onHiddenF,
    VoidCallback? onAcceptedF,
    int? initialAnimatedPositionDurationMs,
    bool? notUsingHydratedStorage,
    required bool allowScrolling,
  }) {
    return CalloutConfig(
      cId: cId,
      gravity: gravity ?? this.gravity,
      initialTargetAlignment:
      initialTargetAlignment ?? this.initialTargetAlignment,
      initialCalloutAlignment:
      initialCalloutAlignment ?? this.initialCalloutAlignment,
      initialCalloutPos: initialCalloutPos ?? this.initialCalloutPos,
      finalSeparation: finalSeparation ?? this.finalSeparation,
      barrier: barrier ?? this.barrier,
      initialCalloutW: suppliedCalloutW ?? initialCalloutW,
      initialCalloutH: suppliedCalloutH ?? initialCalloutH,
      // decoration
      decorationShape: decorationShape ?? this.decorationShape,
      decorationFillColors: decorationFillColors ?? this.decorationFillColors,
      decorationBorderColors:
      decorationBorderColors ?? this.decorationBorderColors,
      decorationBorderThickness:
      decorationBorderThickness ?? this.decorationBorderThickness,
      decorationBorderRadius:
      decorationBorderRadius ?? this.decorationBorderRadius,
      decorationStarPoints: decorationStarPoints ?? this.decorationStarPoints,

      elevation: elevation ?? this.elevation,
      frameTarget: frameTarget ?? this.frameTarget,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      showGotitButton: showGotitButton ?? this.showGotitButton,
      closeButtonColor: closeButtonColor ?? this.closeButtonColor,
      closeButtonPos: closeButtonPos ?? this.closeButtonPos,
      gotitAxis: gotitAxis ?? this.gotitAxis,
      bubbleOrTargetPointerColor:
      targetPointerColor ?? this.bubbleOrTargetPointerColor,
      targetPointerType: targetPointerType ?? this.targetPointerType,
      animatePointer: animate ?? this.animatePointer,
      lineLabelBuilder: lineLabelBuilder ?? this.lineLabelBuilder,
      fromDelta: fromDelta ?? this.fromDelta,
      toDelta: toDelta ?? this.toDelta,
      lengthDeltaPc: lengthDeltaPc ?? this.lengthDeltaPc,
      contentTranslateX: contentTranslateX ?? this.contentTranslateX,
      contentTranslateY: contentTranslateY ?? this.contentTranslateY,
      targetTranslateX: targetTranslateX ?? this.targetTranslateX,
      targetTranslateY: targetTranslateY ?? this.targetTranslateY,
      scaleTarget: scaleTarget ?? this.scaleTarget,
      resizeableH: resizeableH ?? this.resizeableH,
      resizeableV: resizeableH ?? this.resizeableH,
      draggable: draggable ?? this.draggable,
      draggableColor: draggableColor ?? this.draggableColor,
      dragHandleHeight: dragHandleHeight ?? this.dragHandleHeight,
      onDismissedF: onDismissedF ?? this.onDismissedF,
      onTickedF: onTickedF ?? this.onTickedF,
      followScroll: allowScrolling,
    );
  }

  // // global, reusable offstage measuring overlay entry
  // void renderOffstage(WidgetBuilder widgetToMeasure) {
  //   offstageEntry = OverlayEntry(
  //       builder: (BuildContext ctx) => Offstage(
  //             child: Material(
  //               color: Colors.transparent,
  //               child: Center(
  //                 child: Container(
  //                   key: GetIt.I.get<GlobalKey>(instanceName: getIt_offstageGK),
  //                   child: widgetToMeasure(),
  //                 ),
  //               ),
  //             ),
  //           ));
  //   // only want to do this once, because it forces rebuilds !
  //   Overlay.of(Useful.cachedContext!).insert(offstageEntry!);
  // }

  // Future<Size?> measureThenRemoveOffstageWidget(OverlayEntry entry, GlobalKey gk) async {
  //   // renderOffstage(boxContent)
  //   // measure offstage widget
  //   Rect? rect = findGlobalRect(gk);
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   entry.remove();
  //   fca.logger.i("measured size: $calloutW x $calloutH");
  //   return rect?.size;
  // }

  // Widget calloutOverlayEntryAlreadyMeasured({
  //   required BuildContext context,
  //   required Widget boxContent,
  //   Target? configurableTarget,
  // }) {
  //   if (!initialised || _targetRect == null || calloutSize == Size.zero) return const Icon(Icons.error, color: Colors.deepOrange);
  //
  //   _configurableTarget = configurableTarget;
  //
  //   // // possibly measure content
  //   // if (width == null || height == null) {
  //   //   final rendered = renderOffstage(boxContent);
  //   //   await measureThenRemoveOffstageWidget(rendered.$1, rendered.$2);
  //   // }
  //
  //   // // if (width > Useful.screenW()) _calloutW = Useful.screenW() - 30;
  //   // //if (height > Useful.screenH()) _calloutH = Useful.screenH() - 30;
  //   //
  //   // // get size of callout - ignore locn - it comes from the offstage overlay - not useful
  //   // // we'll be adding the callout to the overlay relative to the targetRect
  //   //fca.logger.i('callout widget size: ${calloutSize}');
  //
  //   // separation should take into account the callout size
  //
  //   /// given a Rect, returns most appropriate alignment between target and callout
  //
  //   // fca.logger.i("overlayChild top:$top");
  //
  //   if ((initialCalloutAlignment == null || initialTargetAlignment == null)) {
  //     // double sw = Useful.scrW;
  //     // double sh = Useful.scrH;
  //
  //     // Offset targetC;
  //     // if (tR() == null) {
  //     //   // not specified target gk, so use screen centre
  //     //   targetC = Offset(
  //     //     (sw - width!) / 2,
  //     //     (sh - Useful.kbdH - height!) / 2,
  //     //   );
  //     // } else {
  //     //   targetC = tR().center;
  //     // }
  //
  //     Rect screenRect = Rect.fromLTWH(0, 0, Useful.scrW, Useful.scrH);
  //     initialTargetAlignment = -Useful.calcTargetAlignmentWithinWrapper(screenRect, tR());
  //     initialCalloutAlignment = -initialTargetAlignment!;
  //
  //     // fca.logger.i("initialCalloutAlignment: ${initialCalloutAlignment.toString()}");
  //     // fca.logger.i("initialTargetAlignment: ${initialTargetAlignment.toString()}");
  //   }
  //
  //   if (top == null) _calcContentTopLeft();
  //
  //   fca.logger.i('$feature: tR() (${tR?.width}x${tR?.height})');
  //
  //   if (tR() == null && initialCalloutPos == null) {
  //     // fca.logger.i('skipping callout(${feature}) - perhaps target not present for some reason.');
  //     return const Icon(Icons.error, color: Colors.orangeAccent, size: 60);
  //   }
  //
  //   if (!skipOnScreenCheck && (top ?? 999) < Useful.viewPadding.top) {
  //     top = Useful.viewPadding.top;
  //   }
  //
  //   // set before we start animating the separation gap
  //   _initialTop ??= top;
  //   _initialLeft ??= left;
  //
  //   if (!_finishedAnimatingSeparation && separation > 0.0 && tR() != null && cE != null) {
  //     var adjustedTopLeft = _adjustTopLeftForSeparation(separation, _initialTop!, _initialLeft!, cE!, tR());
  //     top = adjustedTopLeft.$1;
  //     left = adjustedTopLeft.$2;
  //   }
  //
  //   return Builder(builder: (context) {
  //     return Stack(
  //       children: [
  //         if (notToast && barrierOpacity > 0.0) _createBarrier(),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV)
  //           DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (notToast && arrowType == ArrowType.POINTY) _positionedBubbleBg(),
  //         PositionedBoxContent(this, boxContent),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null) _createPointingLine(),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null && lineLabel != null) _createLineLabel(),
  //         if (notToast && frameTarget && tR() != null) _createTarget(),
  //         if (isConfigurable) _createConfigToolbar(Side.TOP),
  //       ],
  //     );
  //   });
  // }

  // Widget calloutOverlayEntry({
  //   required BuildContext context,
  //   required Widget boxContent,
  //   required GlobalKey? gk,
  //   Target? configurableTarget,
  // }) {
  //   var state = fca.of(context);
  //
  //   if (!initialised) return const Icon(Icons.error, color: Colors.deepOrange);
  //
  //   // fca.logger.i("gk ${gk?.currentWidget.toString()}");
  //   _opGK = gk;
  //
  //   if (!(gk?.currentContext?.mounted ?? false)) {
  //     fca.logger.i('gk not mounted!');
  //   }
  //
  //   _configurableTarget = configurableTarget;
  //
  //   // // possibly measure content
  //   // if (width == null || height == null) {
  //   //   final rendered = renderOffstage(boxContent);
  //   //   await measureThenRemoveOffstageWidget(rendered.$1, rendered.$2);
  //   // }
  //
  //   // // if (width > Useful.screenW()) _calloutW = Useful.screenW() - 30;
  //   // //if (height > Useful.screenH()) _calloutH = Useful.screenH() - 30;
  //   //
  //   // // get size of callout - ignore locn - it comes from the offstage overlay - not useful
  //   // // we'll be adding the callout to the overlay relative to the targetRect
  //   //fca.logger.i('callout widget size: ${calloutSize}');
  //
  //   // separation should take into account the callout size
  //
  //   /// given a Rect, returns most appropriate alignment between target and callout
  //
  //   // fca.logger.i("overlayChild top:$top");
  //
  //   if ((initialCalloutAlignment == null || initialTargetAlignment == null)) {
  //     // double sw = Useful.scrW;
  //     // double sh = Useful.scrH;
  //
  //     // Offset targetC;
  //     // if (tR() == null) {
  //     //   // not specified target gk, so use screen centre
  //     //   targetC = Offset(
  //     //     (sw - width!) / 2,
  //     //     (sh - Useful.kbdH - height!) / 2,
  //     //   );
  //     // } else {
  //     //   targetC = tR().center;
  //     // }
  //
  //     Rect screenRect = Rect.fromLTWH(0, 0, Useful.scrW, Useful.scrH);
  //     initialTargetAlignment = -Useful.calcTargetAlignmentWithinWrapper(screenRect, tR());
  //     initialCalloutAlignment = -initialTargetAlignment!;
  //
  //     // fca.logger.i("initialCalloutAlignment: ${initialCalloutAlignment.toString()}");
  //     // fca.logger.i("initialTargetAlignment: ${initialTargetAlignment.toString()}");
  //   }
  //
  //   if (top == null) _calcContentTopLeft();
  //
  //   fca.logger.i('$feature: tR() (${tR?.width}x${tR?.height})');
  //
  //   if (tR() == null && initialCalloutPos == null) {
  //     // fca.logger.i('skipping callout(${feature}) - perhaps target not present for some reason.');
  //     return const Icon(Icons.error, color: Colors.orangeAccent, size: 60);
  //   }
  //
  //   if (!skipOnScreenCheck && (top ?? 999) < Useful.viewPadding.top) {
  //     top = Useful.viewPadding.top;
  //   }
  //
  //   // set before we start animating the separation gap
  //   _initialTop ??= top;
  //   _initialLeft ??= left;
  //
  //   if (!_finishedAnimatingSeparation && (separation ?? 0.0) > 0.0 && tR() != null && cE != null) {
  //     var adjustedTopLeft = _adjustTopLeftForSeparation(separation!, _initialTop!, _initialLeft!, cE!, tR());
  //     top = adjustedTopLeft.$1;
  //     left = adjustedTopLeft.$2;
  //   }
  //
  //   return Builder(builder: (context) {
  //     return Stack(
  //       children: [
  //         if (notToast && barrier != null && barrier!.opacity > 0.0) _createBarrier(),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.topRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomLeft, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableCorner_OP(alignment: Alignment.bottomRight, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV) DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && resizeableV)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV) DraggableEdge_OP(side: Side.LEFT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableH && !resizeableV)
  //           DraggableEdge_OP(side: Side.RIGHT, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH) DraggableEdge_OP(side: Side.TOP, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (resizeableV && !resizeableH)
  //           DraggableEdge_OP(side: Side.BOTTOM, thickness: draggableEdgeThickness, color: draggableColor!, parent: this),
  //         if (notToast && arrowType == ArrowType.POINTY) _positionedBubbleBg(),
  //         PositionedBoxContent(this, boxContent),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null) _createPointingLine(),
  //         if (notToast && arrowType != ArrowType.NO_CONNECTOR && arrowType != ArrowType.POINTY && tR() != null && lineLabel != null) _createLineLabel(),
  //         if (notToast && frameTarget && tR() != null) _createTarget(),
  //         if (isConfigurable) _createConfigToolbar(Side.TOP),
  //       ],
  //     );
  //   });
  // }

  Widget oeContentWidget({
    required Rect targetRect,
    required WidgetBuilder calloutContentF,
    required VoidCallback rebuildF,
    bool wrapInPointerInterceptor = false,
    bool skipOnScreenCheck = false,
  }) {
    // print('oeContentWidget');

    // experiment ------------------------------------------------------------
    // infer alignment from initialPos
    // if (initialCalloutPos != null) {
    //   var taX = (initialCalloutPos!.dx - targetRect.left) / targetRect.width;
    //   var taY = (initialCalloutPos!.dy - targetRect.top) / targetRect.height;
    //   initialTargetAlignment = Alignment(taX,taY);
    //   initialCalloutAlignment = -initialTargetAlignment!;
    //   _separation ??= 50;initialCalloutPos = null;
    // }
    // experiment ------------------------------------------------------------

    // _zoomer = zoomer;
    // _configurableTarget = configurableTarget;
    // opDescendantContext = context; // used to find nearest parent OverlayPortal for barrier tap to close

    // Rect r = Rect.fromLTWH(targetRect.left, targetRect.top,
    //     targetRect.width * scaleTarget, targetRect.height * scaleTarget);

    return Offstage(
      offstage: fca.isHidden(cId),
      child: _renderCallout(
        targetRect,
        calloutContentF,
        rebuildF,
        wrapInPointerInterceptor,
        skipOnScreenCheck,
      ),
    );
  }

  Widget opContentWidget({
    required BuildContext
    context, // if supplied, will be a descendant of an OverlayPortal
    required Rect targetRect,
    required WidgetBuilder calloutContentF,
    required VoidCallback rebuildF,
    bool wrapInPointerInterceptor = false,
    bool skipOnScreenCheck = false,
  }) {
    opDescendantContext =
        context; // used to find nearest parent OverlayPortal for barrier tap to close
    // _zoomer = Zoomer.of(context);
    return _calloutW == null || _calloutH == null
        ? const Offstage()
        : _renderCallout(
      targetRect,
      calloutContentF,
      rebuildF,
      wrapInPointerInterceptor,
      skipOnScreenCheck,
    );
  }

  // Future<Widget> _measureThenRenderCallout(
  //   BuildContext context,
  //   Rect targetRect,
  //   WidgetBuilder calloutContent,
  //   VoidCallback rebuildF,
  //   // Target? configurableTarget,
  // ) async {
  //   // measure offstage widget
  //   // await Future.delayed(const Duration(milliseconds: 500));
  //
  //   Rect? rect = findGlobalRect(GetIt.I.get<GlobalKey>(instanceName: getIt_offstageGK)!);
  //   if (rect != null) {
  //     _calloutW ??= rect.width;
  //     _calloutH ??= rect.height;
  //     fca.logger.i('_measureThenRenderCallout: width:$calloutW, height:$calloutH');
  //   }
  //   fca.logger.i("measured size: $calloutW x $calloutH");
  //   return _renderCallout(context, targetRect, calloutContent, rebuildF);
  // }

  // double prevSeparation = -1;
  double prevTop = -1;
  double prevLeft = -1;

  Widget _renderCallout(Rect targetRect,
      WidgetBuilder calloutContent,
      VoidCallback rebuildF,
      // Target? configurableTarget,
      bool wrapInPointerInterceptor,
      bool skipOnScreenCheck,) {
    // if (_finishedAnimatingSeparation) {
    //   print('prevsep: $prevSeparation');
    // }
    // if (_separation == 0) {
    //   print('sep 0');
    // }

    _targetRect = targetRect;

    // print('_target: ${_targetRect.toString()}');
    setRebuildCallback(rebuildF);

    // if (initialCalloutPos != null) {
    //   top = max(0.0,initialCalloutPos!.dy);
    //   left = max(0.0, initialCalloutPos!.dx);
    //   BuildContext ctx = fca.rootContext;
    //   var content = calloutContent(ctx);
    //   return _calloutStack(content, wrapInPointerInterceptor);
    // }

    // if (isHotspot && targetAlignment != null) {
    //   print('render: ${targetAlignment.toString()}');
    //   initialCalloutPos = getRelativeCalloutTopLeft(
    //     targetRect: targetRect,
    //     calloutRect: Rect.fromLTWH(0, 0, _calloutW!, _calloutH!),
    //     alignment: (targetAlignment!) * _alignmentScale,
    //   );
    //   calcContentTopLeft(skipOnScreenCheck: skipOnScreenCheck);
    //   calcEndpoints();
    //   BuildContext ctx = fca.rootContext;
    //   var content = calloutContent(ctx);
    //   return _calloutStack(content, wrapInPointerInterceptor);
    // }

    if (targetAlignment == null &&
        calloutAlignment == null &&
        initialCalloutPos == null) {
      BuildContext ctx = fca.rootContext;
      var content = calloutContent(ctx);
      return _calloutStack(content, wrapInPointerInterceptor);
    }

    // // if (width > Useful.screenW()) _calloutW = Useful.screenW() - 30;
    // //if (height > Useful.screenH()) _calloutH = Useful.screenH() - 30;
    //
    // // get size of callout - ignore locn - it comes from the offstage overlay - not useful
    // // we'll be adding the callout to the overlay relative to the targetRect
    //fca.logger.i('callout widget size: ${calloutSize}');

    // separation should take into account the callout size

    /// given a Rect, returns most appropriate alignment between target and callout

    // fca.logger.i("overlayChild top:$top");

    // hotspot callout targets just specify a target alignment,
    // and not a calloutAlignment
    if ((calloutAlignment == null && targetAlignment != null)) {
      /// Calculates the Offset for a given [Alignment] within a [Rect].
      ///
      /// The [Alignment] object is used to determine a point within the rectangle.
      /// For example, `Alignment.topLeft` will return the rect's `topLeft` offset,
      /// `Alignment.center` will return its `center` offset, and so on.
      Offset offsetForAlignment(Rect rect, Alignment alignment) {
        // The alongSize method calculates the offset of the alignment point
        // from the top-left corner of a rectangle of the given size.
        final Offset offsetWithinRect = alignment.alongSize(rect.size);

        // Add the calculated offset to the rect's top-left corner
        // to get the global coordinate.
        return rect.topLeft + offsetWithinRect;
      }

      // var topLeft = translateOffsetForScroll(offsetForAlignment(targetRect, targetAlignment!));
      var topLeft = offsetForAlignment(targetRect, targetAlignment!);

      top = topLeft.dy - calloutH! / 2;
      left = topLeft.dx - calloutW! / 2;
      BuildContext ctx = fca.rootContext;
      var content = calloutContent(ctx);
      return _calloutStack(content, wrapInPointerInterceptor);
    }

    if (initialCalloutPos != null && top == null) {
      left = initialCalloutPos!.dx;
      top = initialCalloutPos!.dy;
    }

    if (initialCalloutPos == null &&
        (calloutAlignment == null || targetAlignment == null)) {
      Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
      if (screenRect.width == _targetRect.width &&
          screenRect.height == _targetRect.height) {
        targetAlignment = calloutAlignment = Alignment.center;
      } else {
        targetAlignment = -fca.calcTargetAlignmentWithinWrapper(
          wrapperRect: screenRect,
          targetRect: tR(),
        );
        calloutAlignment = -targetAlignment!;
        targetAlignment = fca.calcTargetAlignmentWholeScreen(
          tR(),
          _calloutW!,
          _calloutH!,
        );
        calloutAlignment = -targetAlignment!;
      }
    }

    if (top == null) {
      calcContentTopLeft(skipOnScreenCheck: skipOnScreenCheck);
    }

    if (top != null && left != null) {
      // print('rendering: $top, $left');
    } else {
      print('WFT!');
    }

    // fca.logger.i('$feature: tR() (${tR?.width}x${tR?.height})');

    // if (tR() == null && initialCalloutPos == null) {
    //   // fca.logger.i('skipping callout(${feature}) - perhaps target not present for some reason.');
    //   return const Icon(Icons.error, color: Colors.orangeAccent, size: 60);
    // }

    // if ((top ?? 999) < fca.viewPadding.top) {
    //   top = fca.viewPadding.top;
    // }

    prevTop = top!;
    prevLeft = left!;

    // set before we start animating the separation gap
    _initialTop ??= top;
    _initialLeft ??= left;

    // if (cId == 'body panel:default-snippet') fca.logger.i("top $top");

    // fca.logger.i('before adjusting for separation($_separation): pos is $left, $top');

    // if (!_finishedAnimatingSeparation && (_separation > 0.0) && cE != null) {
    // fca.logger.i('ADJUSTING.');
    if (!_finishedAnimatingSeparation && (_separation > 0.0) && cE != null) {
      (double, double) adjustedTopLeft = _adjustTopLeftForSeparation(
        _separation,
        _initialTop!,
        _initialLeft!,
        cE!,
        tR().center,
      );

      // print('adjusted for separation $_separation');
      // print('scroll offset: ${-scrollOffsetY()}');
      top = adjustedTopLeft.$1; // + scrollOffsetY();
      left = adjustedTopLeft.$2; // + scrollOffsetX();
      // print('top: $top');
      // print('left: $left');
    } else {
      // fca.logger.i('NOT ADJUSTING.');
    }

    // if (_finishedAnimatingSeparation) {
    //   if (!calloutWouldNotBeOffscreen(cE!, 0, 0)) {
    //     left = Useful.scrW / 2 - _calloutW! / 2;
    //     top = Useful.scrH / 2 - _calloutH! / 2;
    //   }
    // }

    // fca.logger.i('after adjusting for separation: pos is $left, $top');

    // Clamp to keep callout fully on screen (8px margin on all edges).
    // Skip when caller has opted out of on-screen checks (e.g. overlays that
    // intentionally cover an oversized or partially off-screen target).
    if (!skipOnScreenCheck &&
        _calloutH != null &&
        _calloutW != null &&
        top != null &&
        left != null) {
      const margin = 8.0;
      top = top!.clamp(margin, max(margin, fca.scrH - _calloutH! - margin));
      left = left!.clamp(margin, max(margin, fca.scrW - _calloutW! - margin));
    }

    BuildContext ctx = fca.rootContext;
    var content = calloutContent(ctx);
    return _calloutStack(content, wrapInPointerInterceptor);
  }

  Stack _calloutStack(content, wrapWithPointerInterceptor) {
    if (notToast &&
        targetPointerType != null &&
        targetPointerType?.name != 'none' &&
        targetPointerType?.name != "bubble") {
      // print('line');
    }
    return Stack(
      children: [
        if (notToast && barrier != null && barrier!.opacity > 0.0)
          PointerInterceptor(child: _createBarrier()),
        if (notToast && frameTarget) _createTargetBorder(),
        if (resizeableH && resizeableV)
          topLeftCorner = DraggableCorner_OP(
            alignment: Alignment.topLeft,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && resizeableV)
          topRightCorner = DraggableCorner_OP(
            alignment: Alignment.topRight,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && resizeableV)
          bottomLeftCorner = DraggableCorner_OP(
            alignment: Alignment.bottomLeft,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && resizeableV)
          bottomRightCorner = DraggableCorner_OP(
            alignment: Alignment.bottomRight,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && resizeableV)
          leftEdge = DraggableEdge_OP(
            side: Side.LEFT,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && resizeableV)
          topEdge = DraggableEdge_OP(
            side: Side.TOP,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && resizeableV)
          rightEdge = DraggableEdge_OP(
            side: Side.RIGHT,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && resizeableV)
          bottomEdge = DraggableEdge_OP(
            side: Side.BOTTOM,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && !resizeableV)
          leftEdge = DraggableEdge_OP(
            side: Side.LEFT,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableH && !resizeableV)
          rightEdge = DraggableEdge_OP(
            side: Side.RIGHT,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableV && !resizeableH)
          topEdge = DraggableEdge_OP(
            side: Side.TOP,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (resizeableV && !resizeableH)
          bottomEdge = DraggableEdge_OP(
            side: Side.BOTTOM,
            thickness: draggableEdgeThickness,
            color: draggableColor!,
            parent: this,
            wrapInPointerInterceptor: wrapWithPointerInterceptor,
          ),
        if (notToast && targetPointerType?.name == "bubble")
          _positionedBubbleBg(),
        PositionedBoxContent(
          this,
          content,
          wrapWithPointerInterceptor,
          key: ValueKey(cId),
        ),
        if (notToast &&
            targetPointerType != null &&
            targetPointerType?.name != 'none' &&
            targetPointerType?.name != "bubble")
          _createPointingLine(),
        if (notToast &&
            targetPointerType != null &&
            targetPointerType?.name != 'none' &&
            targetPointerType?.name != "bubble" &&
            lineLabelBuilder != null &&
            tE != null)
          _createLineLabel(),
        // if (isConfigurable && _zoomer != null) _createConfigToolbar(Side.TOP),
      ],
    );
  }

  void setSeparation(double newSeparation) {
    _separation = newSeparation;
    // prevSeparation = newSeparation;
    _rebuildOverlayEntryF?.call();
  }

  void setAlignmentScale(double newScale) {
    // _alignmentScale = newScale;
    _rebuildOverlayEntryF?.call();
  }

  void setTop(double newTop) {
    top = newTop;
    _rebuildOverlayEntryF?.call();
  }

  void setLeft(double newLeft) {
    left = newLeft;
    _rebuildOverlayEntryF?.call();
  }

  void setPos(Offset newPos) {
    top = newPos.dy;
    left = newPos.dx;
    // fca.logger.i('new pos ${newPos.toString()}');
    _rebuildOverlayEntryF?.call();
  }

  void startedAnimatingSeparation() => _finishedAnimatingSeparation = false;

  void finishedAnimatingSeparation() {
    _finishedAnimatingSeparation = true;
    movedOrResizedNotifier?.value++;
  }

  void startedAnimatingTopLeft() => _animatingTopLeft = true;

  void finishedAnimatingTopLeft() => _animatingTopLeft = false;

  bool isAnimating() => !_finishedAnimatingSeparation || _animatingTopLeft;

  /// Calculates the top-left Offset of a calloutRect relative to the targetRect's origin.
  ///
  /// This function determines where the calloutRect should be placed such that its
  /// center is aligned with a specific point on the targetRect, as defined by
  /// the [alignment] parameter.
  ///
  /// - [targetRect]: The rectangle that serves as the anchor point.
  /// - [calloutRect]: The rectangle that needs to be positioned.
  /// - [alignment]: The alignment that describes where the center of the calloutRect
  ///   should be placed relative to the targetRect. For example, Alignment.topCenter
  ///   places the callout's center at the top-center point of the targetRect.
  ///
  /// Returns an [Offset] representing the `calloutRect.topLeft` in the `targetRect`'s
  /// local coordinate system.
  Offset getRelativeCalloutTopLeft({
    required Rect targetRect,
    required Rect calloutRect,
    required Alignment alignment,
  }) {
    // 1. Find the target point on the targetRect based on the alignment.
    // This point is where the calloutRect's center should be.
    // The 'withinRect' method calculates this point in the targetRect's local coordinates.
    final Offset targetPoint = alignment.withinRect(targetRect);

    // 2. Calculate the position of the callout's center to align it with the target point.
    // This is simply the targetPoint itself.
    final Offset calloutCenter = targetPoint;

    // 3. Determine the top-left corner of the calloutRect based on its center position.
    // We subtract half of the callout's width and height from its center point.
    final double calloutTopLeftX = calloutCenter.dx - calloutRect.width / 2;
    final double calloutTopLeftY = calloutCenter.dy - calloutRect.height / 2;

    // 4. Return the calculated top-left offset.
    return Offset(calloutTopLeftX, calloutTopLeftY);
  }

  // function determines whether topLeft and bottomRioht are onScreen
  bool rectWouldNotBeOffscreen(Rect rGlobal) {
    Rect scrRectGlobal = Rect.fromLTWH(
      0,
      0,
      fca.scrW,
      fca.scrH,
    ).translate(scrollOffsetX(), scrollOffsetY());
    bool result =
        scrRectGlobal.contains(rGlobal.topLeft) &&
            scrRectGlobal.contains(rGlobal.bottomRight);
    return result;
  }

  (double, double) _adjustTopLeftForSeparation(double theSeparation,
      double initialTop,
      double initialLeft,
      Coord initialCE,
      Offset targetCentre,) {
    // move cE
    Coord cEafter = Coord.changeDistanceBetweenPoints(
      Coord.fromOffset(targetCentre),
      initialCE,
      theSeparation,
    );

    // translate callout by separation along line
    var deltaX = cEafter.x - initialCE.x;
    var deltaY = cEafter.y - initialCE.y;
    var movedCalloutRect = _calloutRect().translate(deltaX, deltaY);

    bool calloutIsOnScreen = rectWouldNotBeOffscreen(movedCalloutRect);

    if (calloutIsOnScreen) {
      double newLeft = initialLeft;
      double newTop = initialTop;
      if (wouldBeOnscreenX(newLeft + deltaX)) {
        newLeft += deltaX;
      }
      if (wouldBeOnscreenY(initialTop + deltaY)) {
        newTop += deltaY;
      }
      return (newTop, newLeft);
    } else {
      // fca.logger.i("adjustTopLeftForSeparation(max(0, $theSeparation/2))");
      return (prevTop, prevLeft);
      // return _adjustTopLeftForSeparation(max(0, theSeparation / 2), initialTop, inititalLeft, initialCE, initialTR);
    }
  }

  bool wouldBeOnscreenX(double left) {
    // TODO possibly return true here;
    if (_finishedAnimatingSeparation) return true;
    return left + _calloutW! < fca.scrW;
  }

  bool wouldBeOnscreenY(double top) {
    // TODO possibly return true here;
    if (_finishedAnimatingSeparation) return true;
    bool onscreen = top + _calloutH! < fca.scrH - fca.keyboardHeight;
    return onscreen;
  }

  // Alignment _rotateAlignmentBy45(Alignment a, bool clockwise) {
  //   late double newX;
  //   late double newY;
  //   int direction = clockwise ? -1 : 1;
  //   if (a.x == 0.0 && a.y == 0.0) return a;
  //   if (a.y == 0.0) {
  //     newY = a.x * direction;
  //   } else {
  //     newX = (a.y * direction);
  //     if (newX == (a.y * 2 * direction)) {
  //       newX = a.y * direction;
  //       newY = 0;
  //     }
  //   }
  //   return Alignment(newX, newY);
  // }

  Rectangle tR() {
    final scaledRect = Rect.fromLTWH(
      _targetRect.left,
      _targetRect.top,
      scaleTarget * _targetRect.width,
      scaleTarget * _targetRect.height,
    );
    return Rectangle.fromRect(scaledRect);
  }

  // if target is CalloutTarget, it automatically measures itself after a build,
  // otherwise, just measure the widget having this key
  //   Rectangle tR() {
  //     Rect? rect;
  //     if (initialCalloutPos != null) {
  //       fca.logger.i('initialCalloutPos != null');
  //       rect = Rect.fromLTWH(
  //         initialCalloutPos!.dx,
  //         initialCalloutPos!.dy,
  //         _calloutW!,
  //         _calloutH!,
  //       );
  //     } else if (_opGK?.currentWidget == null) {
  //       fca.logger.i("$cId _targetRectangle(): opGK!?.currentWidget == null");
  //       // Rect screenRect = Rect.fromLTWH(0, 0, Useful.scrW, Useful.scrH);
  //       return Rectangle.fromRect(Rect.zero);
  //     } else {
  //       fca.logger.i('_opGK!.globalPaintBounds()');
  //       Rect? r = _opGK!.globalPaintBounds(); //Measuring.findGlobalRect(_opGK!);
  //       if (r == null) return Rectangle.fromRect(Rect.zero);
  //       fca.logger.i("$cId findGlobalRect(_opGK!) = ${r.toString()}");
  //       // adjust for possible scroll
  //       rect = Rect.fromLTWH(
  //         r.left,
  //         r.top,
  //         r.width, // * scaleTarget,
  //         r.height,
  //       ); // * scaleTarget));
  //     }
  //     return Rectangle.fromRect(Rect.fromLTWH(
  //         rect.left + scrollOffsetX(),
  //         rect.top + scrollOffsetY(),
  //         rect.width, // * scaleTarget,
  //         rect.height));
  //   }

  Coord? tE, cE;

  // late Color calloutColor;

  void calcContentTopLeft({bool skipOnScreenCheck = false}) {
    // double startingCalloutCentreLeft;
    // double startingCalloutCentreTop;

    if (initialCalloutPos != null) {
      actualLeft = initialCalloutPos!.dx;
      if (!skipOnScreenCheck && actualLeft < 0) {
        actualLeft = 0.0;
      }
      actualLeft += (followScroll ? -scrollOffsetX() : 0.0);

      actualTop = initialCalloutPos!.dy;
      if (!skipOnScreenCheck && actualTop < 0) {
        actualTop = 0.0;
      }
      actualTop += (followScroll ? -scrollOffsetY() : 0.0);
    } else {
      // restrict targetAlignment s.t. intersection point on target rect border
      if (targetAlignment != null) {
        // No longer needed: final clampedTargetAlignment = ...

        Rect rect = Rect.fromLTWH(0, 0, _targetRect.width, _targetRect.height);

        // Use a helper function to correctly calculate the intersection point
        // on the border, preserving the original direction.
        final targetAlignmentIntersectionLocalPos = getIntersectionOnBorder(
          rect,
          targetAlignment!,
        );

        rect = Rect.fromLTWH(0, 0, calloutW!, calloutH!);

        final calloutAlignmentIntersectionLocalPos = getIntersectionOnBorder(
          rect,
          calloutAlignment!,
        );

        Offset calloutTopLeft = _targetRect.topLeft
            .translate(
          targetAlignmentIntersectionLocalPos.dx,
          targetAlignmentIntersectionLocalPos.dy,
        )
            .translate(
          -calloutAlignmentIntersectionLocalPos.dx,
          -calloutAlignmentIntersectionLocalPos.dy,
        );
        actualTop = calloutTopLeft.dy;
        actualLeft = calloutTopLeft.dx;

        // if (!skipOnScreenCheck);
      }
    }

    dragCalloutOffset = Offset.zero;
    top = actualTop;
    left = actualLeft;
    return;

    // ensure callout will be on onscreen
    // only needs  to be scrollable when can't fit on screen
    // fca.logger.i('============   screenH = ${Useful.screenH()}');
    needsToScrollH = _calloutW! > fca.scrW;
    needsToScrollV = _calloutH! > (fca.scrH - fca.keyboardHeight);
    if (!notToast) {
      fca.logger.i('must skip screen bounds check');
    }
    if (!needsToScrollV && !needsToScrollH) {
      var definitelyOnScreen = fca.ensureOnScreen(
        calloutRect: Rect.fromLTWH(
          actualLeft,
          actualTop,
          _calloutW!,
          _calloutH!,
        ),
        minAlwaysVisibleH: _calloutW!,
        minAlwaysVisibleV: _calloutH!,
        scrollOffsetX: scrollOffsetX(),
        scrollOffsetY: scrollOffsetY(),
        skipOnScreenCheck: skipOnScreenCheck,
      );
      actualTop = definitelyOnScreen.$2;
      actualLeft = definitelyOnScreen.$1;
      // } else if (needsToScrollV) {
      //   actualTop = 0.0;
      // } else if (needsToScrollH) {
      //   actualLeft = 0.0;
    }

    dragCalloutOffset = Offset.zero;

    // don't let callout be off screen
    top = actualTop;
    left = actualLeft;
    // fca.logger.i('top: $top');
    // fca.logger.i('left: $left');
  }

  /// Gemini generated method.
  /// Calculates the intersection point of a line, defined by the rectangle's
  /// center and an alignment, with the rectangle's border.
  static Offset getIntersectionOnBorder(Rect rect, Alignment alignment) {
    // If the alignment is already inside or on the border, just use withinRect.
    if (alignment.x.abs() <= 1.0 && alignment.y.abs() <= 1.0) {
      return alignment.withinRect(rect);
    }

    // The line starts at the center of the rectangle.
    final center = rect.center;

    // And it goes towards the point defined by the alignment.
    final targetPoint = alignment.withinRect(rect);

    // Vector from the center to the target point.
    final dx = targetPoint.dx - center.dx;
    final dy = targetPoint.dy - center.dy;

    double t = 1.0;

    // Calculate the 't' parameter for the line equation P = P1 + t * (P2 - P1)
    // for each of the four rectangle boundaries.
    if (dx != 0) {
      // Check intersection with vertical boundaries (left and right)
      if (dx > 0) {
        // Right edge
        t = min(t, (rect.right - center.dx) / dx);
      } else {
        // Left edge
        t = min(t, (rect.left - center.dx) / dx);
      }
    }

    if (dy != 0) {
      // Check intersection with horizontal boundaries (top and bottom)
      if (dy > 0) {
        // Bottom edge
        t = min(t, (rect.bottom - center.dy) / dy);
      } else {
        // Top edge
        t = min(t, (rect.top - center.dy) / dy);
      }
    }

    // The intersection point is the center plus the scaled direction vector.
    // This gives the offset from the rect's (0,0) top-left origin.
    return center + Offset(dx, dy) * t;
  }

  // bool _isOffscreen() {
  //   // fca.logger.i('left: $actualLeft\ncalloutSize!.width: ${_calloutW!}\nUseful.screenW(): ${Useful.screenW()}');
  //   // fca.logger.i(
  //   //     'top: $actualTop\ncalloutSize!.height: ${_calloutH!}\nUseful.screenH(): ${Useful.screenH()}\nUseful.kbdH(): ${Useful.kbdH()}');
  //   return !skipOnScreenCheck && ((actualLeft + _calloutW!) > Useful.scrW || (actualTop + _calloutH!) > (Useful.scrH - Useful.kbdH));
  // }

  bool get notToast => gravity == null;

  Widget _positionedBubbleBg() {
    // fca.logger.i('_positionedBubbleBg');
    return Positioned(
      top: 0,
      left: 0,
      child: CustomPaint(
        painter: BubbleShape_OP(calloutConfig: this),
        willChange: true,
      ),
    );
  }

  void _onDragStart(DragStartDetails event) {
    if (preventDrag ||
        !isDraggable ||
        event.localPosition.dy >= (dragHandleHeight ?? 9999))
      return;
    dragCalloutOffset = event.localPosition;
    if (!dragging) {
      onDragStartedF?.call();
      dragging = true;
    }
  }

  void _onDragMove(DragUpdateDetails event) {
    if (preventDrag ||
        !isDraggable /* || event.localPosition.dy >= (dragHandleHeight ?? 9999) */) {
      return;
    }
    rebuild(() {
      // print('top: $top old');
      top =
          event.globalPosition.dy -
              dragCalloutOffset.dy +
              (followScroll ? scrollOffsetY() : 0.0);
      // print('top: $top new');
      left =
          event.globalPosition.dx -
              dragCalloutOffset.dx +
              (followScroll ? scrollOffsetX() : 0.0);
      // var definitelyOnScreen = fca.ensureOnScreen(
      //   calloutRect: Rect.fromLTWH(left!, top!, _calloutW!, dragHandleHeight ?? _calloutH!)
      //   // .translate(
      //   // followScroll ? scrollOffsetX() : 0.0,
      //   // followScroll ? scrollOffsetY() : 0.0,
      //   // )
      //   .translate(
      //     contentTranslateX != null ? -contentTranslateX! : 0.0,
      //     contentTranslateY != null ? -contentTranslateY! : 0.0,
      //   ),
      //   minAlwaysVisibleH: _calloutW!,
      //   minAlwaysVisibleV: 0,
      // );
      // left = definitelyOnScreen.$1;
      // top = definitelyOnScreen.$2;

      onDragF?.call(Offset(left!, top!));
      movedOrResizedNotifier?.value++;
    });
  }

  // void moveBy(double hDelta, double vDelta) {
  //   rebuild(() {
  //     if (top == null) return;
  //     moveTo(
  //       left! + hDelta - dragCalloutOffset.dx,
  //       top! + vDelta - dragCalloutOffset.dy,
  //     );
  //   });
  // }

  // void moveBy(double hDelta, double vDelta) {
  //   rebuild(() {
  //     if (top == null) return;
  //     top = top! + vDelta - dragCalloutOffset.dy;
  //     left = left! + hDelta - dragCalloutOffset.dx;
  //     var definitelyOnScreen = FCallouts().ensureOnScreen(
  //       Rect.fromLTWH(
  //         left!,
  //         top!,
  //         _calloutW!,
  //         dragHandleHeight ?? _calloutH!,
  //       ),
  //       _calloutW!,
  //       _calloutH!,
  //     );
  //     left = definitelyOnScreen.$1;
  //     top = definitelyOnScreen.$2;
  //
  //     onDragF?.call(Offset(left!, top!));
  //     movedOrResizedNotifier?.value++;
  //     fca.logger.i('top: $top, left: $left');
  //   });
  // }
  //
  // void moveTo(double newLeft, double newTop) {
  //   rebuild(() {
  //     top = newTop;
  //     left = newLeft;
  //     var definitelyOnScreen = fca.ensureOnScreen(
  //       Rect.fromLTWH(left!, top!, _calloutW!, dragHandleHeight ?? _calloutH!),
  //       _calloutW!,
  //       _calloutH!,
  //     );
  //     left = definitelyOnScreen.$1;
  //     top = definitelyOnScreen.$2;
  //
  //     onDragF?.call(Offset(left!, top!));
  //     movedOrResizedNotifier?.value++;
  //     // fca.logger.i('top: $top, left: $left');
  //   });
  // }

  // Future<void> animateResizeByCornerMove(
  //   Alignment alignment,
  //   double hDelta,
  //   double vDelta, {
  //   required Duration duration,
  //   VoidCallback? afterAnimationF,
  // }) async {
  //   if (left == null || top == null) return;
  //   AnimationController animationController = AnimationController(
  //     duration: duration,
  //     vsync: this,
  //   );
  //   Tween<Offset> tween = Tween<Offset>(
  //     begin: Offset.zero,
  //     end: Offset(hDelta, vDelta),
  //   );
  //   Animation<Offset>? animation = tween.animate(animationController);
  //   Offset prevValue = Offset.zero;
  //   int i = 0;
  //   animation.addListener(
  //     () => rebuild(() {
  //       Offset delta = Offset(
  //         animation.value.dx - prevValue.dx,
  //         animation.value.dy - prevValue.dy,
  //       );
  //       prevValue = animation.value;
  //       fca.logger.i(
  //         '${i++} av ${animation.value} delta ${delta.toString()}, prevDelta ${prevValue.toString()}',
  //       );
  //       if (alignment == Alignment.topLeft) {
  //         if (delta.dx < 0 || _calloutW! + delta.dx >= (minWidth ?? 30)) {
  //           left = left! + delta.dx;
  //           _calloutW = _calloutW! - delta.dx;
  //         }
  //         if (delta.dy < 0 || _calloutH! + delta.dy >= (minHeight ?? 30)) {
  //           top = top! + delta.dy;
  //           _calloutH = _calloutH! - delta.dy;
  //         }
  //       } else if (alignment == Alignment.topRight) {
  //         if (_calloutW! + delta.dx < (minWidth ?? 30)) {
  //           _calloutW = minWidth ?? 30;
  //         } else {
  //           _calloutW = _calloutW! + delta.dx;
  //         }
  //         if (delta.dy < 0 || _calloutH! + delta.dy >= (minHeight ?? 30)) {
  //           top = top! + delta.dy;
  //           _calloutH = _calloutH! - delta.dy;
  //         }
  //       } else if (alignment == Alignment.bottomLeft) {
  //         if (delta.dx < 0 || _calloutW! + delta.dx >= (minWidth ?? 30)) {
  //           left = left! + delta.dx;
  //           _calloutW = _calloutW! - delta.dx;
  //         }
  //         if (_calloutH! + delta.dy < (minHeight ?? 30)) {
  //           _calloutH = minHeight ?? 30;
  //         } else {
  //           _calloutH = _calloutH! + delta.dy;
  //         }
  //       } else if (alignment == Alignment.bottomRight) {
  //         if (_calloutW! + delta.dx < (minWidth ?? 30)) {
  //           _calloutW = minWidth ?? 30;
  //         } else {
  //           _calloutW = _calloutW! + delta.dx;
  //         }
  //         if (_calloutH! + delta.dy < (minHeight ?? 30)) {
  //           _calloutH = minHeight ?? 30;
  //         } else {
  //           _calloutH = _calloutH! + delta.dy;
  //         }
  //       }
  //     }),
  //   );
  //   await animationController.forward();
  //   afterAnimationF?.call();
  //   animationController.dispose();
  // }

  // Future<void> animateCalloutBy(
  //   double hDelta,
  //   double vDelta, {
  //   required Duration durationMs,
  //   VoidCallback? afterAnimationF,
  // }) async {
  //   if (left == null || top == null) return;
  //   AnimationController animationController = AnimationController(
  //     duration: durationMs,
  //     vsync: this,
  //   );
  //   Tween<Offset> tween = Tween<Offset>(
  //     begin: Offset(left!, top!),
  //     end: Offset(left! + hDelta, top! + vDelta),
  //   );
  //   Animation<Offset> animation = tween.animate(animationController);
  //   animation.addListener(() {
  //     moveTo(animation.value.dx, animation.value.dy);
  //   });
  //   movedOrResizedNotifier?.value++;
  //   await animationController.forward();
  //   afterAnimationF?.call();
  //   animationController.dispose();
  // }

  void _onDragEnd(DragEndDetails event) {
    //if (preventDrag || !isDraggable || event.localPosition.dy >= (dragHandleHeight ?? 9999)) return;
    if (dragging) {
      rebuild(() {
        // var definitelyOnScreen = fca.ensureOnScreen(
        //   calloutRect: Rect.fromLTWH(
        //     left!,
        //     top!,
        //     _calloutW!,
        //     dragHandleHeight ?? _calloutH!,
        //   ),
        //   minAlwaysVisibleH: _calloutW!,
        //   minAlwaysVisibleV: 0,
        // );
        // left = definitelyOnScreen.$1;
        // top = definitelyOnScreen.$2;
        if (dragging) {
          onDragF?.call(Offset(left!, top!));
          onDragEndedF?.call(Offset(left!, top!));
          // update child overlay(s)
          movedOrResizedNotifier?.value++;
          // _refreshParentStateF(event.position);
        }
      });
      dragging = false;
    }
  }

  Widget _closeButton() =>
      Positioned(
        top: closeButtonPos.dy,
        right: closeButtonPos.dx,
        child: IconButton(
          iconSize: 24,
          icon: Icon(Icons.close, color: closeButtonColor),
          onPressed: () {
            onCloseButtonPressF?.call();
            fca.dismiss(cId);
            fca.findCallout<OverlayPortalController>(cId)?.hide();
          },
        ),
      );

  Widget _gotitButton() =>
      Blink(
        animateColor: false,
        child: IconButton(
          tooltip: "got it - don't show again.",
          iconSize: 36,
          icon: const Icon(Icons.thumb_up, color: Colors.orangeAccent),
          onPressed: () {
            fca.gotit(cId);
            fca.findCallout<OverlayEntry>(cId)?.remove();
            fca.findCallout<OverlayPortalController>(cId)?.hide();
            onGotitPressedF?.call();
          },
        ),
      );

  Widget _cpi() =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      );

  Widget _possiblyScrollableContents(Widget contents,
      wrapWithPointerInterceptor,) {
    bool renderingABarrier =
        notToast && barrier != null && barrier!.opacity > 0.0;

    var child = wrapWithPointerInterceptor && !renderingABarrier
        ? PointerInterceptor(debug: true, child: contents)
        : contents;
    return SizedBox(
      width: _calloutW!,
      height: _calloutH!,
      child: (needsToScrollV || needsToScrollH)
          ? SingleChildScrollView(scrollDirection: Axis.vertical, child: child)
          : child,
    );
  }

  // Widget _possiblyScrollableContents(Widget contents) =>
  //     (needsToScrollV || needsToScrollH)
  //         ? SizedBox(
  //       width: calloutW,
  //       height: calloutH,
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.vertical,
  //         child: Hero(tag: 'callout-content', child: contents),
  //       ),
  //     )
  //         : SizedBox(width: _calloutW!, height: _calloutH!, child: contents);

  Widget _createPointingLine() {
    // Rect tr = tR()
    //     .translate(
    //   followScroll ? -scrollOffsetX() : 0.0,
    //   followScroll ? -scrollOffsetY() : 0.0,
    // );

    calcEndpoints();

    if (tE == null ||
        cE == null ||
        !tE!.asOffset.isFinite ||
        !cE!.asOffset.isFinite) {
      // One of the endpoints is not yet calculated or is invalid (NaN/infinity).
      // Don't attempt to draw the line yet.
      return const Offstage();
    }

    if (tE != null && cE != null) {
      Rect r = Rect.fromPoints(
        tE!.asOffset,
        cE!.asOffset,
      );
      Offset to = tE!.asOffset.translate(-r.left, -r.top);
      Offset from = cE!.asOffset.translate(
        -r.left,
        -r.top,
        // )
        // .translate(
        //   followScroll ? -scrollOffsetX() : 0.0,
        //   followScroll ? -scrollOffsetY() : 0.0,
      );
      Line line = Line(Coord.fromOffset(from), Coord.fromOffset(to));
      double lineLen = line.length();
      // print('lineLen is $lineLen');
      //Rect inflatedTargetRect = targetRect.inflate(separation / 2);
      // Rect calloutrect = _calloutRect();
      //bool overlaps = calloutrect.overlaps(inflatedTargetRect);
      // don't show line if gap between endpoints < specifid separation
      bool veryClose = lineLen <= 30;
      Rect tr = tR();
      var scrolledTargetRect = Rect.fromLTWH(
        tr.left + scrollOffsetX(),
        tr.top + scrollOffsetY(),
        tr.width,
        tr.height,
      );
      if (veryClose) {
        // fca.logger.i("not drawing pointing line - too close!");
        return const Offstage();
      }
      if (cR().overlaps(scrolledTargetRect)) {
        // fca.logger.i("not drawing pointing line - callout overlaps target!");
        return const Offstage();
      }

      // // only show the line if callout does not overlap (padded) target
      // if (//targetRect.contains(cE.asOffset) ||
      //     (calloutRect().overlaps(targetRect.inflate(50))))
      //   return IgnoreP_contentointer(child: Offstage());

      Widget pointingLine = IgnorePointer(
        child: PointingLine(
          targetPointerType?.reverse ?? false ? to : from,
          targetPointerType?.reverse ?? false ? from : to,
          targetPointerType ?? TargetPointerType.thin_line(),
          bubbleOrTargetPointerColor ?? Colors.grey,
          lengthDeltaPc: lengthDeltaPc,
          animate: animatePointer ?? false,
        ),
      );

      // computer pos for line label
      //if (lineLabel != null) lineLabelPos = Line(tE,cE).midPoint();

      return Positioned(top: r.top, left: r.left, child: pointingLine);
    } else {
      return const Offstage();
    }
  }

  Widget _createLineLabel() {
    // bool pointingDown = tE!.y < cE!.y;
    // bool pointingRight = tE!.x < cE!.x;
    return Positioned(
      top: (tE!.y + cE!.y) / 2,
      left: (tE!.x + cE!.x) / 2,
      child: IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: lineLabelBuilder?.call(),
        ),
      ),
    );
  }

  Widget _createTargetBorder() {
    // final sh = scrollOffsetX();
    // final sv = scrollOffsetY();
    final tr = tR();
    //.translate(-scrollOffsetX(), -scrollOffsetY());
    // final top = tr.top; //+sv;
    // final left = tr.left; //+sh;
    // print('scrollOffset: $sv, tr.top: ${tr.top} pos top: $top');
    return Positioned(
      left: tr.left,
      top: tr.top,
      child: Material(
        color: Colors.yellow.withValues(alpha: .3),
        child: GestureDetector(
          onTap: onBarrierTap,
          child: Container(
            color: Colors.transparent,
            width: tr.width,
            height: tr.height,
          ),
        ),
      ),
    );
  }

  //   Widget _createConfigToolbar(Side side) {
  //     Widget toolbar = CalloutConfigToolbar(
  //       zoomer: _zoomer!,
  //       side: Side.TOP,
  //       parent: this,
  //       onParentBarrierTappedF: barrier?.onTappedF ??
  //           () {
  //             //fca.logger.i("missing onParentBarrierTappedF!");
  //           },
  //     );
  // // toolbar = Container(width: 500, height:  20, color: Colors.red,);
  //     return toolbar;
  //   }

  Widget _createBarrier() {
    final tr = tR();
    if (barrier!.excludeTargetFromBarrier && tr.size != Size.zero) {
      return ModalBarrierWithCutout(
        cutoutRect: tr,
        round: barrier!.roundExclusion,
        color: barrier!.color.withValues(alpha: barrier!.opacity),
        opacity: barrier!.opacity,
        dismissible: barrier?.dismissible ?? true,
        onDismiss: onBarrierTap,
      );
    }
    return ModalBarrier(
      color: barrier!.color.withValues(alpha: barrier!.opacity),
      dismissible: barrier?.dismissible ?? true,
      onDismiss: onBarrierTap,
    );
  }

  void onBarrierTap() {
    if (barrier?.closeOnTapped ?? false) {
      if (opDescendantContext != null) {
        WrappedCalloutState? state = WrappedCallout.of(opDescendantContext!);
        state?.hideOP();
        onDismissedF?.call();
      } else {
        fca.dismiss(cId);
      }
    } else if (barrier?.hideOnTapped ?? false) {
      if (opDescendantContext != null) {
        WrappedCalloutState? state = WrappedCallout.of(opDescendantContext!);
        state?.hideOP();
        onHiddenF?.call();
      } else {
        fca.hide(cId);
        onHiddenF?.call();
      }
    }
    barrier?.onTappedF?.call();
  }

  //   Widget _createBarrierOLD() => Positioned.fill(
  //           child: PointerInterceptor(
  //         child: IgnorePointer(
  //           ignoring: !(modal || barrier!.closeOnTapped),
  //           child: Listener(
  //               behavior: HitTestBehavior.translucent,
  //               onPointerUp: (_) {
  //                 if (barrier!.closeOnTapped) {
  //                   if (opDescendantContext != null) {
  //                     CalloutState? state = fca.of(opDescendantContext!);
  //                     state?.hideOP();
  //                   } else {
  //                     fca.dismiss(feature);
  //                   }
  //                 }
  //                 barrier!.onTappedF?.call();
  //               },
  // // barrier now never tappable, because no way to pass taps through to lower widget, such as a button outside of the callout
  // // onPointerDown: (_) {
  // //   barrierTapped = true;
  // //   completed(false);
  // //   onBarrierTappedF?.call();
  // // },
  //               child: !kIsWeb && tR() != null
  //                   ? ColorFiltered(
  //                       colorFilter: ColorFilter.mode(Colors.black.withValues(alpha:barrier!.opacity), BlendMode.srcOut),
  //                       child: Container(
  //                         decoration: const BoxDecoration(
  //                           color: Colors.transparent,
  //                         ),
  //                         child: Stack(
  //                           children: [
  //                             Positioned(
  //                               top: tR().top - barrier!.holePadding - (vScrollController?.offset ?? 0.0),
  //                               left: tR().left - barrier!.holePadding - (hScrollController?.offset ?? 0.0),
  //                               child: Container(
  //                                 height: tR().height + barrier!.holePadding * 2,
  //                                 width: tR().width + barrier!.holePadding * 2,
  //                                 decoration: BoxDecoration(
  //                                   boxShadow: const [
  //                                     BoxShadow(
  //                                       color: Colors.red,
  //                                       blurRadius: 5.0,
  //                                       spreadRadius: 2.0,
  //                                     ),
  //                                   ],
  //                                   color: Colors.black,
  // // Color does not matter but should not be transparent
  //                                   borderRadius:
  //                                       barrier!.hasCircularHole ? BorderRadius.circular(tR().height / 2 + barrier!.holePadding) : BorderRadius.zero,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //                   : barrier!.gradientColors?.isNotEmpty ?? false
  //                       ? Container(
  //                           decoration: BoxDecoration(
  //                             gradient: LinearGradient(
  //                               end: Alignment.topCenter,
  //                               begin: Alignment.bottomCenter,
  //                               colors: barrier!.gradientColors!,
  //                             ),
  //                           ),
  //                         )
  //                       : Container(
  //                           color: Colors.black.withValues(alpha:barrier!.opacity),
  //                         )
  // //     : ClipPath(
  // //   clipper: DarkScreenWithHolePainter1(tR, barrierOpacity, padding: barrierHolePadding, round: barrierHasCircularHole),
  // //   child: Container(
  // //     color: Colors.black.withValues(alpha:barrierOpacity),
  // //   ),
  // // )
  // // CustomPaint(
  // //     size: Size(screenW, screenH),
  // //     painter: DarkScreenWithHolePainter2(tR, barrierOpacity, padding: barrierHolePadding, round: barrierHasCircularHole)
  // // )
  // // TweenAnimationBuilder<Color>(
  // //   duration: kThemeAnimationDuration,
  // //   tween: ColorTween(
  // //     begin: Colors.transparent,
  // //     end: barrierOpacity != null ? Colors.black.withValues(alpha:barrierOpacity) : Colors.transparent,
  // //   ),
  // //   builder: (context, color, child) {
  // //     return ColoredBox(color: color);
  // //   },
  // // ),
  //               ),
  //         ),
  //       ));

  Rect _calloutRect() =>
      Rect.fromLTWH(
        left ?? 0.0,
        top ?? 0.0,
        _calloutW ?? double.infinity,
        _calloutH ?? double.infinity,
      );

  // Offset _calloutCentre() => _calloutRect().center;

  // return target rectangle if target found, otherwise null
  void calcEndpoints() {
    // allow for possible transform and cutout padding
    final tr = tR();

    Offset tCentre = tr.center;
    Rectangle scrollAwareCR = Rectangle.fromRect(cR());
    Offset cCentre = scrollAwareCR.center;
    Line line = Line.fromOffsets(cCentre, tCentre);
    tE = Rectangle.getTargetIntersectionPoint2(
      Coord.fromOffset(cCentre),
      line,
      Rectangle.fromRect(tr),
    );
    // if (tE == null) {
    //   print('FUCK tE null!');
    // }
    cE = Rectangle.getTargetIntersectionPoint2(
      Coord.fromOffset(tCentre),
      line,
      scrollAwareCR,
    );
    // if (cE == null) print('FUCK cE null!');
    if (tE != null && toDelta != null && toDelta != 0.0) {
      tE = Coord.changeDistanceBetweenPoints(cE!, tE!, toDelta);
    }
    if (cE != null && fromDelta != null && fromDelta != 0.0) {
      cE = Coord.changeDistanceBetweenPoints(tE!, cE!, fromDelta);
    }
  }

  void rebuild(VoidCallback? f) {
    f?.call();
    _rebuildOverlayEntryF?.call();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

// void redraw() {
//   if (_cachedCalloutContent == null || _rebuildOverlayEntryF == null) return;
//   oeContentWidget(
//     targetRect: tR(),
//     calloutContent: _cachedCalloutContent!,
//     rebuildF: _rebuildOverlayEntryF!,
//   );
// }
}

class CalloutBarrierConfig {
  final bool closeOnTapped;
  final bool hideOnTapped;
  final VoidCallback? onTappedF;
  double opacity;
  Color color;
  bool excludeTargetFromBarrier;

  // final double cutoutPadding;

  // create a circular hole in the barrier? false means rectangular
  bool roundExclusion;
  final bool dismissible;

  CalloutBarrierConfig({
    this.closeOnTapped = true,
    this.hideOnTapped = false,
    this.onTappedF,
    this.opacity = 0.5,
    this.color = Colors.black,
    this.excludeTargetFromBarrier = false,
    // this.cutoutPadding = 0.0,
    this.roundExclusion = false,
    this.dismissible = true,
  });
}

class PositionedBoxContent extends StatelessWidget {
  final CalloutConfig cc;
  final Widget child;
  final bool wrapWithPointerInterceptor;

  const PositionedBoxContent(this.cc,
      this.child,
      this.wrapWithPointerInterceptor, {
        super.key,
      });

  static PositionedBoxContent? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<PositionedBoxContent>();

  @override
  Widget build(BuildContext context) {
    if (cc.initialCalloutPos == null &&
        cc.calloutAlignment == null &&
        cc.targetAlignment == null) {
      Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
      cc.targetAlignment = -fca.calcTargetAlignmentWithinWrapper(
        wrapperRect: screenRect,
        targetRect: cc.tR(),
      );
      cc.calloutAlignment = -cc.targetAlignment!;
    }

    // var decoration = cc.decorationShape.toDecoration(
    //   fillColorValues: ColorValues(color1Value: cc.fillColor?.value),
    //   borderColorValues: ColorValues(color1Value: cc.borderColor?.value),
    //   borderRadius: cc.borderRadius,
    //   thickness: cc.borderThickness,
    //   starPoints: cc.starPoints,
    // );
    // ShapeBorder? sb;
    // if (decoration is ShapeDecoration) {
    //   final ob = decoration;
    //   sb = ob.shape;
    // }

    double topPos =
        (cc.followScroll ? -cc.scrollOffsetY() : 0.0) +
            (cc.top ?? 0) +
            (cc.contentTranslateY ?? 0.0);

    return Positioned(
      top: topPos,
      left:
      (cc.followScroll ? -cc.scrollOffsetX() : 0.0) +
          (cc.left ?? 0) +
          (cc.contentTranslateX ?? 0.0),
      child: GestureDetector(
        onTap: () {
          fca.logger.i('PositionedBoxContent onTap');
        },
        // onTapDown: cc._onContentPointerDown,
        onPanStart: cc._onDragStart,
        onPanUpdate: cc._onDragMove,
        onPanEnd: cc._onDragEnd,
        onPanCancel: () {
          cc._onDragEnd(DragEndDetails());
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cc.decorationBorderRadius ?? 0.0),
          child: Material(
            type: MaterialType.canvas,
            color: Colors.transparent,
            elevation: cc.elevation,
            child: Container(
              decoration: (cc.decorationShape ?? DecorationShape.rectangle())
                  .toDecoration(
                fillColorOrGradient: cc.decorationFillColors,
                borderColorOrGradient: cc.decorationBorderColors,
                borderRadius: cc.decorationBorderRadius,
                borderThickness: cc.decorationBorderThickness,
                starPoints: cc.decorationStarPoints,
              ),
              // color: cc.decorationShape == null ? cc.decorationUpTo6FillColors?.onlyColor : null,
              child: FocusableActionDetector(
                focusNode: cc.focusNode,
                autofocus: true,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: cc.showGotitButton
                          ? Flex(
                        direction: cc.gotitAxis ?? Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: calloutContent(
                              cc,
                              wrapWithPointerInterceptor,
                            ),
                          ),
                          if (cc.gotitAxis != null && !cc.showcpi)
                            cc._gotitButton(),
                          if (cc.showcpi) cc._cpi(),
                        ],
                      )
                          : calloutContent(cc, wrapWithPointerInterceptor),
                    ),
                    if (cc.showCloseButton) cc._closeButton(),
                  ],
                ),
              ),
            ),
          ),
        ), // TRUE means treat as invisible, and pass events down below
      ),
    );
  }

  Widget calloutContent(CalloutConfig cc, wrapWithPointerInterceptor) =>
      cc.draggable
          ? MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: cc._possiblyScrollableContents(
          child,
          wrapWithPointerInterceptor,
        ),
      )
          : cc._possiblyScrollableContents(child, wrapWithPointerInterceptor);
}
