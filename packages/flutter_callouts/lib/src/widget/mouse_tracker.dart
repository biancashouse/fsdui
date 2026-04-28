import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MouseTracker extends HookWidget {
  const MouseTracker({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final overlayController = useMemoized(() => OverlayPortalController());
    final targetKey = useMemoized(() => GlobalKey());
    final globalPosition = useState(Offset.zero);
    final localPosition = useState(Offset.zero);
    final widgetSize = useState(Size.zero);

    void updateOverlay(PointerEvent details) {
      globalPosition.value = details.position;
      localPosition.value = details.localPosition;

      final RenderBox? renderBox =
          targetKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        widgetSize.value = renderBox.size;
      }

      if (!overlayController.isShowing) {
        overlayController.show();
      }
    }

    void hideOverlay(PointerEvent details) {
      if (overlayController.isShowing) {
        overlayController.hide();
      }
    }

    return MouseRegion(
      onHover: updateOverlay,
      onExit: hideOverlay,
      child: OverlayPortal(
        controller: overlayController,
        overlayChildBuilder: (context) {
          // Position the overlay near the cursor
          return Positioned(
            left: globalPosition.value.dx + 10,
            // Offset to prevent covering the cursor
            top: globalPosition.value.dy + 10,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Global Pos: (${globalPosition.value.dx.to2dp()}, ${globalPosition.value.dy.to2dp()})\n'
                  'Local Pos: (${localPosition.value.dx.to2dp()}, ${localPosition.value.dy.to2dp()})\n'
                  'Widget Size: (${widgetSize.value.width.to2dp()}x${widgetSize.value.height.to2dp()})',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          );
        },
        child: KeyedSubtree(
          key: targetKey,
          child: child,
        ),
      ),
    );
  }
}

// Extension to format double to 2 decimal places for cleaner display
extension on double {
  String to2dp() => toStringAsFixed(2);
}
