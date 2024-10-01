import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky.dart';
import 'package:snacky/src/model/snacky_location.dart';

class SnackySlideTransition extends StatefulWidget {
  final Widget child;
  final SnackyLocation snackyLocation;
  final CancelableSnacky cancelableSnacky;
  final SnackyController snackyController;

  const SnackySlideTransition({
    required this.child,
    required this.snackyLocation,
    required this.cancelableSnacky,
    required this.snackyController,
    super.key,
  });

  @override
  State<SnackySlideTransition> createState() => _SnackySlideTransitionState();
}

class _SnackySlideTransitionState extends State<SnackySlideTransition>
    with SingleTickerProviderStateMixin, CancelableSnackyListener {
  Timer? _timer;

  var _animationState = _AnimationState.slideIn;
  Snacky get snacky => widget.cancelableSnacky.snacky;

  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    // Controller
    _controller = AnimationController(
      duration: snacky.transitionDuration,
      vsync: this,
    )..forward().whenCompleteOrCancel(() {
        if (!mounted) return;
        _animationState = _AnimationState.hold;
        _timer = Timer(snacky.showDuration, () {
          if (!mounted) return;
          if (snacky.openUntillClosed) return;
          _slideOut();
        });
      });

    // Animation
    final beginX = widget.snackyLocation == SnackyLocation.topStart ||
            widget.snackyLocation == SnackyLocation.bottomStart
        ? -1
        : widget.snackyLocation == SnackyLocation.topEnd ||
                widget.snackyLocation == SnackyLocation.bottomEnd
            ? 1
            : 0;
    final beginY = widget.snackyLocation == SnackyLocation.top
        ? -1
        : widget.snackyLocation == SnackyLocation.bottom
            ? 1
            : 0;
    _offsetAnimation = Tween<Offset>(
      begin: Offset(beginX.toDouble(), beginY.toDouble()),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: snacky.transitionCurve,
    ));
    widget.cancelableSnacky.attach(this);
    super.initState();
  }

  @override
  void dispose() {
    widget.cancelableSnacky.detach(this);
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }

  @override
  void onSnackyCanceled() => _slideOut();

  void _slideOut() {
    if (_animationState == _AnimationState.slideOut) return;
    _animationState = _AnimationState.slideOut;
    _controller.reverse();
    _timer = Timer(snacky.transitionDuration, () {
      if (!mounted) return;
      widget.cancelableSnacky.removed();
    });
  }
}

enum _AnimationState {
  slideIn,
  hold,
  slideOut;
}
