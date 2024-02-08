import 'package:flutter/rendering.dart';

enum SnackyLocation {
  top(alignment: Alignment.topCenter),
  bottom(alignment: Alignment.bottomCenter);

  final Alignment alignment;
  const SnackyLocation({
    required this.alignment,
  });
}
