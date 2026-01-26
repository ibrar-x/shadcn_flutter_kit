# Sortable

Drag-and-drop sorting primitives with drop zones, ghost items, and scroll support.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/sortable/sortable.dart';

SortableLayer(
  child: Sortable<String>(
    data: const SortableData('Item'),
    onAcceptTop: (data) {},
    child: const Text('Draggable'),
  ),
);
```

## Notes

- Dependencies: `data_widget`.
