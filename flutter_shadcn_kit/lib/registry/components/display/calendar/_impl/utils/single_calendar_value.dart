part of '../../calendar.dart';

/// Calendar value representing a single selected date.
///
/// Encapsulates a single [DateTime] selection and provides lookup functionality
/// to determine if a given date matches the selected date. Used primarily
/// with [CalendarSelectionMode.single].
///
/// Example:
/// ```dart
/// final singleValue = SingleCalendarValue(DateTime(2024, 3, 15));
/// final lookup = singleValue.lookup(2024, 3, 15);
/// print(lookup == CalendarValueLookup.selected); // true
/// ```
class SingleCalendarValue extends CalendarValue {
  /// The selected date.
  final DateTime date;

  /// Creates a single calendar value with the specified date.
  SingleCalendarValue(this.date);

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime current = _convertNecessarry(date, year, month, day);
    if (current.isAtSameMomentAs(DateTime(year, month ?? 1, day ?? 1))) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

  @override
  CalendarView get view => date.toCalendarView();

  @override
  String toString() {
    return 'SingleCalendarValue($date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleCalendarValue && other.date == date;
  }

  @override
  int get hashCode => date.hashCode;

  @override
  SingleCalendarValue toSingle() {
    return this;
  }

  @override
  RangeCalendarValue toRange() {
    return CalendarValue.range(date, date);
  }

  @override
  MultiCalendarValue toMulti() {
    return CalendarValue.multi([date]);
  }
}
