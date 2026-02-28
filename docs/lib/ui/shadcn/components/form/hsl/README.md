# HSL Color Slider (`hsl`)

Gradient slider that controls hue, saturation, lightness, or alpha for HSL colors.

---

## When to use

- Use this when:
  - you need a standalone HSL slider.
- Avoid when:
  - you need full color picker UI (use `color_picker`).

---

## Install

```bash
flutter_shadcn add hsl
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/hsl/hsl_color_slider.dart';
```

---

## Minimal example

```dart
HSLColorSlider(
  color: HSLColor.fromColor(Colors.blue),
  sliderType: HSLColorSliderType.hue,
  onChanged: (color) {},
)
```

---

## API

### Constructor

- `HSLColorSlider`
  - `color` (`HSLColor`, required)
  - `sliderType` (`HSLColorSliderType`, required)
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
- ❌ Stack multiple sliders without grouping labels.

---

## Related components

- `hsv`
- `color_picker`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
