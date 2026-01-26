---
title: "Class: OutlinedContainer"
description: "Reference for OutlinedContainer"
---

```dart
class OutlinedContainer extends StatefulWidget {
  const OutlinedContainer({super.key, required this.child, this.backgroundColor, this.borderColor, this.borderRadius, this.borderWidth, this.borderStyle, this.boxShadow, this.padding, this.clipBehavior = Clip.antiAlias, this.surfaceOpacity, this.surfaceBlur, this.width, this.height, this.duration});
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final double? borderWidth;
  final BorderStyle? borderStyle;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final double? width;
  final double? height;
  final Duration? duration;
  State<OutlinedContainer> createState();
}
```
