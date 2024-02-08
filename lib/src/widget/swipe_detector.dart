import 'package:flutter/widgets.dart';

class SwipeDetector extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final Alignment alignment;
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

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return GestureDetector(
      onVerticalDragStart: (details) {
        _dragPositionY = details.globalPosition.dy;
      },
      onVerticalDragUpdate: (details) {
        if (widget.alignment == Alignment.topCenter &&
            details.globalPosition.dy < _dragPositionY) {
          widget.onSwipe();
        } else if (widget.alignment == Alignment.bottomCenter &&
            details.globalPosition.dy > _dragPositionY) {
          widget.onSwipe();
        }
      },
      onHorizontalDragStart: (_) => widget.onSwipe(),
      child: widget.child,
    );
  }
}
