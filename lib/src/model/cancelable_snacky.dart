import 'package:flutter/widgets.dart';
import 'package:snacky/src/model/snacky.dart';

class CancelableSnacky {
  final Snacky snacky;
  final VoidCallback onRemove;

  var _isCancelled = false;
  var _isRemoved = false;
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

  /// Notifies [onRemove] that this snacky is gone. Only the first call has
  /// effect, so a snacky can never remove the snacky shown after it.
  void removed() {
    if (_isRemoved) return;
    _isRemoved = true;
    onRemove();
  }

  void attach(CancelableSnackyListener listener) {
    _listener = listener;
  }

  void detach(CancelableSnackyListener listener) {
    if (_listener != listener) return;
    _listener = null;
  }
}

mixin CancelableSnackyListener {
  void onSnackyCanceled() {}
}
