import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts/src/lines/pointing_line.dart';

// import 'package:flutter_callouts/src/api/callouts/pointing_line.dart';

mixin LineMixin {
  /// connecting line callout between the centres of 2 GK widget rects
  OverlayEntry showLine({
    required CalloutId lineId,

    required GlobalKey fromGK,
    required GlobalKey toGK,

    double? fromDelta,
    double? toDelta,

    Function? onExpiredF,
    TargetPointerType? arrowType,
    Color arrowColor = Colors.grey,

    bool animate = false,
    int removeAfterMs = 0,
  }) {
    OverlayEntry? lineEntry;

    if (removeAfterMs > 0) {
      // print('removeAfterMS: $removeAfterMs');
      Timer(Duration(milliseconds: removeAfterMs), () {
        lineEntry?.remove();
      });
    }

    lineEntry = OverlayEntry(
      builder: (BuildContext ctx) {
        final endPoints = _calcLineEndpoints(
          fromGK: fromGK,
          toGK: toGK,
          fromDelta: fromDelta,
          toDelta: toDelta,
        );
        if (endPoints.$1 == null || endPoints.$2 == null) {
          return const Offstage();
        }
        Offset? fromE = endPoints.$1!.asOffset;
        Offset? toE = endPoints.$2!.asOffset;
        Rect r = Rect.fromPoints(toE, fromE);

        return Positioned(
          top: r.top,
          left: r.left,
          child: IgnorePointer(
            child: SizedBox(
              width: 999,
              height: 60,
              child: PointingLine(
                fromE,
                toE,
                arrowType ?? TargetPointerType.thin_line(),
                arrowColor,
                animate: animate,
              ),
            ),
          ),
        );
      },
    );

    fca.overlayState?.insert(lineEntry);

    return lineEntry;
  }

  (Coord? fromE, Coord? toE) _calcLineEndpoints({
    required GlobalKey toGK,
    required GlobalKey fromGK,
    double? toDelta,
    double? fromDelta,
  }) {
    Rectangle? toR = _rectangleFromGK(toGK);
    if (toR != null) {
      Rectangle? fromR;
      fromR = _rectangleFromGK(fromGK);
      if (fromR != null) {
        var toCentre = toR.center;
        var fromCentre = fromR.center;
        Line line = Line.fromOffsets(fromCentre, toCentre);

        Coord? toE = Rectangle.getTargetIntersectionPoint2(
          Coord.fromOffset(fromCentre),
          line,
          toR,
        );
        Coord? fromE = Rectangle.getTargetIntersectionPoint2(
          Coord.fromOffset(toCentre),
          line,
          fromR,
        );

        if (toE != null && fromE != null && toDelta != null && toDelta != 0.0) {
          toE = Coord.changeDistanceBetweenPoints(fromE, toE, toDelta);
        }

        if (fromE != null &&
            toE != null &&
            fromDelta != null &&
            fromDelta != 0.0) {
          fromE = Coord.changeDistanceBetweenPoints(toE, fromE, fromDelta);
        }
        return (fromE!, toE!);
      }
    }
    return (null, null);
  }

  Rectangle? _rectangleFromGK(GlobalKey gk) {
    if (gk.currentWidget == null) {
      print('gk not found in the widget tree - assuming no target specified!');
      return null;
    } else {
      Rect? r = gk.globalPaintBounds(); //Measuring.findGlobalRect(gk);
      return r != null ? Rectangle.fromRect(r) : null;
    }
  }
}
