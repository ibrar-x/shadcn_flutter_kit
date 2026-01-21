part of '../drawer.dart';

class _MountedOverlayEntryData {
  final DrawerEntryWidgetState state;

  _MountedOverlayEntryData(this.state);
}

/// Closes the currently open drawer overlay.
///
/// Dismisses the active drawer from the overlay stack. Optionally returns
/// a result value to the code that opened the drawer.
///
/// Parameters:
/// - [context] (`BuildContext`, required): Build context from within the drawer.
/// - [result] (`T?`, optional): Optional result to return.
///
/// Returns: `Future<void>` that completes when drawer is closed.
