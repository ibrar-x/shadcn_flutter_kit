# Formatter (`formatter`)

Reusable text input formatters (uppercase/lowercase, numeric, math, HEX, etc.) and helpers for selection clipping.

---

## When to use

- Use this when:
  - you need consistent input formatting.
  - you want ready-made numeric/time/hex formatters.
- Avoid when:
  - custom validation is sufficient without formatting.

---

## Install

```bash
flutter_shadcn add formatter
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/formatter/formatter.dart';
```

---

## Minimal example

```dart
TextField(
  inputFormatters: [TextInputFormatters.toUpperCase],
)
```

---

## API

### Constructor

- `TextInputFormatters`
  - `toUpperCase`, `toLowerCase`
  - `integerOnly(min, max)`
  - `digitsOnly(min, max, decimalDigits)`
  - `time(length)`
  - `mathExpression(context)`
  - `hex(hashPrefix)`
- `contraintToNewText` — helper for selection bounds.

---

## Theming

- No theme dependencies.

---

## Accessibility

- Ensure formatting doesn’t block screen-reader edits.

---

## Do / Don’t

**Do**
- ✅ Combine formatters with validation for strict inputs.

**Don’t**
- ❌ Use math expression formatting for plain text fields.

---

## Related components

- `text_field`
- `formatted_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
