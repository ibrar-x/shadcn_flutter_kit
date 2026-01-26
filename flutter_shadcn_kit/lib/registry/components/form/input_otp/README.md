# Input OTP

One-time password input with fixed-length fields, paste handling, and clipboard shortcuts.

```dart
import 'ui/shadcn/components/input_otp/input_otp.dart';

InputOtp(
  length: 6,
  onChanged: (value) => print(value),
);
```

Wrap in `ComponentTheme<InputOtpTheme>` to tune spacing, cursor, and border radius before installation.
