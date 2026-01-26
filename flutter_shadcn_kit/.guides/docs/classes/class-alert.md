---
title: "Class: Alert"
description: "Flexible alert box for status, warning, and info messages."
---

```dart
/// Flexible alert box for status, warning, and info messages.
class Alert extends StatelessWidget {
  /// Optional leading widget (icon/avatar).
  final Widget? leading;
  /// Optional title widget.
  final Widget? title;
  /// Optional descriptive content.
  final Widget? content;
  /// Optional trailing widget (actions/dismissal).
  final Widget? trailing;
  /// Applies destructive styling when true.
  final bool destructive;
  /// Creates a styled [Alert].
  const Alert({super.key, this.leading, this.title, this.content, this.trailing, this.destructive = false});
  /// Convenience constructor for destructive alerts.
  const Alert.destructive({super.key, this.leading, this.title, this.content, this.trailing});
  Widget build(BuildContext context);
}
```
