part of '../../menu.dart';

/// NextMenuFocusIntent defines a reusable type for this registry module.
class NextMenuFocusIntent extends Intent {
  /// Whether to move focus forward (true) or backward (false).
  final bool forward;

  /// Creates a next menu focus intent.
  ///
  /// Parameters:
  /// - [forward] (bool, required): Direction of focus movement
  const NextMenuFocusIntent(this.forward);
}

/// Overlay handler specialized for menu popover display.
///
/// Delegates to an [OverlayManager] to show menu popovers with
/// appropriate positioning, transitions, and dismissal behavior.
