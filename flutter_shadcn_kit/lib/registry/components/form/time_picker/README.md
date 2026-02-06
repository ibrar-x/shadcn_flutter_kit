# Time Picker (`time_picker`)

Popover/dialog picker for time and duration values.

---

## When to use

- Use this when:
  - you need time or duration selection with a picker.
- Avoid when:
  - a plain text field is sufficient.

---

## Install

```bash
flutter_shadcn add time_picker
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/time_picker/time_picker.dart';
```

---

## Minimal example

```dart
TimePicker(
  value: TimeOfDay.now(),
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `TimePicker`
  - `value` (`TimeOfDay?`, required)
  - `onChanged` (`ValueChanged<TimeOfDay?>?`)
  - `mode` (`PromptMode`)
  - `use24HourFormat`, `showSeconds`
  - `popoverAlignment`, `popoverAnchorAlignment`, `popoverPadding`
  - `dialogTitle`, `placeholder`, `enabled`
- `DurationPicker` — duration selector.
- `ControlledTimePicker` — controller-backed picker.
- `TimePickerController` / `DurationPickerController` — controllers.
- `TimeRange` — time range value type.

### Callbacks

- `onChanged`

---

## Theming

- `TimePickerTheme` controls prompt mode, alignment, and defaults.

---

## Accessibility

- Provide clear labels for time formats.

---

## Do / Don’t

**Do**
- ✅ Respect locale settings with `use24HourFormat`.

**Don’t**
- ❌ Hide seconds if your data model requires them.

---

## Related components

- `form_field`
- `object_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
