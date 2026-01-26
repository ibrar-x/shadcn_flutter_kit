---
title: "Class: DatePickerDialog"
description: "Reference for DatePickerDialog"
---

```dart
class DatePickerDialog extends StatefulWidget {
  /// The initial view type to display (date, month, or year grid).
  final CalendarViewType initialViewType;
  /// The initial calendar view position (month/year to display).
  final CalendarView? initialView;
  /// The selection mode determining how dates can be selected.
  final CalendarSelectionMode selectionMode;
  /// Alternative view mode for display purposes.
  final CalendarSelectionMode? viewMode;
  /// The initially selected date value(s).
  final CalendarValue? initialValue;
  /// Callback invoked when the selected date(s) change.
  final ValueChanged<CalendarValue?>? onChanged;
  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;
  /// Creates a [DatePickerDialog] with comprehensive date selection options.
  ///
  /// Configures the dialog's initial state, selection behavior, and callbacks
  /// for handling date changes and validation.
  ///
  /// Parameters:
  /// - [initialViewType] (CalendarViewType, required): Starting view (date/month/year)
  /// - [initialView] (CalendarView?, optional): Initial calendar view position
  /// - [selectionMode] (CalendarSelectionMode, required): How dates can be selected
  /// - [viewMode] (CalendarSelectionMode?, optional): Alternative view mode for display
  /// - [initialValue] (CalendarValue?, optional): Pre-selected date(s)
  /// - [onChanged] (`ValueChanged<CalendarValue>?`, optional): Called when selection changes
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// Example:
  /// ```dart
  /// DatePickerDialog(
  ///   initialViewType: CalendarViewType.date,
  ///   selectionMode: CalendarSelectionMode.range,
  ///   onChanged: (value) => handleDateChange(value),
  ///   stateBuilder: (date) => date.isBefore(DateTime.now())
  ///     ? DateState.disabled
  ///     : DateState.enabled,
  /// )
  /// ```
  const DatePickerDialog({super.key, required this.initialViewType, this.initialView, required this.selectionMode, this.viewMode, this.initialValue, this.onChanged, this.stateBuilder});
  State<DatePickerDialog> createState();
}
```
