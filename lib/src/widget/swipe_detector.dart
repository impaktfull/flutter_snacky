import 'package:flutter/widgets.dart';

class SwipeDetector extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final AlignmentDirectional alignment;
  final VoidCallback onSwipe;

  const SwipeDetector({
    required this.child,
    required this.enabled,
    required this.alignment,
    required this.onSwipe,
    super.key,
  });

  @override
  State<SwipeDetector> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  var _dragPositionY = 0.0;
  var _dragPositionStart = 0.0;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return GestureDetector(
      onVerticalDragStart: (details) {
        _dragPositionY = details.globalPosition.dy;
      },
      onVerticalDragUpdate: (details) {
        if (widget.alignment.start != 0) return;
        final y = widget.alignment.y;
        if (y < 0 && details.globalPosition.dy < _dragPositionY) {
          // Top notification
          widget.onSwipe();
        } else if (y == 0) {
          // Center notification (do nothing)
        } else if (y > 0 && details.globalPosition.dy > _dragPositionY) {
          // Bottom notification
          widget.onSwipe();
        }
        if (widget.alignment == AlignmentDirectional.topCenter &&
            details.globalPosition.dy < _dragPositionY) {
          widget.onSwipe();
        } else if (widget.alignment == AlignmentDirectional.bottomCenter &&
            details.globalPosition.dy > _dragPositionY) {
          widget.onSwipe();
        }
      },
      onHorizontalDragStart: (details) {
        _dragPositionStart = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        final start = widget.alignment.start;
        if (start < 0 && details.globalPosition.dx < _dragPositionStart) {
          // Start notification
          widget.onSwipe();
        } else if (start == 0) {
          // Center notification (do nothing)
        } else if (start > 0 &&
            details.globalPosition.dx > _dragPositionStart) {
          // End notification
          widget.onSwipe();
        }
      },
      child: widget.child,
    );
  }
}
