---
title: "Class: Card"
description: "A versatile container widget that provides a card-like appearance with styling options."
---

```dart
/// A versatile container widget that provides a card-like appearance with styling options.
class Card extends StatelessWidget {
  /// The child widget to display within the card.
  final Widget child;
  /// Padding inside the card around the [child].
  final EdgeInsetsGeometry? padding;
  /// Whether the card has a filled background.
  final bool? filled;
  /// The background fill color of the card.
  final Color? fillColor;
  /// Border radius for rounded corners on the card.
  final BorderRadiusGeometry? borderRadius;
  /// Color of the card's border.
  final Color? borderColor;
  /// Width of the card's border in logical pixels.
  final double? borderWidth;
  /// How to clip the card's content.
  final Clip? clipBehavior;
  /// Box shadows to apply to the card.
  final List<BoxShadow>? boxShadow;
  /// Opacity of the card's surface effect.
  final double? surfaceOpacity;
  /// Blur amount for the card's surface effect.
  final double? surfaceBlur;
  /// Duration for card appearance animations.
  final Duration? duration;
  /// Creates a [Card].
  const Card({super.key, required this.child, this.padding, this.filled, this.fillColor, this.borderRadius, this.clipBehavior, this.borderColor, this.borderWidth, this.boxShadow, this.surfaceOpacity, this.surfaceBlur, this.duration});
  Widget build(BuildContext context);
}
```
