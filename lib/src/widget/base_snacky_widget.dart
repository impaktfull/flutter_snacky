import 'package:flutter/widgets.dart';
import 'package:snacky/snacky.dart';
import 'package:snacky/src/widget/swipe_detector.dart';

class BaseSnackyWidget extends StatelessWidget {
  final CancelableSnacky cancelableSnacky;
  final SnackyController snackyController;
  final Widget child;
  final EdgeInsets margin;

  const BaseSnackyWidget({
    required this.cancelableSnacky,
    required this.snackyController,
    required this.child,
    this.margin = const EdgeInsets.all(16),
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
        child: GestureDetector(
          onTap: snacky.onTap,
          child: SwipeDetector(
            enabled: cancelableSnacky.isNotCancelled,
            alignment: snacky.location.alignment,
            onSwipe: () => cancelableSnacky.cancel(),
            child: Padding(
              padding: margin,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
