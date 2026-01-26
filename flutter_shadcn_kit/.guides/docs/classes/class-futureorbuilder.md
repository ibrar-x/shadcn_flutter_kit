---
title: "Class: FutureOrBuilder"
description: "A widget that renders based on a [FutureOr] value."
---

```dart
/// A widget that renders based on a [FutureOr] value.
///
/// If the provided value is already available, the builder runs immediately.
/// Otherwise it falls back to [FutureBuilder] until the future completes.
class FutureOrBuilder<T> extends StatelessWidget {
  /// Creates a [FutureOrBuilder].
  const FutureOrBuilder({super.key, required this.future, required this.builder, this.initialValue});
  /// The synchronous or asynchronous value to track.
  final FutureOr<T> future;
  /// Called with the current snapshot when the value changes.
  final FutureOrWidgetBuilder<T> builder;
  /// Optional initial data used before the future completes.
  final T? initialValue;
  Widget build(BuildContext context);
}
```
