# Number Input (`number_input`)

Composite export for numeric input helpers.

---

## When to use

- Use this when:
  - you need a numeric text field with spinner controls.
  - you want optional math expression parsing on submit.
- Avoid when:
  - a slider or stepper is a better fit.

---

## Install

```bash
flutter_shadcn add number_input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/form/number_input/number_input.dart';
```

---

## Minimal example

```dart
NumberInput(
  value: 12,
  onChanged: (value) {},
)
```

---

## API

### Widgets and helpers

- `NumberInput`
- `TextField`
- `InputFeature`
- `TextInputFormatters`

---

## Theming

- Inherits text field theming from the form registry.

---

## Accessibility

- Provide labels and units for numeric fields.

---

## Do / Don’t

**Do**
- ✅ Use `step` to match expected increments.

**Don’t**
- ❌ Hide validation feedback for invalid values.

---

## Related components

- `text_field`
- `slider`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
