# Color Input (`color_input`)

Popover/dialog color selector that integrates the picker, history, and eye-dropper tools.

---

## When to use

- Use this when:
  - you need a compact color input field with a picker.
  - you want optional history and eye dropper integration.
- Avoid when:
  - you need full-page color editing (use `color_picker`).

---

## Install

```bash
flutter_shadcn add color_input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/color_input/color_input.dart';
```

---

## Minimal example

```dart
ColorInput(
  value: ColorDerivative.fromColor(Colors.blue),
  onChanged: (color) {},
)
```

---

## Common patterns

### Pattern: Dialog mode with history

```dart
ColorInput(
  value: ColorDerivative.fromColor(Colors.red),
  promptMode: PromptMode.dialog,
  showHistory: true,
)
```

---

## API

### Constructor

- `ColorInput`
  - `value` (`ColorDerivative`, required)
  - `onChanging`, `onChanged`
  - `showAlpha`, `showLabel`
  - `initialMode` (`ColorPickerMode?`)
  - `enableEyeDropper` (`bool?`)
  - `promptMode` (`PromptMode?`)
  - `popoverAlignment`, `popoverAnchorAlignment`, `popoverPadding`
  - `dialogTitle`, `placeholder`, `orientation`, `enabled`, `showHistory`
- `ControlledColorInput` — controller-backed input.
- `ColorInputController` — `ValueNotifier<ColorDerivative>` controller.

### Callbacks

- `onChanging`, `onChanged`

---

## Theming

- `ColorInputTheme` controls layout, padding, and prompt styling.

---

## Accessibility

- Provide labels for the selected color value when used in forms.

---

## Do / Don’t

**Do**
- ✅ Enable `showHistory` for repeated color selection workflows.

**Don’t**
- ❌ Use without a visible label when the color choice is critical.

---

## Related components

- `color_picker`
- `history`
- `eye_dropper`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
