---
title: "Class: DrawerEntryWidgetState"
description: "Reference for DrawerEntryWidgetState"
---

```dart
class DrawerEntryWidgetState<T> extends State<DrawerEntryWidget<T>> with SingleTickerProviderStateMixin {
  /// Notifier for additional offset applied during drag gestures.
  ValueNotifier<double> additionalOffset;
  void initState();
  void dispose();
  void didUpdateWidget(covariant DrawerEntryWidget<T> oldWidget);
  /// Closes the drawer with an optional result value.
  ///
  /// Animates the drawer out using an ease-out cubic curve, then completes
  /// the completer with the provided result.
  ///
  /// Parameters:
  /// - [result] (T?): Optional result to return when drawer closes
  ///
  /// Returns a [Future] that completes when the close animation finishes.
  Future<void> close([T? result]);
  Widget build(BuildContext context);
}
```
