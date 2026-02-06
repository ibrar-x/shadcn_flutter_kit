# Slider (`slider`)

Single-value and range sliders with keyboard navigation.

---

## When to use

- Use this when:
  - you need continuous or discrete slider input.
  - you need range selection with `SliderValue`.
- Avoid when:
  - a text input is more precise.

---

## Install

```bash
flutter_shadcn add slider
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/slider/slider.dart';
```

---

## Minimal example

```dart
Slider(
  value: SliderValue.single(0.5),
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `Slider`
  - `value` (`SliderValue`, required)
  - `onChanged`, `onChangeStart`, `onChangeEnd`
  - `min`, `max`, `divisions`, `hintValue`
  - `increaseStep`, `decreaseStep`, `enabled`
- `ControlledSlider` — controller-backed slider.
- `SliderController` — controller for `SliderValue`.

### Callbacks

- `onChanged`, `onChangeStart`, `onChangeEnd`

---

## Theming

- `SliderTheme` controls track/handle size and colors.

---

## Accessibility

- Provide labels or values adjacent to the slider.

---

## Do / Don’t

**Do**
- ✅ Use `divisions` for discrete steps.

**Don’t**
- ❌ Hide current value when precision matters.

---

## Related components

- `progress`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
