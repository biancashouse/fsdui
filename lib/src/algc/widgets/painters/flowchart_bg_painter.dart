import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/algc/model/m/flowchart_m.dart';
import 'package:fsdui/src/algc/widgets/painters/paint_helper.dart';

class FlowchartBgPainter extends CustomPainter {
  final FlowchartM fbe;

  FlowchartBgPainter(this.fbe);

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint;

    bgPaint = fbe.isVersionLatest ? fsdui.whiteBgPaint : greyBgPaint;

    Rect innerRect = Rect.fromPoints(
      const Offset(0.0, 0.0),
      Offset(
        fbe.screenPaperW,
        fbe.screenPaperH,
      ),
    );

    canvas.drawRect(innerRect, bgPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
