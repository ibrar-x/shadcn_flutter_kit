---
title: "Class: NumberTicker"
description: "Smooth number animation component with text or custom builder variants."
---

```dart
/// Smooth number animation component with text or custom builder variants.
class NumberTicker extends StatelessWidget {
  const NumberTicker.builder({super.key, this.initialNumber, required this.number, required this.builder, this.child, this.duration, this.curve});
  const NumberTicker({super.key, this.initialNumber, required this.number, required this.formatter, this.duration, this.curve, this.style});
  final num? initialNumber;
  final num number;
  final NumberTickerBuilder? builder;
  final Widget? child;
  final NumberTickerFormatted? formatter;
  final Duration? duration;
  final Curve? curve;
  final TextStyle? style;
  Widget build(BuildContext context);
}
```
