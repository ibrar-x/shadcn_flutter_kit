# HSV Color Slider

Gradient slider for configuring hue, saturation, value, and alpha channels of HSV colors.

```dart
import 'ui/shadcn/components/hsv/hsv_color_slider.dart';

HSVColorSlider(
  color: ColorDerivative.fromColor(Colors.deepPurple).toHsv(),
  sliderType: HSVColorSliderType.value,
  onChanged: (hsv) => print(hsv.value),
);
```

Use the shared theme (`ComponentTheme<HSVColorSliderTheme>`) to customize radius, padding, and orientation before installing the slider.
