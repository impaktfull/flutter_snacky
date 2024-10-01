import 'package:flutter/material.dart';
import 'package:snacky/src/builder/snacky_builder.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky.dart';
import 'package:snacky/src/widget/base_snacky_widget.dart';

enum ToastSnackyTextType {
  title,
  subtitle,
}

class ToastSnackyBuilder extends SnackyBuilder {
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color Function(Snacky)? colorBuilder;
  final BoxBorder Function(Snacky)? borderBuilder;
  final TextStyle Function(Snacky, ToastSnackyTextType)? textStyleBuilder;

  const ToastSnackyBuilder({
    this.colorBuilder,
    this.borderBuilder,
    this.textStyleBuilder,
    this.margin = const EdgeInsets.all(16),
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 32,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
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
      disableInkWell: true,
      borderRadius: borderRadius,
      child: Builder(
        builder: (context) {
          if (customBuilder != null) {
            return customBuilder(context, cancelableSnacky);
          }

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF404040),
              borderRadius: borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    snacky.title,
                    style: _getTextStyle(snacky, ToastSnackyTextType.title),
                    textAlign: TextAlign.center,
                  ),
                  if (snacky.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      snacky.subtitle!,
                      style:
                          _getTextStyle(snacky, ToastSnackyTextType.subtitle),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle _getTextStyle(Snacky snacky, ToastSnackyTextType textType) {
    if (textStyleBuilder != null) {
      return textStyleBuilder!.call(snacky, textType);
    }
    switch (textType) {
      case ToastSnackyTextType.title:
        return const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
      case ToastSnackyTextType.subtitle:
        return const TextStyle(color: Colors.white, fontSize: 12);
    }
  }
}
