import 'package:flutter/material.dart';
import 'package:snacky/src/config/snacky_layout_config.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';

abstract class SnackyBuilder {
  const SnackyBuilder();

  Widget build(
    BuildContext context,
    SnackyLayoutConfig layoutConfig,
    CancelableSnacky cancelableSnacky,
    SnackyController snackyController,
  );
}
