import 'package:flutter/material.dart';
import 'package:snacky/src/controller/snacky_controller.dart';

class SnackyNavigationObserver extends NavigatorObserver {
  final SnackyController? snackyController;

  SnackyController get _snackyController =>
      snackyController ?? SnackyController.instance;

  SnackyNavigationObserver({
    this.snackyController,
  }) : super();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _snackyController.cancelAll();
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _snackyController.cancelAll();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
