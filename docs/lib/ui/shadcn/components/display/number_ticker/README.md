# Number Ticker

Animated numeric value display with text formatting or custom builders.

```dart
NumberTicker(
  number: _score,
  formatter: (value) => NumberFormat.compact().format(value),
  duration: Duration(milliseconds: 600),
);

NumberTicker.builder(
  number: _score,
  builder: (context, value, child) => Row(
    children: [
      child ?? const SizedBox.shrink(),
      Text(value.toStringAsFixed(1)),
    ],
  ),
);
```

Wrap with `ComponentTheme<NumberTickerTheme>` to override durations, curves, or text styles.
