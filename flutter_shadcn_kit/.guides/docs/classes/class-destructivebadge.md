---
title: "Class: DestructiveBadge"
description: "A destructive-styled badge for displaying warnings or dangerous actions."
---

```dart
/// A destructive-styled badge for displaying warnings or dangerous actions.
class DestructiveBadge extends StatelessWidget {
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
  /// Creates a destructive badge with the specified child content.
  const DestructiveBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});
  Widget build(BuildContext context);
}
```
