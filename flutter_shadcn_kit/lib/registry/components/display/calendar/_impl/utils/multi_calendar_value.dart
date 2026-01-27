part of '../../calendar.dart';

/// Calendar value representing multiple selected dates.
///
/// Encapsulates a list of individually selected dates. Provides lookup
/// functionality to determine if a date is among the selected dates.
/// Used with [CalendarSelectionMode.multi].
class MultiCalendarValue extends CalendarValue {
  /// The list of selected dates.
  final List<DateTime> dates;

  /// Creates a multi calendar value with the specified list of dates.
  MultiCalendarValue(this.dates);

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime current = DateTime(year, month ?? 1, day ?? 1);
    if (dates.any((element) => _convertNecessarry(element, year, month, day)
        .isAtSameMomentAs(current))) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

  @override
  CalendarView get view =>
      dates.firstOrNull?.toCalendarView() ?? CalendarView.now();

  @override
  String toString() {
    return 'MultiCalendarValue($dates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MultiCalendarValue && listEquals(other.dates, dates);
  }

  @override
  int get hashCode => dates.hashCode;

  @override
  SingleCalendarValue toSingle() {
    return CalendarValue.single(dates.first);
  }

  @override
  RangeCalendarValue toRange() {
    assert(dates.isNotEmpty, 'Cannot convert empty list to range');
    DateTime min = dates
        .reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime max = dates
        .reduce((value, element) => value.isAfter(element) ? value : element);
    return CalendarValue.range(min, max);
  }

  @override
  MultiCalendarValue toMulti() {
    return this;
  }
}
