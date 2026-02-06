# History

Provides a reusable color history grid plus a storage scope for painting recent
colors in palettes, color pickers, or custom editors.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'ui/shadcn/components/history/history.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return RecentColorsScope(
      initialRecentColors: [const Color(0xFF2196F3)],
      child: Column(
        children: [
          ColorHistoryGrid(
            storage: ColorHistoryStorage.of(context),
            onColorPicked: (color) {
              print('Picked $color');
            },
          ),
        ],
      ),
    );
  }
}
```

## Notes

- Wrap interactive color pickers with `RecentColorsScope` so the grid and pickers mine
  the same history.
- The grid renders transparent tiles using `AlphaPainter` and the `button`
  component.
