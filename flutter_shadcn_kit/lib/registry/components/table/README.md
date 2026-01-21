# Table

Resizable table layout with headers, footers, and frozen rows/columns.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/table/table.dart';

Table(
  rows: [
    TableHeader(cells: [TableCell(child: Text('Name'))]),
    TableRow(cells: [TableCell(child: Text('Row 1'))]),
  ],
);
```

## Notes

- Dependencies: `data_widget`.
- Uses shared resizer utilities for column/row resizing.
