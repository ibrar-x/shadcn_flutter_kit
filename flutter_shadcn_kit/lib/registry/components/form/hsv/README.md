# HSV Color Slider (`hsv`)

Gradient slider for HSV color component control (hue, saturation, value, alpha).

---

## When to use

- Use this when:
  - you need a standalone HSV slider.
- Avoid when:
  - you need full color picker UI (use `color_picker`).

---

## Install

```bash
flutter_shadcn add hsv
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/hsv/hsv_color_slider.dart';
```

---

## Minimal example

```dart
HSVColorSlider(
  value: HSVColor.fromColor(Colors.blue),
  sliderType: HSVColorSliderType.hue,
  onChanged: (color) {},
)
```

---

## API

### Constructor

- `HSVColorSlider`
  - `value` (`HSVColor`, required)
  - `sliderType` (`HSVColorSliderType`, required)
  - `onChanging`, `onChanged`
  - `reverse`, `radius`, `padding`

---

## Theming

- Uses shared theme for sizing and alpha pattern.

---

## Accessibility

- Provide labels for sliders when used in forms.

---

## Do / Don’t

**Do**
- ✅ Use `sliderType` to target a single channel.

**Don’t**
- ❌ Combine HSV and HSL sliders without clear labeling.

---

## Related components

- `hsl`
- `color_picker`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
