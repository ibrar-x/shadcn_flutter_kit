# Chip

Compact tag/tag-like components backed by buttons.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/chip/chip.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        Chip(child: const Text('Label')),
        Chip(
          leading: const Icon(Icons.tag),
          child: const Text('Styled'),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close, size: 14),
          ),
        ),
      ],
    );
  }
}
```

## Theming

Use `ComponentTheme<ChipTheme>` to override `padding` or base `style`. Chips
reuse the shared `Button` system so customizing `ButtonVariance` or
`ButtonTheme` affects them as well.
