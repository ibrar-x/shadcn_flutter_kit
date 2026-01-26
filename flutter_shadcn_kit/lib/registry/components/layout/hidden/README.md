# Hidden

Animate a child’s visibility without rebuilding layout. Uses `AnimatedOpacity` plus a dedicated render object so the child can shrink along one axis or preserve its size.

```dart
import 'ui/shadcn/components/hidden/hidden.dart';

Hidden(
  hidden: !isVisible,
  direction: Axis.vertical,
  child: const Text('Toggle me'),
);
```

Provide `ComponentTheme<HiddenTheme>` from `shared/theme/theme.dart` to adjust animation curves, duration, or size-preservation flags.
