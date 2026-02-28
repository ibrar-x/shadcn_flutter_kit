# Input OTP (`input_otp`)

Fixed-length OTP input field with clipboard integration, paste handling, and focus management.

---

## When to use

- Use this when:
  - you need multi-digit OTP or PIN entry.
  - you want auto-advance and paste handling.
- Avoid when:
  - a single text field is sufficient.

---

## Install

```bash
flutter_shadcn add input_otp
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/input_otp/input_otp.dart';
```

---

## Minimal example

```dart
InputOTP(
  children: const [
    CharacterInputOTPChild(),
    CharacterInputOTPChild(),
    CharacterInputOTPChild(),
    CharacterInputOTPChild(),
  ],
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `InputOTP`
  - `children` (`List<InputOTPChild>`, required)
  - `initialValue` (`OTPCodepointList?`)
  - `onChanged`, `onSubmitted`
- `InputOTPChild` — base class for OTP parts.
- `CharacterInputOTPChild` — standard character input box.
- `WidgetInputOTPChild` — custom widget slot.
- `OTPCodepointList` — list of nullable codepoints.

### Callbacks

- `onChanged`, `onSubmitted`

---

## Theming

- `InputOTPTheme` controls spacing, sizing, and colors.

---

## Accessibility

- Ensure each cell is focusable for keyboard users.

---

## Do / Don’t

**Do**
- ✅ Use separators for grouped codes.

**Don’t**
- ❌ Allow unlimited length without clear boundaries.

---

## Related components

- `text_field`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
