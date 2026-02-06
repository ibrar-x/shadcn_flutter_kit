# Calendar

Date picker and calendar widgets supporting single, range, and multi selection.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/calendar/calendar.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Calendar(
      value: CalendarValue.single(DateTime.now()),
      selectionMode: CalendarSelectionMode.single,
      onChanged: (value) {
        // Handle selection updates.
      },
    );
  }
}
```

## Theming

Use `CalendarTheme` via `ComponentTheme` to override arrow icon colors and
integrate with `ThemeData.extensions`.
