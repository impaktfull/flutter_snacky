import 'package:flutter/material.dart';
import 'package:snacky/src/controller/snacky_controller_listener.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';
import 'package:snacky/src/model/snacky.dart';

class SnackyController {
  static final instance = SnackyController();

  final _snackies = <CancelableSnacky>[];
  final ValueNotifier<CancelableSnacky?> _activeSnacky = ValueNotifier(null);
  OverlayEntry? _entry;

  /// The listener whose overlay holds [_entry].
  SnackyListener? _entryListener;

  SnackyListener? _listener;

  OverlayState? get _overlayState => _listener?.getOverlayState();

  ValueNotifier<CancelableSnacky?> get activeSnacky => _activeSnacky;

  void showMessage(Snacky Function(BuildContext) builder) {
    final overlayState = _overlayState;
    if (overlayState == null) {
      debugPrint(
          'SnackyController.showMessage: overlayState is null.\n\nDid you dispose your `SnackyConfiguratorWidget`? Make sure the `SnackyConfiguratorWidget` is configured at the top of your tree and is not removed when using the app.');
      return;
    }
    late final CancelableSnacky cancelableSnacky;
    cancelableSnacky = CancelableSnacky(
      snacky: builder(overlayState.context),
      onRemove: () => _onSnackyRemoved(cancelableSnacky),
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
    final listener = _listener;
    final overlayState = _overlayState;
    if (listener == null || overlayState == null) return;
    final nextSnacky = _snackies.removeAt(0);
    _activeSnacky.value = nextSnacky;
    notifyListeners();
    final entry = OverlayEntry(
      builder: (context) =>
          _listener?.buildSnacky(context, nextSnacky) ?? const SizedBox(),
    );
    overlayState.insert(entry);
    _entry = entry;
    _entryListener = listener;
  }

  void attach(SnackyListener listener) {
    _listener = listener;
  }

  void detach(SnackyListener listener) {
    // A new configurator can attach before the old one is disposed.
    if (_listener == listener) _listener = null;
    if (_entryListener != listener) return;
    // The active snacky was shown in the overlay of this configurator, which
    // is going away together with the entry. Forget it, so the controller can
    // show snackies again.
    final orphan = _activeSnacky.value;
    _entry = null;
    _entryListener = null;
    if (_listener == null) {
      // Without a configurator there is no overlay: drop the queue, like
      // `showMessage` drops a snacky when there is no overlay.
      _snackies.clear();
    }
    // The widget tree is locked while a configurator is disposed, so
    // listeners of `activeSnacky` and the configurator are notified, and the
    // queue continues, after this frame.
    WidgetsBinding.instance
      ..addPostFrameCallback((_) {
        if (_activeSnacky.value != orphan || _entry != null) return;
        _activeSnacky.value = null;
        notifyListeners();
        _scheduleNextMessage();
      })
      ..scheduleFrame();
  }

  void notifyListeners() => _listener?.notifyListeners();

  void _onSnackyRemoved(CancelableSnacky cancelableSnacky) {
    // Only the active snacky owns the overlay entry.
    if (_activeSnacky.value != cancelableSnacky) return;
    _entry?.remove();
    _entry = null;
    _entryListener = null;
    _activeSnacky.value = null;
    notifyListeners();
    _scheduleNextMessage();
  }

  void cancelActiveSnacky() {
    _activeSnacky.value?.cancel();
  }
}
