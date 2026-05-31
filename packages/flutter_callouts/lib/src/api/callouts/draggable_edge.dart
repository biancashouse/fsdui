import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

Timer? _debounce;

class DraggableEdge_OP extends StatelessWidget {
  final SideEnum side;
  final double thickness;
  final CalloutConfig parent;
  final Color color;
  final bool wrapInPointerInterceptor;

  const DraggableEdge_OP(
      {required this.side, required this.thickness, required this.parent, required this.color, required this.wrapInPointerInterceptor, super.key});

  Axis axis() {
    switch (side) {
      case SideEnum.TOP:
      case SideEnum.BOTTOM:
        return Axis.vertical;
      case SideEnum.LEFT:
      case SideEnum.RIGHT:
        return Axis.horizontal;
    }
  }

  IconData iconData() {
    switch (side) {
      case SideEnum.TOP:
        return Icons.arrow_drop_down;
      case SideEnum.BOTTOM:
        return Icons.arrow_drop_up;
      case SideEnum.LEFT:
        return Icons.arrow_right;
      case SideEnum.RIGHT:
        return Icons.arrow_left;
    }
  }

  @override
  Widget build(BuildContext context) {
    final soY = parent.followScroll ? parent.scrollOffsetY() : 0.0;
    final soX = parent.followScroll ? parent.scrollOffsetX() : 0.0;
    double top = _topLeft(-soX, -soY).dy;
    double left = _topLeft(-soX, -soY).dx;
    return Positioned(
      top: top,
      left: left,
      child: Listener(
        onPointerMove: (PointerMoveEvent event) {
          double newTop = event.position.dy;
          double newLeft = event.position.dx;
          // fca.logger.i("new pos: ${newLeft},${newTop}");
          var deltaX = event.delta.dx;
          var deltaY = event.delta.dy;
          if (side == SideEnum.LEFT) {
            if (deltaX < 0 ||
                parent.calloutW! + deltaX >= (parent.minWidth ?? 30)) {
              parent.setLeft(newLeft+soX);
              parent.calloutW = parent.calloutW! - deltaX;
            }
          } else if (side == SideEnum.TOP) {
            if (deltaY < 0 ||
                parent.calloutH! + deltaY >= (parent.minHeight ?? 30)) {
              parent.setTop(newTop+soY);
              //parent.setLeft(newLeft+soX);
              parent.calloutH = parent.calloutH! - deltaY;
            }
          } else if (side == SideEnum.RIGHT) {
            if (parent.calloutW! + deltaX < (parent.minWidth ?? 30)) {
              parent.calloutW = parent.minWidth ?? 30;
            } else {
              parent.calloutW = parent.calloutW! + deltaX;
            }
          } else if (side == SideEnum.BOTTOM) {
            if (parent.calloutH! + deltaY < (parent.minHeight ?? 30)) {
              parent.calloutH = parent.minHeight ?? 30;
            } else {
              parent.calloutH = parent.calloutH! + deltaY;
            }
          }
          // parent.calloutSize = Size(parent.calloutW, parent.calloutH);
          // fca.logger.i('new height: ${parent.calloutH}');
          parent.movedOrResizedNotifier?.value++;
          parent.rebuild(() {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            // Set up a new debounce timer
            _debounce = Timer(const Duration(milliseconds: 200), () async {
              parent.onResizeF?.call(Size(parent.calloutW!, parent.calloutH!));
            });
          });
        },
        child: PointerInterceptor(
          intercepting: wrapInPointerInterceptor,
          child: Container(
            color: color,
            width: _width(),
            height: _height(),
          ),
        ),
      ),
    );
  }

  Offset _topLeft(soX, soY) {
    Rect calloutRect = Rect.fromLTWH(
        parent.left!, parent.top!, parent.calloutW!, parent.calloutH!)
        .translate(soX, soY);
    if (side == SideEnum.LEFT) {
      return calloutRect.topLeft.translate(-thickness, 0);
    } else if (side == SideEnum.RIGHT) {
      return calloutRect.topRight;
    } else if (side == SideEnum.TOP) {
      return calloutRect.topLeft.translate(0, -thickness);
    } else {
      return calloutRect.bottomLeft;
    }
  }

  double _width() {
    if (side == SideEnum.LEFT || side == SideEnum.RIGHT) {
      return thickness;
    } else {
      return parent.calloutW!;
    }
  }

  double _height() {
    if (side == SideEnum.TOP || side == SideEnum.BOTTOM) {
      return thickness;
    } else {
      return parent.calloutH!;
    }
  }
}
