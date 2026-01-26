---
title: "Extension: ShadcnLocalizationsObjectInputExtensions"
description: "Adds helpers required by object input components."
---

```dart
/// Adds helpers required by object input components.
extension ShadcnLocalizationsObjectInputExtensions on ShadcnLocalizations {
  /// Default order used when rendering date fields.
  List<DatePart> get datePartsOrder;
  /// Returns the abbreviation for the provided [DatePart].
  String getDatePartAbbreviation(DatePart part);
  /// Returns the abbreviation for the provided [TimePart].
  String getTimePartAbbreviation(TimePart part);
  /// Formats a [TimeOfDay] object into a string.
  ///
  /// [use24HourFormat] - Whether to use 24-hour format.
  /// [showSeconds] - Whether to include seconds.
  String formatTimeOfDay(TimeOfDay time, {bool use24HourFormat = true, bool showSeconds = false});
  /// Formats a [Duration] into a string.
  ///
  /// [showDays] - Whether to show days.
  /// [showHours] - Whether to show hours.
  /// [showMinutes] - Whether to show minutes.
  /// [showSeconds] - Whether to show seconds.
  String formatDuration(Duration duration, {bool showDays = true, bool showHours = true, bool showMinutes = true, bool showSeconds = true});
  /// Gets the abbreviation for a [DurationPart].
  String getDurationPartAbbreviation(DurationPart part);
  /// Formats a [DateTime] into a localized string.
  ///
  /// [showDate] - Whether to include the date portion.
  /// [showTime] - Whether to include the time portion.
  /// [showSeconds] - Whether to include seconds in the time portion.
  /// [use24HourFormat] - Whether to use 24-hour time formatting.
  String formatDateTime(DateTime dateTime, {bool showDate = true, bool showTime = true, bool showSeconds = false, bool use24HourFormat = true});
}
```
