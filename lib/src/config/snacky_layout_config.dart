import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:snacky/src/config/snacky_layout_breakpoint_config.dart';
import 'package:snacky/src/model/snacky.dart';
import 'package:snacky/src/model/snacky_location.dart';

class SnackyLayoutConfig {
  final List<SnackyLayoutBreakpointConfig> breakpoints;

  const SnackyLayoutConfig({
    this.breakpoints = const [],
  });

  void validate() {
    if (breakpoints.isEmpty) return;
    for (final breakpoint in breakpoints) {
      if (breakpoint.minWidth > breakpoint.maxWidth) {
        throw Exception('minWidth must be less than maxWidth');
      }
      for (final otherBreakpoint in breakpoints) {
        if (breakpoint != otherBreakpoint) {
          if (breakpoint.minWidth < otherBreakpoint.maxWidth &&
              breakpoint.maxWidth > otherBreakpoint.minWidth) {
            throw Exception('breakpoints overlap');
          }
        }
      }
    }
  }

  double getSnackyWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final breakpoint = _getBreakpoint(width);
    if (breakpoint == null) return double.infinity;
    final maxWidth = breakpoint.snackyMaxWidth;
    if (breakpoint.snackyPercentage != null) {
      final widthByPercentage = width * breakpoint.snackyPercentage!;
      return min(widthByPercentage, maxWidth);
    }
    return maxWidth;
  }

  SnackyLocation getSnackyLocation(BuildContext context, Snacky snacky) {
    if (snacky.location != null) return snacky.location!;
    final width = MediaQuery.of(context).size.width;
    final breakpoint = _getBreakpoint(width);
    return breakpoint?.snackyLocation ?? SnackyLocation.top;
  }

  SnackyLayoutBreakpointConfig? _getBreakpoint(double width) {
    for (final breakpoint in breakpoints) {
      if (width >= breakpoint.minWidth && width <= breakpoint.maxWidth) {
        return breakpoint;
      }
    }
    return null;
  }
}
