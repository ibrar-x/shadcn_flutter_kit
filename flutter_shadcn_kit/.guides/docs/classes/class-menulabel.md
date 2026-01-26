---
title: "Class: MenuLabel"
description: "Reference for MenuLabel"
---

```dart
class MenuLabel extends StatelessWidget implements MenuItem {
  /// Content widget displayed in the label.
  final Widget child;
  /// Optional trailing widget.
  final Widget? trailing;
  /// Optional leading widget (e.g., icon).
  final Widget? leading;
  /// Creates a menu label.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content
  /// - [trailing] (Widget?): Trailing widget
  /// - [leading] (Widget?): Leading icon or widget
  const MenuLabel({super.key, required this.child, this.trailing, this.leading});
  bool get hasLeading;
  PopoverController? get popoverController;
  Widget build(BuildContext context);
}
```
