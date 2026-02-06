# Phone Input (`phone_input`)

International phone number input with country selector and formatting helpers.

---

## When to use

- Use this when:
  - you need a phone input with country picker.
- Avoid when:
  - you only need a local phone field.

---

## Install

```bash
flutter_shadcn add phone_input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/phone_input/phone_input.dart';
```

---

## Minimal example

```dart
PhoneInput(
  onChanged: (phone) {},
)
```

---

## API

### Constructor

- `PhoneInput`
  - `initialCountry` (`Country?`)
  - `initialValue` (`PhoneNumber?`)
  - `onChanged` (`ValueChanged<PhoneNumber>?`)
  - `controller` (`TextEditingController?`)
  - `filterPlusCode`, `filterZeroCode`, `filterCountryCode`, `onlyNumber`
  - `countries` (`List<Country>?`)
  - `searchPlaceholder` (`Widget?`)
- `PhoneNumber` — value model.

---

## Theming

- `PhoneInputTheme` controls spacing and select styling.

---

## Accessibility

- Provide readable country labels and flags.

---

## Do / Don’t

**Do**
- ✅ Restrict countries if your use case is regional.

**Don’t**
- ❌ Disable country code filtering when it would cause duplicate prefixes.

---

## Related components

- `select`
- `text_field`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
