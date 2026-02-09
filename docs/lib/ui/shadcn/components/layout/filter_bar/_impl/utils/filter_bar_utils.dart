part of '../../filter_bar.dart';

class _Debouncer {
  _Debouncer(this.duration);

  Duration duration;
  Timer? _timer;

  void schedule(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}

String _formatResultsCount(int count) {
  return '$count result${count == 1 ? '' : 's'}';
}

String _formatActiveFilterCount(int count) {
  return '$count active filter${count == 1 ? '' : 's'}';
}

String _formatCompactDateLabel(
  ShadcnLocalizations localizations,
  DateTime date,
) {
  final month = localizations.getAbbreviatedMonth(date.month);
  return '$month ${date.day}';
}

String _formatCompactDateRangeLabel(
  ShadcnLocalizations localizations,
  DateTimeRange range,
) {
  final start = _formatCompactDateLabel(localizations, range.start);
  final end = _formatCompactDateLabel(localizations, range.end);
  if (range.start.year == range.end.year) {
    return '$start - $end, ${range.end.year}';
  }
  return '$start, ${range.start.year} - $end, ${range.end.year}';
}
