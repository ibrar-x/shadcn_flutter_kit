---
title: "Class: PreviewVariant"
description: "Metadata for a single preview variant demonstration"
---

```dart
/// Metadata for a single preview variant demonstration
class PreviewVariant {
  /// Unique identifier for this variant
  final String id;
  /// Human-readable title for this variant
  final String title;
  /// Builder function that creates the widget preview for this variant
  final Widget Function(BuildContext context) builder;
  const PreviewVariant({required this.id, required this.title, required this.builder});
}
```
