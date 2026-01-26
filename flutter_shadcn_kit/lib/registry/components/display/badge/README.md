# Badge

Compact label/status components built on top of `Button` styles.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/badge/badge.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        PrimaryBadge(child: Text('New')),
        SizedBox(width: 8),
        SecondaryBadge(child: Text('Beta')),
        SizedBox(width: 8),
        OutlineBadge(child: Text('Outline')),
        SizedBox(width: 8),
        DestructiveBadge(child: Text('Danger')),
      ],
    );
  }
}
```

## Theming

Override styles via `BadgeTheme` and `ComponentTheme` if needed. Badges reuse
`ButtonStyle` variants under the hood.
