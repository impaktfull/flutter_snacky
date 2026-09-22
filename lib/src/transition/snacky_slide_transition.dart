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
  /// Hides the snacky once its `showDuration` has passed.
  Timer? _showTimer;

  /// Removes the snacky once the slide out transition has finished.
  Timer? _removeTimer;

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
    );

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

    if (widget.cancelableSnacky.isCancelled) {
      // Cancelled before it was built: never show it, remove it right away.
      _animationState = _AnimationState.slideOut;
      WidgetsBinding.instance.addPostFrameCallback((_) => _remove());
      return;
    }
    _controller.forward().whenCompleteOrCancel(_onSlideInFinished);
  }

  @override
  void dispose() {
    widget.cancelableSnacky.detach(this);
    _cancelTimers();
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

  void _onSlideInFinished() {
    if (!mounted) return;
    // The slide in is also "finished" when it is interrupted by a slide out.
    if (_animationState != _AnimationState.slideIn) return;
    _animationState = _AnimationState.hold;
    if (snacky.openUntillClosed) return;
    _showTimer = Timer(snacky.showDuration, () {
      _showTimer = null;
      if (!mounted) return;
      _slideOut();
    });
  }

  void _slideOut() {
    if (!mounted) return;
    if (_animationState == _AnimationState.slideOut) return;
    _animationState = _AnimationState.slideOut;
    _cancelTimers();
    _controller.reverse();
    _removeTimer = Timer(snacky.transitionDuration, () {
      _removeTimer = null;
      _remove();
    });
  }

  void _remove() {
    if (!mounted) return;
    widget.cancelableSnacky.removed();
  }

  void _cancelTimers() {
    _showTimer?.cancel();
    _showTimer = null;
    _removeTimer?.cancel();
    _removeTimer = null;
  }
}

enum _AnimationState {
  slideIn,
  hold,
  slideOut;
}
