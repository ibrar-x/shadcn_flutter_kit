# Circular Progress Indicator

Determinate or indeterminate circular indicator with consistent theming.

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/circular_progress_indicator/circular_progress_indicator.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 18),
        CircularProgressIndicator(value: 0.6, duration: Duration(milliseconds: 250)),
      ],
    );
  }
}
```

Wrap a subtree with `ComponentTheme<CircularProgressIndicatorTheme>` to override
color, size, stroke width, or background track defaults.
