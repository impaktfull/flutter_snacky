import 'package:flutter/material.dart';
import 'package:snacky/snacky.dart';
import 'package:snacky/src/widget/swipe_detector.dart';
import 'package:snacky/src/widget/touch_feedback.dart';

class BaseSnackyWidget extends StatelessWidget {
  final CancelableSnacky cancelableSnacky;
  final SnackyController snackyController;
  final Widget child;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final bool disableInkWell;

  const BaseSnackyWidget({
    required this.cancelableSnacky,
    required this.snackyController,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.margin = const EdgeInsets.all(16),
    this.disableInkWell = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final snacky = cancelableSnacky.snacky;
    return SlideTransitionExample(
      snackyController: snackyController,
      cancelableSnacky: cancelableSnacky,
      child: SafeArea(
        top: snacky.location == SnackyLocation.top,
        bottom: snacky.location == SnackyLocation.bottom,
        child: SwipeDetector(
          enabled: cancelableSnacky.isNotCancelled,
          alignment: snacky.location.alignment,
          onSwipe: () => cancelableSnacky.cancel(),
          child: Padding(
            padding: margin,
            child: Stack(
              children: [
                child,
                if (snacky.onTap != null) ...[
                  Positioned.fill(
                    child: TouchFeedback(
                      onTap: snacky.onTap,
                      disableInkWell: disableInkWell,
                      borderRadius: borderRadius,
                      child: const ColoredBox(color: Colors.transparent),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
