# HSL Color Slider

Gradient slider for adjusting HSL tones, saturation, lightness, and alpha with optional direction control.

```dart
import 'ui/shadcn/components/hsl/hsl_color_slider.dart';

HSLColorSlider(
  color: HSLColor.fromColor(Colors.blue),
  sliderType: HSLColorSliderType.hue,
  onChanged: (color) => print(color.toColor()),
);
```

Use the shared theme (`ComponentTheme<HSLColorSliderTheme>`) to override radius, padding, and behavior per the registry’s theme helpers.
