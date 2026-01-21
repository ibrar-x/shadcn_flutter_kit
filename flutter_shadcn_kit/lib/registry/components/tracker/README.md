# Tracker

Horizontal status tracker that uses tooltip content per segment.

## Usage

```dart
Tracker(
  data: [
    TrackerData(
      level: TrackerLevel.fine,
      tooltip: Text('Database OK'),
    ),
    TrackerData(
      level: TrackerLevel.warning,
      tooltip: Text('API latency high'),
    ),
  ],
);
```

You can theme spacing via `TrackerTheme`.
