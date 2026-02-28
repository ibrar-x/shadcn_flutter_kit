# Formatted Input (`formatted_input`)

Low-level formatted-field helpers that sync multiple InputPart segments.

---

## When to use

- Use this when:
  - you need structured inputs (phone, date, currency) with segmented parts.
  - you want custom formatted objects backed by controllers.
- Avoid when:
  - a regular text field is sufficient.

---

## Install

```bash
flutter_shadcn add formatted_input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/formatted_input/formatted_input.dart';
```

---

## Minimal example

```dart
FormattedInput(
  initialValue: FormattedValue([
    FormattedValuePart.static('('),
    FormattedValuePart.editable('555', length: 3),
    FormattedValuePart.static(') '),
    FormattedValuePart.editable('123', length: 3),
  ]),
)
```

---

## API

### Constructor

- `FormattedInput`
  - `initialValue` (`FormattedValue?`)
  - `onChanged` (`ValueChanged<FormattedValue>?`)
  - `controller` (`FormattedInputController?`)
  - `style`, `leading`, `trailing`, `enabled`
- `FormattedObjectInput<T>` — formatted input with popup editor.
- `FormattedInputController` — controller for formatted values.
- `FormattedValue` — list of `FormattedValuePart` entries.
- `FormattedValuePart` — `static`, `editable`, or `widget` parts.
- `InputPart`, `EditablePart`, `StaticPart` — low-level part types.

---

## Theming

- `FormattedInputTheme` controls spacing, borders, and typography.

---

## Accessibility

- Provide clear separators between parts for screen readers.

---

## Do / Don’t

**Do**
- ✅ Use monospace fonts for aligned parts.

**Don’t**
- ❌ Mix unrelated parts without separators.

---

## Related components

- `text_field`
- `formatter`
- `object_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
