# Shadcn Localizations Extensions

Formatting helpers for dates, times, durations, and picker labels.

## Usage
```dart
final localizations = ShadcnLocalizationsEn();
final label = localizations.formatTimeOfDay(
  TimeOfDay(hour: 9, minute: 30),
  use24HourFormat: true,
);
```
