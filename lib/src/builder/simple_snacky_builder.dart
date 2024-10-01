import 'package:flutter/material.dart';
import 'package:snacky/src/builder/snacky_builder.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky.dart';
import 'package:snacky/src/model/snacky_type.dart';
import 'package:snacky/src/widget/base_snacky_widget.dart';
import 'package:snacky/src/widget/touch_feedback.dart';

enum SimpleSnackyTextType {
  title,
  subtitle,
}

class SimpleSnackyBuilder extends SnackyBuilder {
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color Function(Snacky)? backgroundColorBuilder;
  final Color Function(Snacky)? iconColorBuilder;
  final IconData? Function(Snacky)? iconBuilder;
  final BoxBorder Function(Snacky)? borderBuilder;
  final TextStyle Function(Snacky, SimpleSnackyTextType)? textStyleBuilder;
  final bool disableInkwell;

  const SimpleSnackyBuilder({
    this.backgroundColorBuilder,
    this.iconColorBuilder,
    this.iconBuilder,
    this.borderBuilder,
    this.textStyleBuilder,
    this.margin = const EdgeInsets.all(16),
    this.padding = const EdgeInsets.symmetric(
      vertical: 16,
    ),
    this.disableInkwell = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  @override
  Widget build(
    BuildContext context,
    CancelableSnacky cancelableSnacky,
    SnackyController snackyController,
  ) {
    final snacky = cancelableSnacky.snacky;
    final customBuilder = snacky.builder;
    return BaseSnackyWidget(
      cancelableSnacky: cancelableSnacky,
      snackyController: snackyController,
      margin: margin,
      disableInkWell: disableInkwell,
      borderRadius: borderRadius,
      child: Builder(
        builder: (context) {
          if (customBuilder != null) {
            return customBuilder(context, cancelableSnacky);
          }
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: _getBackgroundColor(snacky),
              border: _getBorder(snacky),
              borderRadius: borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                if (snacky.leadingWidgetBuilder != null) ...[
                  snacky.leadingWidgetBuilder!.call(context, cancelableSnacky),
                  const SizedBox(width: 8),
                ] else ...[
                  Builder(builder: (context) {
                    final leadingIcon = _getLeaderWidget(snacky);
                    if (leadingIcon == null) {
                      return const SizedBox(width: 8);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: leadingIcon,
                    );
                  }),
                ],
                Expanded(
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          snacky.title,
                          style: _getTextStyle(
                            snacky,
                            SimpleSnackyTextType.title,
                          ),
                        ),
                        if (snacky.subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            snacky.subtitle!,
                            style: _getTextStyle(
                              snacky,
                              SimpleSnackyTextType.subtitle,
                            ),
                          ),
                        ],
                        if (snacky.bottomWidgetBuilder != null) ...[
                          snacky.bottomWidgetBuilder!(
                              context, cancelableSnacky),
                        ],
                      ],
                    ),
                  ),
                ),
                if (snacky.trailingWidgetBuilder != null) ...[
                  const SizedBox(width: 8),
                  snacky.trailingWidgetBuilder!.call(context, cancelableSnacky),
                ],
                if (snacky.canBeClosed) ...[
                  const SizedBox(width: 8),
                  TouchFeedback(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () => cancelableSnacky.cancel(),
                    disableInkWell: disableInkwell,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.close,
                        color: _getTextStyle(snacky, SimpleSnackyTextType.title)
                            .color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ] else if (snacky.onTap != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color:
                        _getTextStyle(snacky, SimpleSnackyTextType.title).color,
                  ),
                  const SizedBox(width: 16),
                ] else ...[
                  const SizedBox(width: 16),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(Snacky snacky) {
    if (backgroundColorBuilder != null) {
      return backgroundColorBuilder!.call(snacky);
    }
    return Colors.white;
  }

  BoxBorder _getBorder(Snacky snacky) {
    if (borderBuilder != null) {
      return borderBuilder!.call(snacky);
    }
    return Border.all(
      color: const Color.fromARGB(255, 215, 215, 215),
      width: 1,
    );
  }

  Color _getSnackyTypeColor(Snacky snacky) {
    if (iconColorBuilder != null) {
      return iconColorBuilder!.call(snacky);
    }
    switch (snacky.type) {
      case SnackyType.success:
        return Colors.green;
      case SnackyType.error:
        return Colors.red;
      case SnackyType.warning:
        return Colors.orange;
      case SnackyType.info:
        return Colors.blue;
      case SnackyType.branded:
        return const Color(0xFF7D64F2);
    }
  }

  TextStyle _getTextStyle(Snacky snacky, SimpleSnackyTextType textType) {
    if (textStyleBuilder != null) {
      return textStyleBuilder!.call(snacky, textType);
    }
    switch (textType) {
      case SimpleSnackyTextType.title:
        return const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
      case SimpleSnackyTextType.subtitle:
        return const TextStyle(color: Colors.black, fontSize: 12);
    }
  }

  IconData? _getIcon(Snacky snacky) {
    if (iconBuilder != null) {
      return iconBuilder!.call(snacky);
    }
    switch (snacky.type) {
      case SnackyType.success:
        return Icons.check_circle_outline;
      case SnackyType.error:
        return Icons.error_outline;
      case SnackyType.warning:
        return Icons.warning_amber_outlined;
      case SnackyType.info:
        return Icons.info_outline;
      case SnackyType.branded:
        return Icons.info_outline;
    }
  }

  Widget? _getLeaderWidget(Snacky snacky) {
    final icon = _getIcon(snacky);
    if (icon == null) return null;
    return Icon(
      icon,
      color: _getSnackyTypeColor(snacky),
      size: 24,
    );
  }
}
