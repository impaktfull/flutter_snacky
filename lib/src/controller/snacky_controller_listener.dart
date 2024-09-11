import 'package:flutter/widgets.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';

abstract class SnackyListener {
  void notifyListeners();

  OverlayState? getOverlayState();

  Widget buildSnacky(BuildContext context, CancelableSnacky activeSnacky);
}
