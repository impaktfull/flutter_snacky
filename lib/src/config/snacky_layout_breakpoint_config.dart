import 'package:snacky/src/model/snacky_location.dart';

class SnackyLayoutBreakpointConfig {
  final double minWidth;
  final double maxWidth;
  final double snackyMaxWidth;
  final double? snackyPercentage;
  final SnackyLocation? snackyLocation;

  const SnackyLayoutBreakpointConfig({
    this.minWidth = 0,
    this.maxWidth = double.infinity,
    this.snackyMaxWidth = double.infinity,
    this.snackyPercentage,
    this.snackyLocation,
  });
}
