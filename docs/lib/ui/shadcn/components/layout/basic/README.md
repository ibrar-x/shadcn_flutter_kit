# Basic Layout

`Basic` and `BasicLayout` arrange leading/title/subtitle/content/trailing widgets with configurable alignment, spacing, and optional padding. `Basic` applies default text styles (small/medium/muted), while `BasicLayout` leaves text styling untouched and adds `constraints`. Use `Label` for simple leading/trailing labels.

```dart
Basic(
  leading: Icon(Icons.person),
  title: Text('John Doe'),
  subtitle: Text('john@example.com'),
  trailing: Icon(Icons.chevron_right),
);
```
