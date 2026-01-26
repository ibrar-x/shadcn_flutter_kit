---
title: "Class: AlphaPainter"
description: "A simple checkerboard painter used to visualize transparency."
---

```dart
/// A simple checkerboard painter used to visualize transparency.
///
/// The pattern is typically shown behind semi-transparent colors in color
/// pickers or image editors to make the alpha level readable against various
/// backgrounds.
class AlphaPainter extends CustomPainter {
  /// Primary color used in the checkerboard pattern.
  static const Color checkboardPrimary = Color(0xFFE0E0E0);
  /// Secondary color used in the checkerboard pattern.
  static const Color checkboardSecondary = Color(0xFFB0B0B0);
  /// Size of each square in the checkerboard pattern.
  static const double checkboardSize = 8.0;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant AlphaPainter oldDelegate);
}
```
