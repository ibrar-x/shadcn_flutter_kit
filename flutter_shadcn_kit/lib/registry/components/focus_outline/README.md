# FocusOutline

Adds a focus ring around a child widget without taking input events.

```dart
import 'ui/shadcn/components/focus_outline/focus_outline.dart';

FocusOutline(
  focused: hasFocus,
  child: TextButton(onPressed: () {}, child: const Text('Button')),
);
```

Use `ComponentTheme<FocusOutlineTheme>` from `shared/theme/theme.dart` to override the default border, alignment offset, or corner rounding.
