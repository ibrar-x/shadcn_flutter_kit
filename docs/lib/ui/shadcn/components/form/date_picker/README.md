# Date Picker (`date_picker`)

Popover/dialog calendar for single-date and range selection.

---

## When to use

- Use this when:
  - you need a date field that opens a calendar.
  - you want single or range selection.
- Avoid when:
  - you only need a plain text date input (use `object_input`).

---

## Install

```bash
flutter_shadcn add date_picker
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/date_picker/date_picker.dart';
```

---

## Minimal example

```dart
DatePicker(
  value: DateTime.now(),
  onChanged: (value) {},
)
```

---

## Common patterns

### Pattern: Date range

```dart
DateRangePicker(
  value: DateTimeRange(DateTime.now(), DateTime.now().add(Duration(days: 3))),
  onChanged: (range) {},
)
```

---

## API

### Constructor

- `DatePicker`
  - `value` (`DateTime?`, required)
  - `onChanged` (`ValueChanged<DateTime?>?`)
  - `mode` (`PromptMode?`)
  - `initialView`, `initialViewType`
  - `popoverAlignment`, `popoverAnchorAlignment`, `popoverPadding`
  - `dialogTitle`, `placeholder`, `stateBuilder`, `enabled`
- `DateRangePicker`
  - `value` (`DateTimeRange?`, required)
  - `onChanged` (`ValueChanged<DateTimeRange?>?`)
- `ControlledDatePicker` — controller-backed picker.
- `DatePickerController` — `ValueNotifier<DateTime?>` controller.
- `DateTimeRange` — start/end date value type.

### Callbacks

- `onChanged`

---

## Theming

- `DatePickerTheme` controls prompt mode and default alignments.

---

## Accessibility

- Provide readable date formatting and labels.

---

## Do / Don’t

**Do**
- ✅ Use `stateBuilder` to disable invalid dates.

**Don’t**
- ❌ Allow range selection without clear start/end feedback.

---

## Related components

- `calendar`
- `form_field`
- `object_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
