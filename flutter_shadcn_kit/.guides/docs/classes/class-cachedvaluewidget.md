---
title: "Class: CachedValueWidget"
description: "A widget that caches a computed value."
---

```dart
/// A widget that caches a computed value.
class CachedValueWidget<T> extends StatefulWidget {
  /// The value to cache and pass to builder.
  final T value;
  /// Builder function that creates the widget from the value.
  final Widget Function(BuildContext context, T value) builder;
  /// Creates a [CachedValueWidget].
  const CachedValueWidget({super.key, required this.value, required this.builder});
  State<StatefulWidget> createState();
}
```
