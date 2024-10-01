import 'package:flutter/widgets.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky_location.dart';
import 'package:snacky/src/model/snacky_type.dart';

class Snacky {
  final String title;
  final SnackyType type;
  final String? subtitle;
  final Widget Function(BuildContext, CancelableSnacky)? leadingWidgetBuilder;
  final Widget Function(BuildContext, CancelableSnacky)? trailingWidgetBuilder;
  final Widget Function(BuildContext, CancelableSnacky)? bottomWidgetBuilder;
  final bool openUntillClosed;
  final bool canBeClosed;
  final VoidCallback? onTap;
  final Duration showDuration;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final SnackyLocation? location;

  final Widget Function(BuildContext, CancelableSnacky)? builder;

  const Snacky({
    required this.title,
    this.type = SnackyType.info,
    this.subtitle,
    this.leadingWidgetBuilder,
    this.trailingWidgetBuilder,
    this.bottomWidgetBuilder,
    this.onTap,
    this.canBeClosed = false,
    this.openUntillClosed = false,
    this.showDuration = const Duration(seconds: 4),
    this.transitionDuration = const Duration(milliseconds: 250),
    this.transitionCurve = Curves.easeInOut,
    this.location,
  }) : builder = null;

  const Snacky.widget({
    required this.builder,
    this.showDuration = const Duration(seconds: 4),
    this.transitionDuration = const Duration(milliseconds: 250),
    this.transitionCurve = Curves.easeInOut,
    this.location,
  })  : title = '',
        type = SnackyType.info,
        subtitle = null,
        leadingWidgetBuilder = null,
        trailingWidgetBuilder = null,
        bottomWidgetBuilder = null,
        onTap = null,
        canBeClosed = false,
        openUntillClosed = false;
}
