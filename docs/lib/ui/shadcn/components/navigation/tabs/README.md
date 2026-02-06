# Tabs

Tabbed navigation primitives with list, container, and pane widgets.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/tabs/tabs.dart';

Tabs(
  index: 0,
  children: const [
    TabItem(value: 'one', child: Text('One')),
    TabItem(value: 'two', child: Text('Two')),
  ],
  onChanged: (index) {},
);
```

## Notes

- Dependencies: `data_widget`.
- Requires `sortable` for draggable tab panes.
