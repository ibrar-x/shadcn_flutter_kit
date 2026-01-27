part of '../../calendar.dart';

enum CalendarItemType {
  /// Normal unselected date.
  none,

  /// Current date highlighted.
  today,

  /// Single selected date or exact range boundary.
  selected,

  /// Date within a selected range but not start/end.
  inRange,

  /// Range start boundary in other months (same as startRangeSelected).
  startRange,

  /// Range end boundary in other months (same as endRangeSelected).
  endRange,

  /// Range start boundary in current month.
  startRangeSelected,

  /// Range end boundary in current month.
  endRangeSelected,

  /// Range start boundary in short ranges.
  startRangeSelectedShort,

  /// Range end boundary in short ranges (typically 2-day ranges).
  endRangeSelectedShort,

  /// Middle dates in short ranges (typically 2-day ranges).
  inRangeSelectedShort,
}
