---
title: "Class: MenuRadioGroup"
description: "Reference for MenuRadioGroup"
---

```dart
class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  /// Currently selected value.
  final T? value;
  /// Callback when selection changes.
  final ContextedValueChanged<T>? onChanged;
  /// List of [MenuRadio] children.
  final List<Widget> children;
  /// Creates a radio group for menu items.
  ///
  /// Parameters:
  /// - [value] (T?): Currently selected value
  /// - [onChanged] (`ContextedValueChanged<T>?`): Selection change callback
  /// - [children] (`List<Widget>`): Radio button children
  const MenuRadioGroup({super.key, required this.value, required this.onChanged, required this.children});
  bool get hasLeading;
  PopoverController? get popoverController;
  Widget build(BuildContext context);
}
```
