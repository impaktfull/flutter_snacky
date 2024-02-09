import 'package:flutter/material.dart';
import 'package:snacky/src/builder/snacky_builder.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky.dart';
import 'package:snacky/src/model/snacky_type.dart';
import 'package:snacky/src/widget/base_snacky_widget.dart';

class SimpleSnackyBuilder extends SnackyBuilder {
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color Function(Snacky)? colorBuilder;
  final BoxBorder Function(Snacky)? borderBuilder;
  final TextStyle Function(Snacky)? textStyleBuilder;

  const SimpleSnackyBuilder({
    this.colorBuilder,
    this.borderBuilder,
    this.textStyleBuilder,
    this.margin = const EdgeInsets.all(16),
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  @override
  Widget build(BuildContext context, CancelableSnacky cancelableSnacky,
      SnackyController snackyController) {
    final snacky = cancelableSnacky.snacky;
    return BaseSnackyWidget(
      cancelableSnacky: cancelableSnacky,
      snackyController: snackyController,
      margin: margin,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: _getColor(snacky),
          border: _getBorder(snacky),
          borderRadius: borderRadius,
        ),
        padding: padding,
        child: Row(
          children: [
            if (snacky.leadingWidgetBuilder != null) ...[
              snacky.leadingWidgetBuilder!.call(context, cancelableSnacky),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    snacky.title,
                    style: _getTextStyle(snacky),
                  ),
                  if (snacky.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      snacky.subtitle!,
                    ),
                  ]
                ],
              ),
            ),
            if (snacky.trailingWidgetBuilder != null) ...[
              const SizedBox(width: 8),
              snacky.trailingWidgetBuilder!.call(context, cancelableSnacky),
            ],
            if (snacky.canBeClosed) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => cancelableSnacky.cancel(),
                child: Icon(
                  Icons.close,
                  color: _getTextStyle(snacky).color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getColor(Snacky snacky) {
    if (colorBuilder != null) {
      return colorBuilder!.call(snacky);
    }
    final borderColor = _getBorderColor(snacky);
    return Color.lerp(borderColor, Colors.white, 0.8) ?? borderColor;
  }

  BoxBorder _getBorder(Snacky snacky) {
    if (borderBuilder != null) {
      return borderBuilder!.call(snacky);
    }
    return Border.all(
      color: _getBorderColor(snacky),
      width: 1,
    );
  }

  Color _getBorderColor(Snacky snacky) {
    switch (snacky.type) {
      case SnackyType.success:
        return Colors.green;
      case SnackyType.error:
        return Colors.red;
      case SnackyType.warning:
        return Colors.orange;
      case SnackyType.info:
        return Colors.blue;
    }
  }

  TextStyle _getTextStyle(Snacky snacky) {
    if (textStyleBuilder != null) {
      return textStyleBuilder!.call(snacky);
    }
    return const TextStyle(color: Colors.black);
  }
}
