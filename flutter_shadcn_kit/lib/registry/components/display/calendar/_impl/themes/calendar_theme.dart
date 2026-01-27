part of '../../calendar.dart';


/// Theme configuration for calendar widgets.
///
/// Provides styling options for calendar components, including arrow icon colors
/// for navigation buttons and other visual elements.
class CalendarTheme extends ComponentThemeData {
  /// Color of navigation arrow icons.
  final Color? arrowIconColor;

  /// Creates a [CalendarTheme].
  ///
  /// Parameters:
  /// - [arrowIconColor] (`Color?`, optional): Color for navigation arrow icons.
  const CalendarTheme({this.arrowIconColor});

  /// Creates a copy of this theme with the given fields replaced.
  CalendarTheme copyWith({ValueGetter<Color?>? arrowIconColor}) {
    return CalendarTheme(
        arrowIconColor:
            arrowIconColor == null ? this.arrowIconColor : arrowIconColor());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalendarTheme && other.arrowIconColor == arrowIconColor;
  }

  @override
  int get hashCode => arrowIconColor.hashCode;
}

/// Defines the different view types available in calendar components.
///
/// Specifies what granularity of time selection is displayed.
enum CalendarViewType {
  /// Shows individual days in a month grid.
  date,

  /// Shows months in a year grid.
  month,

  /// Shows years in a decade grid.
  year,
}

/// Represents the interactive state of a date in the calendar.
///
/// Controls whether a specific date can be selected or interacted with.
enum DateState {
  /// Date cannot be selected or clicked.
  disabled,

  /// Date is fully interactive and selectable.
  enabled,
}

/// Callback function type for determining the state of calendar dates.
///
/// Takes a [DateTime] and returns a [DateState] to control whether
/// that date should be enabled or disabled for user interaction.
typedef DateStateBuilder = DateState Function(DateTime date);

/// Selection modes available for calendar components.
///
/// Determines how users can select dates in calendar widgets.
enum CalendarSelectionMode {
  /// No date selection allowed (display only).
  none,

  /// Only one date can be selected at a time.
  single,

  /// Two dates can be selected to form a date range.
  range,

  /// Multiple individual dates can be selected.
  multi,
}

/// A date picker dialog that provides comprehensive date selection capabilities.
///
/// Displays a modal dialog containing a calendar interface with support for
/// different view types (date, month, year), selection modes (single, range, multi),
/// and customizable date states. Includes navigation controls and responsive layouts.
///
/// Features:
/// - Multiple view types: date grid, month grid, year grid
/// - Various selection modes: single date, date range, multiple dates
/// - Navigation arrows with keyboard support
/// - Customizable date state validation
/// - Dual-calendar layout for range selection
/// - Theme integration and localization support
///
/// Example:
/// ```dart
/// DatePickerDialog(
///   initialViewType: CalendarViewType.date,
///   selectionMode: CalendarSelectionMode.single,
///   initialValue: CalendarValue.single(DateTime.now()),
///   onChanged: (value) => print('Selected: $value'),
/// )
/// ```
