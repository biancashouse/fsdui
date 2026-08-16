import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

/// Mix into a `State<T>` to have the widget measure its own rendered [Size]
/// right after [initState]'s first build completes, then refresh (via
/// [setState]) so [selfSize] is available from then on — useful when a
/// widget needs to lay out its own children differently depending on its
/// own dimensions, which aren't known during the very first build.
///
/// Measurement happens exactly once, scheduled from [initState] via
/// [FlutterContentMixins.afterNextBuildDo] rather than a raw
/// `addPostFrameCallback` (project convention — see CLAUDE.md).
mixin SelfSizingStateMixin<T extends StatefulWidget> on State<T> {
  Size? _selfSize;

  /// This widget's own rendered size, once known. Null until the
  /// post-[initState] measurement has completed.
  Size? get selfSize => _selfSize;

  @override
  void initState() {
    super.initState();
    fsdui.afterNextBuildDo(_measureAndRefresh);
  }

  void _measureAndRefresh() {
    if (!mounted) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;
    final size = renderBox.size;
    if (size == _selfSize) return;
    setState(() => _selfSize = size);
    onSelfSized(size);
  }

  /// Called once, right after [selfSize] is first measured (the triggering
  /// [setState] has already been requested by this point). Override to
  /// react to the size becoming known — e.g. notify a parent — without
  /// having to null-check [selfSize] in every build.
  void onSelfSized(Size size) {}
}
