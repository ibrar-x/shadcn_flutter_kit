part of 'date_picker.dart';

/// Represents a range of dates with a start and end time.
///
/// Immutable value type for representing a continuous period between two dates.
/// Commonly used with date range pickers to specify selected date intervals.
///
/// Example:
/// ```dart
/// final range = DateTimeRange(
///   DateTime(2024, 1, 1),
///   DateTime(2024, 1, 31),
/// );
/// ```
class DateTimeRange {
  /// The start date/time of the range.
  final DateTime start;

  /// The end date/time of the range.
  final DateTime end;

  /// Creates a [DateTimeRange].
  ///
  /// Parameters:
  /// - [start] (`DateTime`, required): The beginning of the range.
  /// - [end] (`DateTime`, required): The end of the range.
  const DateTimeRange(this.start, this.end);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateTimeRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() {
    return 'DateTimeRange{start: $start, end: $end}';
  }

  /// Creates a copy of this range with the given fields replaced.
  ///
  /// Parameters:
  /// - [start] (`ValueGetter<DateTime>?`, optional): New start date.
  /// - [end] (`ValueGetter<DateTime>?`, optional): New end date.
  ///
  /// Returns: A new [DateTimeRange] with updated values.
  DateTimeRange copyWith({
    ValueGetter<DateTime>? start,
    ValueGetter<DateTime>? end,
  }) {
    return DateTimeRange(
      start == null ? this.start : start(),
      end == null ? this.end : end(),
    );
  }
}
