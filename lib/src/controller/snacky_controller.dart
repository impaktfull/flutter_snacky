import 'package:flutter/material.dart';
import 'package:snacky/src/controller/snacky_controller_listener.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky.dart';

class SnackyController {
  // static const _showDuration = Duration(milliseconds: 250);
  // static const _hideDuration = Duration(milliseconds: 250);
  static final instance = SnackyController();

  final _snackies = <CancelableSnacky>[];
  final ValueNotifier<CancelableSnacky?> _activeSnacky = ValueNotifier(null);

  SnackyListener? _listener;

  OverlayState? get _overlayState => _listener?.getOverlayState();

  ValueNotifier<CancelableSnacky?> get activeSnacky => _activeSnacky;

  void showMessage(Snacky Function(BuildContext) builder) {
    final cancelableSnacky = CancelableSnacky(
      snacky: builder(_overlayState!.context),
      onRemove: _onSnackyRemoved,
    );
    _snackies.add(cancelableSnacky);
    _scheduleNextMessage();
  }

  void cancelAll() {
    _snackies.clear();
    cancelActiveSnacky();
  }

  void _scheduleNextMessage() {
    if (_activeSnacky.value != null) return;
    if (_snackies.isEmpty) return;
    final nextSnacky = _snackies.removeAt(0);
    _activeSnacky.value = nextSnacky;
    notifyListeners();
    final entry = OverlayEntry(
      builder: (context) =>
          _listener?.buildSnacky(context, nextSnacky) ?? const SizedBox(),
    );
    _overlayState?.insert(entry);
  }

  void attach(SnackyListener listener) {
    _listener = listener;
  }

  void detach(SnackyListener listener) {
    _listener = null;
  }

  void notifyListeners() => _listener?.notifyListeners();

  void _onSnackyRemoved() {
    _activeSnacky.value = null;
    notifyListeners();
    _scheduleNextMessage();
  }

  void cancelActiveSnacky() => _activeSnacky.value?.cancel();
}
