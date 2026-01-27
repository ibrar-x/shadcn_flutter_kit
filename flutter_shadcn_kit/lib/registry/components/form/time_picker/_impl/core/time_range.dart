part of '../../time_picker.dart';

/// Represents a range of time with a start and end time.
///
/// Used to define time intervals or periods. Both [start] and [end]
/// are represented as [TimeOfDay] values.
///
/// Example:
/// ```dart
/// final workHours = TimeRange(
///   start: TimeOfDay(hour: 9, minute: 0),
///   end: TimeOfDay(hour: 17, minute: 0),
/// );
/// ```
class TimeRange {
  /// The start time of the range.
  final TimeOfDay start;

  /// The end time of the range.
  final TimeOfDay end;

  /// Creates a [TimeRange] with the specified start and end times.
  const TimeRange({
    required this.start,
    required this.end,
  });

  /// Creates a copy of this range with the given fields replaced.
  TimeRange copyWith({
    ValueGetter<TimeOfDay>? start,
    ValueGetter<TimeOfDay>? end,
  }) {
    return TimeRange(
      start: start == null ? this.start : start(),
      end: end == null ? this.end : end(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeRange &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() {
    return 'TimeRange{start: $start, end: $end}';
  }
}
