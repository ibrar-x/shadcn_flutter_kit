# Color Utilities

Provides helpers for working with Flutter colors: `colorToHex` for converting `Color` objects to hex strings, and the `ColorDerivative` abstraction for transformations across RGB/HSV/HSL spaces while reusing a consistent internal representation. These utilities are used by color pickers and anywhere you need consistent color math.

```dart
final derivative = ColorDerivative.fromColor(Colors.blue);
final adjusted = derivative.changeToHSV(HSVColor.fromAHSV(1, 180, 0.5, 0.5));
print(colorToHex(adjusted.toColor(), true)); // prints the ARGB hex value
```
