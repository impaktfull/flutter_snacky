import 'package:flutter/material.dart';
import 'package:snacky/src/config/snacky_layout_config.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/transition/snacky_slide_transition.dart';
import 'package:snacky/src/widget/snacky_swipe_detector.dart';
import 'package:snacky/src/widget/touch_feedback.dart';

class BaseSnackyWidget extends StatelessWidget {
  final CancelableSnacky cancelableSnacky;
  final SnackyController snackyController;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final bool disableInkWell;
  final SnackyLayoutConfig layoutConfig;
  final Widget Function(BuildContext, CancelableSnacky)? customBuilder;

  const BaseSnackyWidget({
    required this.cancelableSnacky,
    required this.snackyController,
    required this.layoutConfig,
    this.borderRadius = BorderRadius.zero,
    this.margin = const EdgeInsets.all(16),
    this.disableInkWell = false,
    this.customBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final snacky = cancelableSnacky.snacky;
    final location = layoutConfig.getSnackyLocation(context, snacky);
    return SnackySlideTransition(
      snackyLocation: location,
      snackyController: snackyController,
      cancelableSnacky: cancelableSnacky,
      child: SafeArea(
        top: location.isTop,
        bottom: location.isBottom,
        child: SnackySwipeDetector(
          enabled: cancelableSnacky.isNotCancelled,
          alignment: location.alignment,
          onSwipe: () => cancelableSnacky.cancel(),
          child: Padding(
            padding: margin,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  customBuilder!(context, cancelableSnacky),
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
