---
title: "Class: CardImageTheme"
description: "Theme configuration for [CardImage] components."
---

```dart
/// Theme configuration for [CardImage] components.
class CardImageTheme extends ComponentThemeData {
  /// Button style for the card.
  final AbstractButtonStyle? style;
  /// Layout direction for title/subtitle relative to the image.
  final Axis? direction;
  /// Scale factor when hovering over the image.
  final double? hoverScale;
  /// Normal scale factor for the image.
  final double? normalScale;
  /// Background color for the image container.
  final Color? backgroundColor;
  /// Border color for the image container.
  final Color? borderColor;
  /// Gap between image and text content.
  final double? gap;
  const CardImageTheme({this.style, this.direction, this.hoverScale, this.normalScale, this.backgroundColor, this.borderColor, this.gap});
  CardImageTheme copyWith({ValueGetter<AbstractButtonStyle?>? style, ValueGetter<Axis?>? direction, ValueGetter<double?>? hoverScale, ValueGetter<double?>? normalScale, ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? borderColor, ValueGetter<double?>? gap});
  bool operator ==(Object other);
  int get hashCode;
}
```
