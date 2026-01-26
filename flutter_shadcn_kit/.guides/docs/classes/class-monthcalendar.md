---
title: "Class: MonthCalendar"
description: "Reference for MonthCalendar"
---

```dart
class MonthCalendar extends StatelessWidget {
  /// The current calendar view (year to display).
  final CalendarView value;
  /// Callback invoked when a month is selected.
  final ValueChanged<CalendarView> onChanged;
  /// The current date for highlighting purposes.
  final DateTime? now;
  /// The currently selected calendar value.
  final CalendarValue? calendarValue;
  /// Builder function to determine the state of each month.
  final DateStateBuilder? stateBuilder;
  /// Creates a month selection calendar.
  const MonthCalendar({super.key, required this.value, required this.onChanged, this.now, this.calendarValue, this.stateBuilder});
  Widget build(BuildContext context);
}
```
