import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DoubleTappable extends StatefulWidget {
  final VoidCallback? onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback? onLongPressDown;
  final Widget child;

  const DoubleTappable({
    this.onTap,
    required this.onDoubleTap,
    this.onLongPressDown,
    required this.child,
    super.key,
  });

  @override
  State<DoubleTappable> createState() => _DoubleTappableState();
}

class _DoubleTappableState extends State<DoubleTappable> {
  Timer? _tapTimer;

  // This handler is called immediately on every tap down.
  void _handleTapDown(TapDownDetails details) {
    // If a timer from a previous tap is still active, this is a double tap.
    if (_tapTimer?.isActive ?? false) {
      _tapTimer!.cancel(); // Cancel the pending single-tap.
      widget.onDoubleTap(); // Fire the double-tap event.
    } else {
      // This is the first tap. Start a timer.
      // If the timer completes without being canceled, it was a single tap.
      _tapTimer = Timer(kDoubleTapTimeout, () {
        widget.onTap?.call();
      });
    }
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    _tapTimer?.cancel();
    widget.onLongPressDown?.call();
  }

  @override
  void dispose() {
    // Important: cancel any pending timer when the widget is removed.
    _tapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // THE FIX: Use onTapDown to get immediate feedback for every physical tap.
      onTapDown: _handleTapDown,

      onLongPressStart: widget.onLongPressDown != null ? _handleLongPressStart : null,

      // It is also helpful to provide an empty onDoubleTap handler.
      // This explicitly signals to the gesture arena that this widget is
      // interested in double-taps, which helps it win against other
      // competing gestures (like Draggable).
      // onDoubleTap: () {},

      child: widget.child,
    );
  }
}
