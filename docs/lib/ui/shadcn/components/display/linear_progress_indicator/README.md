# Linear Progress Indicator

Versatile determinate/indeterminate progress bar with optional spark effects.

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/linear_progress_indicator/linear_progress_indicator.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        LinearProgressIndicator(value: 0.35),
        SizedBox(height: 12),
        LinearProgressIndicator(showSparks: true, value: 0.9),
        SizedBox(height: 12),
        LinearProgressIndicator(),
      ],
    );
  }
}
```

Wrap a subtree with `ComponentTheme<LinearProgressIndicatorTheme>` to adjust
colors, minHeight, borderRadius, spark visibility, or animation defaults.
