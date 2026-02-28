# Color Picker (`color_picker`)

HSV/HSL/HEX color picker with popovers, eye dropper, and history controls.

---

## When to use

- Use this when:
  - you need a full color picker UI.
  - you want multiple color modes and alpha control.
- Avoid when:
  - you only need a compact field (use `color_input`).

---

## Install

```bash
flutter_shadcn add color_picker
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/color_picker/color_picker.dart';
```

---

## Minimal example

```dart
ColorPicker(
  value: ColorDerivative.fromColor(Colors.blue),
  onChanged: (color) {},
)
```

---

## Common patterns

### Pattern: HSV mode with alpha

```dart
ColorPicker(
  value: ColorDerivative.fromColor(Colors.teal),
  initialMode: ColorPickerMode.hsv,
  showAlpha: true,
)
```

---

## API

### Constructor

- `ColorPicker`
  - `value` (`ColorDerivative`, required)
  - `onChanged`, `onChanging`
  - `showAlpha`, `showHistoryButton`, `initialShowHistory`
  - `initialMode` (`ColorPickerMode`)
  - `onModeChanged`
  - `enableEyeDropper`, `onEyeDropperRequested`
  - `orientation`, `spacing`, `controlSpacing`, `sliderSize`
- `ColorPickerMode` — `rgb`, `hsl`, `hsv`, `hex`.

### Callbacks

- `onChanged`, `onChanging`, `onModeChanged`, `onEyeDropperRequested`

---

## Theming

- `ColorPickerTheme` controls spacing, typography, and layout defaults.

---

## Accessibility

- Provide labels for sliders and inputs when used in forms.

---

## Do / Don’t

**Do**
- ✅ Use `onChanging` for live previews.

**Don’t**
- ❌ Hide alpha controls when transparency matters.

---

## Related components

- `color_input`
- `history`
- `hsl`
- `hsv`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
