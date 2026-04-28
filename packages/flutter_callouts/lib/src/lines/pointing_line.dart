import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PointingLine extends HookWidget {
  final Offset from;
  final Offset to;
  final TargetPointerType pointerType;
  final Color arrowColor;
  final double lengthDeltaPc; // between 0 and 1.0
  final bool animate;
  final int pointingAnimationDuration;
  final bool? fromDot;
  final bool? toDot;
  final Color? fromDotColor;
  final Color? toDotColor;

  const PointingLine(
    this.from,
    this.to,
    this.pointerType,
    this.arrowColor, {
    this.lengthDeltaPc = 0.0,
    this.animate = false,
    this.pointingAnimationDuration = 300,
    this.fromDot = false,
    this.toDot = false,
    this.fromDotColor,
    this.toDotColor,
    super.key,
  });

  static double arrowTypeToLineThickness(TargetPointerType size) {
    switch (size.name) {
      case "very_thin_line":
      case "very_thin_reversed_line":
        return 1;
      case "thin_line":
      case "thin_reversed_line":
        return 3;
      case "medium_line":
      case "medium_reversed_line":
        return 10;
      case "large_line":
      case "large_reversed_line":
        return 15;
      // case ArrowType.HUGE":
      // case ArrowType.HUGE_REVERSED":
      //   return 20;
      case "none":
      case "bubble":
        return 1;
    }
    return 1;
  }

  static double arrowTypeToHeadRadius(TargetPointerType size) {
    switch (size.name) {
      case "very_thin_line":
      case "very_thin_reversed_line":
        return 6;
      case "thin_line":
      case "thin_reversed_line":
        return 10;
      case "medium_line":
      case "medium_reversed_line":
        return 13;
      case "large_line":
      case "large_reversed_line":
        return 16;
      // case ArrowType.HUGE":
      // case ArrowType.HUGE_REVERSED":
      //   return 40;
      case "none":
        return 0;
      case "bubble":
        return 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: Duration(milliseconds: pointingAnimationDuration),
    );

    final animation = useMemoized(
      () => Tween(begin: 0.95, end: 1.0).animate(controller),
      [controller],
    );

    final listenable = animate ? animation : null;
    useListenable(listenable);

    useEffect(() {
      if (animate) {
        controller.repeat(reverse: true);
      } else {
        controller.stop();
      }
      return controller.stop;
    }, [animate]);

    final painterAnimation = animate ? animation : null;

    // 1. Create a bounding rectangle from the 'from' and 'to' points.
    final Rect lineBounds = Rect.fromPoints(from, to);

    // 2. Translate the line coordinates to be relative to the top-left
    //    of the bounding rectangle.
    final Offset localFrom = from.translate(
      -lineBounds.left,
      -lineBounds.top,
    );
    final Offset localTo = to.translate(
      -lineBounds.left,
      -lineBounds.top,
    );

    bool wavyLine = pointerType == TargetPointerType.wavy_line();
    // if (wavyLine) {
    //   print('wavy');
    // }
    return wavyLine
        ? SizedBox(
            width: lineBounds.width,
            height: lineBounds.height,
            child: CustomPaint(
              foregroundPainter: WavyLinePainter(
                // 4. Pass the new, local coordinates to the painters.
                from: localFrom,
                to: localTo,
                arrowColor: arrowColor,
                animation: painterAnimation,
                skipArrow: true,
              ),
            ),
          )
        : CustomPaint(
            foregroundPainter: StraightLinePainter(
              // 4. Pass the new, local coordinates to the painters.
              from: localFrom,
              to: localTo,
              lengthDeltaPc: lengthDeltaPc,
              pointerType: pointerType,
              arrowColor: arrowColor,
              animation: painterAnimation,
            ),
          );
  }
}

class StraightLinePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final double lengthDeltaPc;
  final TargetPointerType pointerType;
  final Color arrowColor;
  final Animation<double>? animation;

  StraightLinePainter({
    required this.from,
    required this.to,
    required this.lengthDeltaPc,
    required this.pointerType,
    required this.arrowColor,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Rect r = Rect.fromLTWH(0, 0, size.width, size.height);
    // canvas.drawRect(r, bgPaint(Colors.purple.withValues(alpha:.3)));

    // line must be shortened by radius before drawing starts
    Coord toBefore = Coord.fromOffset(to);
    double radius = PointingLine.arrowTypeToHeadRadius(pointerType);
    Coord toAfter = Coord.changeDistanceBetweenPoints(
      Coord.fromOffset(from),
      toBefore,
      -radius,
    );

    // adjust line length by delta %
    toAfter = Coord(
      x: from.dx + lengthDeltaPc * (toAfter.x - from.dx),
      y: from.dy + lengthDeltaPc * (toAfter.y - from.dy),
    );

    // adjust line length by animation %
    if (animation != null) {
      toAfter = Coord(
        x: from.dx + animation!.value * (toAfter.x - from.dx),
        y: from.dy + animation!.value * (toAfter.y - from.dy),
      );
    }

    // fca.logger.i('to: (${toAfter.x}, ${toAfter.y})');

    double lineThickness = PointingLine.arrowTypeToLineThickness(pointerType);
    canvas.drawLine(
      from,
      toAfter.asOffset,
      _linePaint(
        arrowColor,
        lineThickness,
      ),
    );
    _drawArrowhead(canvas, toAfter, radius);
  }

  _drawArrowhead(Canvas canvas, Coord lineEnd, double radius) {
    var xCenter = lineEnd.x;
    var yCenter = lineEnd.y;

    double angle;
    double x;
    double y;

    Path path = Path();

    angle = math.atan2(lineEnd.y - from.dy, lineEnd.x - from.dx);
    x = radius * math.cos(angle) + xCenter;
    y = radius * math.sin(angle) + yCenter;

    path.moveTo(x, y);

    angle += (1.0 / 3.0) * (2 * math.pi);
    x = radius * math.cos(angle) + xCenter;
    y = radius * math.sin(angle) + yCenter;

    path.lineTo(x, y);

    angle += (1.0 / 3.0) * (2 * math.pi);
    x = radius * math.cos(angle) + xCenter;
    y = radius * math.sin(angle) + yCenter;

    path.lineTo(x, y);

    path.close();

    canvas.drawPath(
      path,
      _linePaint(
        arrowColor,
        PointingLine.arrowTypeToLineThickness(pointerType),
      ),
    );
    canvas.drawPath(path, fca.bgPaint(arrowColor));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Paint _linePaint(Color theColor, double theThickness) => Paint()
    ..color = theColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = theThickness;
}

class WavyLinePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final Color arrowColor;
  final double amplitude;
  final int numWaves;
  final Animation<double>? animation;
  final bool skipArrow;
  final bool fromDot;
  final bool toDot;
  final Color fromDotColor;
  final Color toDotColor;

  WavyLinePainter({
    required this.from,
    required this.to,
    this.arrowColor = Colors.red,
    this.amplitude = 15.0,
    this.numWaves = 3,
    required this.animation,
    this.skipArrow = false,
    this.fromDot = false,
    this.toDot = false,
    this.fromDotColor = Colors.red,
    this.toDotColor = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color =
          arrowColor // Line color
      ..strokeWidth =
          4.0 // Line thickness
      ..style = PaintingStyle
          .stroke // Draw only the outline (stroke)
      ..strokeCap =
          StrokeCap.round; // Rounded ends for line segments for smoothness

    final Path path = Path();
    List<Offset> wavyPoints =
        <
          Offset
        >[]; // Store all points to accurately get the last two for the arrow

    final double deltaX_straight = to.dx - from.dx;
    final double deltaY_straight = to.dy - from.dy;

    // Handle near-vertical lines (where deltaX is negligible)
    if (deltaX_straight.abs() < 0.001) {
      path.moveTo(from.dx, from.dy);
      path.lineTo(to.dx, to.dy);
      wavyPoints.add(from);
      wavyPoints.add(to);
    } else {
      final double slope = deltaY_straight / deltaX_straight;

      path.moveTo(from.dx, from.dy);
      wavyPoints.add(from); // Add the starting point

      // Determine the step size for x iteration.
      // Ensure enough steps for a smooth curve and accurate arrow direction,
      // especially for short lines.
      double stepX = 1.0;
      final double absDeltaX = deltaX_straight.abs();
      if (absDeltaX < 40) {
        stepX = absDeltaX / 40.0; // Aim for at least 40 steps
        if (stepX < 0.1)
          stepX =
              0.1; // Minimum step to prevent excessive points for very small segments
      }

      // Determine the direction of iteration (left-to-right or right-to-left)
      final int direction = (to.dx > from.dx) ? 1 : -1;

      // Iterate along the X-axis from pointA.dx towards pointB.dx
      for (
        double x = from.dx;
        (direction == 1 && x <= to.dx) || (direction == -1 && x >= to.dx);
        x += stepX * direction
      ) {
        final double y_straight = from.dy + slope * (x - from.dx);
        final double x_normalized = (x - from.dx) / deltaX_straight;
        final double waveArgument = numWaves * 2 * math.pi * x_normalized;
        final double y_wavy = y_straight + amplitude * math.sin(waveArgument);

        final Offset currentPoint = Offset(x, y_wavy);
        path.lineTo(currentPoint.dx, currentPoint.dy);
        wavyPoints.add(currentPoint);
      }

      // Ensure the path precisely ends at the x-coordinate of pointB.
      // This is important because the loop's `x += stepX` might not land exactly on `pointB.dx`.
      if (wavyPoints.isEmpty || wavyPoints.last.dx != to.dx) {
        final double xAtB = to.dx;
        final double yStraightAtB = from.dy + slope * (xAtB - from.dx);
        final double xNormalizedAtB = (xAtB - from.dx) / deltaX_straight;
        final double waveArgumentAtB = numWaves * 2 * math.pi * xNormalizedAtB;
        final double yWavyAtB =
            yStraightAtB + amplitude * math.sin(waveArgumentAtB);
        final Offset finalWavyPoint = Offset(xAtB, yWavyAtB);

        path.lineTo(finalWavyPoint.dx, finalWavyPoint.dy);
        wavyPoints.add(finalWavyPoint);
      }
    }

    // Draw the main wavy line
    canvas.drawPath(path, paint);

    // Draw the arrow head if requested and if there are enough points to define a direction
    if (!skipArrow && wavyPoints.length >= 2) {
      final Offset tip = wavyPoints.last;
      final Offset basePointForDirection = wavyPoints[wavyPoints.length - 2];
      _drawArrowHead(canvas, paint, tip, basePointForDirection);
    }

    // Optionally, draw circles at points A and the actual wavy end point
    if (fromDot) {
      if (wavyPoints.isNotEmpty) {
        canvas.drawCircle(from, 5.0, Paint()..color = fromDotColor);
      }
    }
    if (toDot) {
      if (wavyPoints.isNotEmpty) {
        canvas.drawCircle(
          wavyPoints.last,
          5.0,
          Paint()..color = toDotColor,
        ); // Actual end point of wave (green)
      }
    }
  }

  /// Helper method to draw an arrow head at the `tip` pointing from `basePoint`.
  void _drawArrowHead(
    Canvas canvas,
    Paint paint,
    Offset tip,
    Offset basePoint,
  ) {
    const double arrowLength = 15.0; // Length of each arrow head segment
    const double arrowAngle =
        math.pi / 6; // Angle (30 degrees) for the arrow head spread

    // Calculate the direction vector from the point before the tip to the tip itself.
    final Offset direction = tip - basePoint;
    // Calculate the angle of this direction vector relative to the positive x-axis.
    final double angle = math.atan2(direction.dy, direction.dx);

    // Calculate the two points that form the base of the arrow head triangle.
    // These points are offset from the tip by `arrowLength` at `angle +/- arrowAngle`.
    final Offset p1 = Offset(
      tip.dx - arrowLength * math.cos(angle + arrowAngle),
      tip.dy - arrowLength * math.sin(angle + arrowAngle),
    );

    final Offset p2 = Offset(
      tip.dx - arrowLength * math.cos(angle - arrowAngle),
      tip.dy - arrowLength * math.sin(angle - arrowAngle),
    );

    // Draw the two lines that form the arrow head.
    canvas.drawLine(tip, p1, paint);
    canvas.drawLine(tip, p2, paint);
  }

  @override
  bool shouldRepaint(covariant WavyLinePainter oldDelegate) {
    // Repaint only if any of the critical parameters have changed.
    return true;
  }
}
