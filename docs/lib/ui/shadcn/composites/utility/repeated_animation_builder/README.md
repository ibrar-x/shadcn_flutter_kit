# Repeated Animation Builder

Composite export for RepeatedAnimationBuilder from shared utilities.

## Usage

```dart
import 'ui/shadcn/composites/repeated_animation_builder/repeated_animation_builder.dart';

RepeatedAnimationBuilder(
  start: 0,
  end: 1,
  duration: const Duration(seconds: 1),
  builder: (context, value, child) {
    return Opacity(opacity: value, child: child);
  },
  child: const Text('Pulse'),
);
```
