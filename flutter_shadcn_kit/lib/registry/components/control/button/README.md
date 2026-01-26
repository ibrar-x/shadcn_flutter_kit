# Button

A flexible button system with variants, sizing, toggle behavior, and grouping.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/button/button.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button.primary(
          onPressed: () {},
          child: const Text('Primary'),
        ),
        Button.outline(
          onPressed: () {},
          leading: const Icon(Icons.add),
          child: const Text('Outline'),
        ),
      ],
    );
  }
}
```

## Variants

- `Button.primary`, `Button.secondary`, `Button.outline`, `Button.ghost`
- `Button.link`, `Button.text`, `Button.destructive`, `Button.card`
- `IconButton.primary/secondary/outline/ghost/link/text/destructive`

## Toggle & Selection

```dart
Toggle(
  value: isEnabled,
  onChanged: (next) => setState(() => isEnabled = next),
  child: const Text('Toggle me'),
);

SelectedButton(
  value: isSelected,
  onChanged: (next) => setState(() => isSelected = next),
  child: const Text('Selected'),
);
```

## Theming

These buttons read from the local `Theme` in `shared/theme/theme.dart`. If you do
not provide one, a default theme is used automatically.

```dart
Theme(
  data: const ThemeData(),
  child: Button.primary(onPressed: () {}, child: const Text('Themed')),
);
```

## Notes

- Dependencies: `data_widget`, `gap`.
- Menu padding adapts when a `MenuGroupData` ancestor is present.
