# Locale Utils

Provides reusable helpers for formatting file sizes and inspecting date/time/duration units.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/locale_utils/locale_utils.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final bytes = 42_000;
    final formatted = formatFileSize(bytes, SizeUnitLocale.fileBytes);
    return Text('Formatted: $formatted');
  }
}
```

## Features

- `SizeUnitLocale` describes binary/decimal units and separators.
- `formatFileSize` converts bytes to a human readable string.
- `DatePart`, `DurationPart`, `TimePart` helpers describe valid ranges and string lengths.
