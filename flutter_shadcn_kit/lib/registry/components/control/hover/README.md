# Hover

Utilities for smoothing hover interactions and tracking pointer state.

## Widgets

- `HoverTheme`: configure wait/min/show durations plus hit-test behavior via `ComponentTheme<HoverTheme>`.
- `HoverActivity`: lightweight mouse-region tracker that fires enter/exit/hover callbacks with optional debouncing.
- `Hover`: advanced hover controller that respects wait/min/show timing and triggers hover state callbacks across both mouse and long-press touch interactions.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/hover/hover.dart';

Hover(
  onHover: (hovered) => print('hovered: $hovered'),
  child: const Text('Hover me'),
);
```

Wrap a subtree with `ComponentTheme<HoverTheme>` when you want to adjust the timing defaults globally.
