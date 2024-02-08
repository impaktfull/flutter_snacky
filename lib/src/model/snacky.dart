import 'package:flutter/widgets.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky_location.dart';
import 'package:snacky/src/model/snacky_type.dart';

class Snacky {
  final SnackyType type;
  final String title;
  final Widget Function(BuildContext, CancelableSnacky)? leadingWidgetBuilder;
  final Widget Function(BuildContext, CancelableSnacky)? trailingWidgetBuilder;
  final bool openUntillClosed;
  final bool canBeClosed;
  final String? subtitle;
  final VoidCallback? onTap;
  final Duration showDuration;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final SnackyLocation location;

  const Snacky({
    required this.title,
    this.type = SnackyType.info,
    this.subtitle,
    this.leadingWidgetBuilder,
    this.trailingWidgetBuilder,
    this.onTap,
    this.canBeClosed = false,
    this.showDuration = const Duration(seconds: 4),
    this.transitionDuration = const Duration(milliseconds: 250),
    this.transitionCurve = Curves.easeInOut,
    this.location = SnackyLocation.top,
  }) : openUntillClosed = false;

  const Snacky.openUntillClosed({
    required this.title,
    this.type = SnackyType.info,
    this.subtitle,
    this.leadingWidgetBuilder,
    this.trailingWidgetBuilder,
    this.onTap,
    this.canBeClosed = false,
    this.showDuration = const Duration(seconds: 4),
    this.transitionDuration = const Duration(milliseconds: 250),
    this.transitionCurve = Curves.easeInOut,
    this.location = SnackyLocation.top,
  }) : openUntillClosed = true;
}
