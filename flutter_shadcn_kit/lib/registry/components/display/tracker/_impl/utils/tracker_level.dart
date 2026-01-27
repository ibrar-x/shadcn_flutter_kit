part of '../../tracker.dart';

/// Abstract tracker level describing color and label.
abstract class TrackerLevel {
  static const TrackerLevel fine = _SimpleTrackerLevel(Colors.green, 'Fine');
  static const TrackerLevel warning =
      _SimpleTrackerLevel(Colors.orange, 'Warning');
  static const TrackerLevel critical =
      _SimpleTrackerLevel(Colors.red, 'Critical');
  static const TrackerLevel unknown =
      _SimpleTrackerLevel(Colors.grey, 'Unknown');

  Color get color;
  String get name;
}

class _SimpleTrackerLevel implements TrackerLevel {
  @override
  final Color color;
  @override
  final String name;

  const _SimpleTrackerLevel(this.color, this.name);
}

/// Data for a single tracker segment.
class TrackerData {
  final Widget tooltip;
  final TrackerLevel level;

  const TrackerData({
    required this.tooltip,
    required this.level,
  });
}
