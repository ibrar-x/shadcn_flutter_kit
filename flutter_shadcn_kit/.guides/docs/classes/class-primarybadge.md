---
title: "Class: PrimaryBadge"
description: "A primary style badge widget for highlighting important information or status."
---

```dart
/// A primary style badge widget for highlighting important information or status.
class PrimaryBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;
  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;
  /// Optional widget displayed before the child content.
  final Widget? leading;
  /// Optional widget displayed after the child content.
  final Widget? trailing;
  /// Optional custom style override for the badge.
  final AbstractButtonStyle? style;
  /// Creates a primary badge.
  const PrimaryBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});
  Widget build(BuildContext context);
}
```
