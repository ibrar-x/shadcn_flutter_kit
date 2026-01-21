part of '../drawer.dart';

Future<void> closeDrawer<T>(BuildContext context, [T? result]) {
  final data = Data.maybeOf<_MountedOverlayEntryData>(context);
  assert(data != null, 'No DrawerEntryWidget found in the widget tree');
  return data!.state.close(result);
}

/// Data class representing a drawer overlay layer in the hierarchy.
///
/// Tracks the drawer overlay state and its parent layer, enabling nested
/// drawer management and size computation across the layer stack.
