---
title: "Class: CalendarValue"
description: "Reference for CalendarValue"
---

```dart
abstract class CalendarValue {
  /// Looks up whether the specified date is part of this calendar value.
  ///
  /// Returns a [CalendarValueLookup] indicating the relationship of the
  /// queried date to this value (none, selected, start, end, or inRange).
  CalendarValueLookup lookup(int year, [int? month = 1, int? day = 1]);
  /// Creates a base calendar value.
  const CalendarValue();
  /// Factory constructor to create a single date value.
  static SingleCalendarValue single(DateTime date);
  /// Factory constructor to create a date range value.
  static RangeCalendarValue range(DateTime start, DateTime end);
  /// Factory constructor to create a multi-date value.
  static MultiCalendarValue multi(List<DateTime> dates);
  /// Converts this value to a single calendar value.
  SingleCalendarValue toSingle();
  /// Converts this value to a range calendar value.
  RangeCalendarValue toRange();
  /// Converts this value to a multi calendar value.
  MultiCalendarValue toMulti();
  /// Returns the calendar view associated with this value.
  CalendarView get view;
}
```
