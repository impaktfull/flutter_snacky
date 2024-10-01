import 'package:flutter/material.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/transition/snacky_slide_transition.dart';
import 'package:snacky/src/widget/snacky_swipe_detector.dart';
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
    return SnackySlideTransition(
      snackyController: snackyController,
      cancelableSnacky: cancelableSnacky,
      child: SafeArea(
        top: snacky.location.isTop,
        bottom: snacky.location.isBottom,
        child: SnackySwipeDetector(
          enabled: cancelableSnacky.isNotCancelled,
          alignment: snacky.location.alignment,
          onSwipe: () => cancelableSnacky.cancel(),
          child: Padding(
            padding: margin,
            child: Material(
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
      ),
    );
  }
}
