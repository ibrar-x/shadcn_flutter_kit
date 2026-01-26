# Card

A flexible card container with optional surface blur for overlays.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/card/card.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      filled: true,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: const Text('Card content'),
      ),
    );
  }
}
```

## Surface Variant

```dart
SurfaceCard(
  surfaceBlur: 12,
  surfaceOpacity: 0.8,
  child: const Text('Overlay content'),
);
```

## Theming

Use `Theme` from `shared/theme/theme.dart` and optionally provide a `CardTheme`
with `ComponentTheme` for per-subtree overrides.
