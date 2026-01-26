part of '../menu.dart';

class CloseMenuIntent extends Intent {
  /// Creates a close menu intent.
  const CloseMenuIntent();
}

/// Intent for opening a submenu via keyboard action.
///
/// Triggers submenu expansion when navigating with keyboard.
class OpenSubMenuIntent extends Intent {
  /// Creates an open submenu intent.
  const OpenSubMenuIntent();
}

/// Intent for moving focus to next/previous menu item.
///
/// Used for keyboard navigation within menus (Tab/Shift+Tab).
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
