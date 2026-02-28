part of '../../tracker.dart';

/// Data for a single tracker segment.
class TrackerData {
  /// Input parameter used by `TrackerData` during rendering and behavior handling.
  final Widget tooltip;

  /// Input parameter used by `TrackerData` during rendering and behavior handling.
  final TrackerLevel level;

  const TrackerData({required this.tooltip, required this.level});
}
