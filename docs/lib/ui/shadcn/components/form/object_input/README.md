# Object Input (`object_input`)

Date, time, and duration inputs powered by formatted editors and pickers.

---

## When to use

- Use this when:
  - you need structured date/time/duration inputs.
  - you want inline editing plus picker integration.
- Avoid when:
  - a plain text field or single picker is sufficient.

---

## Install

```bash
flutter_shadcn add object_input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/object_input/object_input.dart';
```

---

## Minimal example

```dart
DateInput(
  initialValue: DateTime.now(),
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `DateInput`
  - `initialValue`, `onChanged`, `controller`, `enabled`
  - `mode` (`PromptMode`), `initialView`, `initialViewType`
  - `datePartsOrder`, `separator`, `placeholders`
- `TimeInput`
  - `initialValue`, `onChanged`, `controller`, `enabled`
  - `use24HourFormat`, `showSeconds`
- `DurationInput`
  - `initialValue`, `onChanged`, `controller`, `enabled`
- `NullableDate`, `NullableTimeOfDay` — wrappers for optional values.

---

## Theming

- Uses shared card and input theming through formatted inputs.

---

## Accessibility

- Ensure each part has clear placeholder text.

---

## Do / Don’t

**Do**
- ✅ Use `datePartsOrder` to match locale expectations.

**Don’t**
- ❌ Mix incompatible separators or placeholder lengths.

---

## Related components

- `formatted_input`
- `date_picker`
- `time_picker`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
