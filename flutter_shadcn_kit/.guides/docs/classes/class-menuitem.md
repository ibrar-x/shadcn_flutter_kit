---
title: "Class: MenuItem"
description: "Reference for MenuItem"
---

```dart
abstract class MenuItem extends Widget {
  /// Creates a menu item.
  const MenuItem({super.key});
  /// Whether this menu item has a leading widget (icon, checkbox indicator, etc.).
  bool get hasLeading;
  /// Optional popover controller for submenu functionality.
  PopoverController? get popoverController;
}
```
