---
title: "Class: SortableData"
description: "Reference for SortableData"
---

```dart
class SortableData<T> {
  /// The actual data being wrapped for sorting operations.
  ///
  /// Type: `T`. This is the data that will be passed to drop handlers and
  /// validation predicates. Can be any type that represents the sortable item.
  final T data;
  /// Creates a [SortableData] wrapper for the given data.
  ///
  /// Wraps the provided data in an immutable container that can be used with
  /// sortable widgets for drag-and-drop operations.
  ///
  /// Parameters:
  /// - [data] (T, required): The data to wrap for sorting operations
  ///
  /// Example:
  /// ```dart
  /// // Wrapping different data types
  /// SortableData('text_item')
  /// SortableData(42)
  /// SortableData(MyCustomObject(id: 1))
  /// ```
  const SortableData(this.data);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
