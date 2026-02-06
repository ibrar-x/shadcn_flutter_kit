# Calendar (`calendar`)

Date picker and calendar widgets for single, range, and multi selection.

---

## When to use

- Use this when:
  - you need date selection with single/range/multi modes.
  - you want a themed calendar grid.
- Avoid when:
  - you only need a simple text date field.

---

## Install

```bash
flutter_shadcn add calendar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/calendar/calendar.dart';
```

---

## Minimal example

```dart
Calendar(
  view: CalendarView.now(),
  selectionMode: CalendarSelectionMode.single,
  onChanged: (value) {},
)
```

---

## Common patterns

### Pattern: Range selection

```dart
Calendar(
  view: CalendarView.now(),
  selectionMode: CalendarSelectionMode.range,
  value: CalendarValue.range(
    DateTime.now(),
    DateTime.now().add(const Duration(days: 7)),
  ),
  onChanged: (value) {},
)
```

### Pattern: Dialog picker

```dart
DatePickerDialog(
  initialViewType: CalendarViewType.date,
  selectionMode: CalendarSelectionMode.single,
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `Calendar`
  - `view` (`CalendarView`, required)
  - `selectionMode` (`CalendarSelectionMode`, required)
  - `value` (`CalendarValue?`)
  - `onChanged` (`ValueChanged<CalendarValue?>?`)
  - `stateBuilder` (`DateStateBuilder?`)
- `DatePickerDialog`
  - `initialViewType` (`CalendarViewType`, required)
  - `selectionMode` (`CalendarSelectionMode`, required)
  - `initialValue` (`CalendarValue?`)
  - `onChanged` (`ValueChanged<CalendarValue?>?`)
- `CalendarView` — view helpers (`now`, `fromDateTime`).
- `CalendarValue` — single/range/multi selection values.

### Callbacks

- `onChanged` (Calendar, DatePickerDialog)
- `stateBuilder` (Calendar, DatePickerDialog)

---

## Theming

- `CalendarTheme` controls spacing, colors, and typography for the grid.

---

## Accessibility

- Provide clear focus states and labels for date buttons.

---

## Do / Don’t

**Do**
- ✅ Use `CalendarSelectionMode` to enforce desired selection behavior.

**Don’t**
- ❌ Allow invalid dates without a `stateBuilder`.

---

## Related components

- `button`
- `form/date_picker`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
