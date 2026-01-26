---
title: "Class: MenuPopup"
description: "Reference for MenuPopup"
---

```dart
class MenuPopup extends StatelessWidget {
  /// Opacity of the surface blur effect.
  ///
  /// Controls the transparency of the backdrop blur. Higher values make
  /// the blur more visible. If `null`, uses theme default.
  final double? surfaceOpacity;
  /// Amount of blur to apply to the surface behind the popup.
  ///
  /// Higher values create more blur effect. If `null`, uses theme default.
  final double? surfaceBlur;
  /// Internal padding around the menu items.
  ///
  /// Defines the space between the popup's border and its content.
  /// If `null`, uses theme default or adaptive default based on overlay type.
  final EdgeInsetsGeometry? padding;
  /// Background fill color of the popup.
  ///
  /// If `null`, uses the theme's popover color.
  final Color? fillColor;
  /// Border color of the popup.
  ///
  /// If `null`, uses the theme's border color.
  final Color? borderColor;
  /// Corner radius of the popup border.
  ///
  /// If `null`, uses the theme's medium border radius.
  final BorderRadiusGeometry? borderRadius;
  /// The menu items to display inside the popup.
  ///
  /// Typically a list of [MenuItem] widgets or similar menu components.
  final List<Widget> children;
  /// Creates a menu popup container.
  ///
  /// Parameters:
  /// - [children]: Menu items to display (required)
  /// - [surfaceOpacity]: Backdrop blur opacity
  /// - [surfaceBlur]: Amount of surface blur
  /// - [padding]: Internal padding
  /// - [fillColor]: Background color
  /// - [borderColor]: Border color
  /// - [borderRadius]: Corner radius
  const MenuPopup({super.key, this.surfaceOpacity, this.surfaceBlur, this.padding, this.fillColor, this.borderColor, this.borderRadius, required this.children});
  Widget build(BuildContext context);
}
```
