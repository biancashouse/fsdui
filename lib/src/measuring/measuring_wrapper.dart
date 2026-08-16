import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fsdui/fsdui.dart';

/// Wraps [child] and continuously reports its rendered size (and,
/// optionally, its global position) every time layout runs — e.g. when the
/// child's own content changes size (image loads, text changes) or an
/// ancestor resizes it. For a one-shot measurement right after a widget's
/// own first build instead, see [SelfSizingStateMixin].
class MeasuringWrapper extends SingleChildRenderObjectWidget {
  final ValueChanged<Size> onSizeChangedF;
  final ValueChanged<Offset>? onPosChangedF; // may just want size
  final VoidCallback onMeasuredF;

  const MeasuringWrapper({
    super.key,
    required this.onSizeChangedF,
    this.onPosChangedF,
    super.child,
    required this.onMeasuredF,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _MeasureWidgetRenderObject(onSizeChangedF, onPosChangedF, onMeasuredF);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _MeasureWidgetRenderObject renderObject,
  ) {
    renderObject
      ..onSizeChange = onSizeChangedF
      ..onPosChange = onPosChangedF
      ..onMeasured = onMeasuredF;
  }
}

class _MeasureWidgetRenderObject extends RenderProxyBox {
  Size? oldSize;
  Offset? oldPos;

  ValueChanged<Size> onSizeChange;
  ValueChanged<Offset>? onPosChange;
  VoidCallback onMeasured;

  _MeasureWidgetRenderObject(
    this.onSizeChange,
    this.onPosChange,
    this.onMeasured,
  );

  @override
  void performLayout() {
    super.performLayout();

    fsdui.afterNextBuildDo(() {
      if (child == null || !child!.hasSize) return;

      final Size newSize = child!.size;
      if (oldSize != newSize) {
        oldSize = newSize;
        onSizeChange(newSize);
      }

      if (onPosChange != null) {
        final Offset newPos = child!.localToGlobal(Offset.zero);
        if (oldPos != newPos) {
          oldPos = newPos;
          onPosChange!.call(newPos);
        }
      }

      onMeasured.call();
    });
  }
}
