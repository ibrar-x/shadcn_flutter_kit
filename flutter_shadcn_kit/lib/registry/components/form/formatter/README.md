# Formatter

Text input formatters and helpers for enforcing casing, numeric ranges, math expressions, and HEX values.

```dart
import 'ui/shadcn/components/formatter/formatter.dart';

final formatters = [
  TextInputFormatters.toUpperCase,
  TextInputFormatters.integerOnly(min: 0, max: 100),
  TextInputFormatters.hex(hashPrefix: true),
];
```

Use `contraintToNewText` when custom formatters need to clamp `TextSelection` to a modified string length.
