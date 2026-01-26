---
title: "Class: TrackerLevel"
description: "Abstract tracker level describing color and label."
---

```dart
/// Abstract tracker level describing color and label.
abstract class TrackerLevel {
  static const TrackerLevel fine = _SimpleTrackerLevel(Colors.green, 'Fine');
  static const TrackerLevel warning = _SimpleTrackerLevel(Colors.orange, 'Warning');
  static const TrackerLevel critical = _SimpleTrackerLevel(Colors.red, 'Critical');
  static const TrackerLevel unknown = _SimpleTrackerLevel(Colors.grey, 'Unknown');
  Color get color;
  String get name;
}
```
