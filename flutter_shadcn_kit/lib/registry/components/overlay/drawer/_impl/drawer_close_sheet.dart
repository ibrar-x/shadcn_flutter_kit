part of '../drawer.dart';

Future<void> closeSheet(BuildContext context) {
  // sheet is just a drawer with no backdrop transformation
  return closeDrawer(context);
}

/// Wrapper widget for sheet overlays.
///
/// Extends [DrawerWrapper] with sheet-specific defaults (no drag, no expansion).
/// Sheets are simplified drawers without backdrop transformation.
