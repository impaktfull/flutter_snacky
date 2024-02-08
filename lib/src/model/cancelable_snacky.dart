import 'package:flutter/widgets.dart';
import 'package:snacky/src/model/snacky.dart';

class CancelableSnacky {
  final Snacky snacky;
  final VoidCallback onRemove;

  var _isCancelled = false;
  CancelableSnackyListener? _listener;

  bool get isCancelled => _isCancelled;

  bool get isNotCancelled => !isCancelled;

  CancelableSnacky({
    required this.snacky,
    required this.onRemove,
  });

  void cancel() {
    _isCancelled = true;
    _listener?.onSnackyCanceled();
  }

  void removed() => onRemove();

  void attach(CancelableSnackyListener listener) {
    _listener = listener;
  }

  void detach(CancelableSnackyListener listener) {
    _listener = null;
  }
}

mixin CancelableSnackyListener {
  void onSnackyCanceled() {}
}
