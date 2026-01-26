---
title: "Class: DrawerOverlay"
description: "Reference for DrawerOverlay"
---

```dart
class DrawerOverlay extends StatefulWidget {
  static DrawerLayerData? get currentLayer;
  /// Child widget displayed under the overlay layer.
  final Widget child;
  /// Creates a drawer overlay.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content widget
  const DrawerOverlay({super.key, required this.child});
  State<DrawerOverlay> createState();
  /// Finds the drawer layer data from the widget tree.
  ///
  /// Searches up the widget tree for the nearest [DrawerLayerData].
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFind(BuildContext context, [bool root = false]);
  /// Finds the drawer layer data using messenger lookup.
  ///
  /// Similar to [maybeFind] but uses the messenger mechanism for lookup.
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFindMessenger(BuildContext context, [bool root = false]);
}
```
