---
title: "Class: AccordionTheme"
description: "Theme data used by [Accordion], [AccordionItem], and [AccordionTrigger]."
---

```dart
/// Theme data used by [Accordion], [AccordionItem], and [AccordionTrigger].
class AccordionTheme extends ComponentThemeData {
  /// Creates an accordion theme.
  const AccordionTheme({this.duration, this.curve, this.reverseCurve, this.padding, this.iconGap, this.dividerHeight, this.dividerColor, this.arrowIcon, this.arrowIconColor});
  /// Animation duration when expanding/collapsing items.
  final Duration? duration;
  /// Curve applied when expanding.
  final Curve? curve;
  /// Curve applied when collapsing.
  final Curve? reverseCurve;
  /// Vertical padding around the trigger and content.
  final double? padding;
  /// Spacing between the trigger content and the arrow icon.
  final double? iconGap;
  /// Height of the dividers between items.
  final double? dividerHeight;
  /// Color of the dividers between items.
  final Color? dividerColor;
  /// Icon data used for the expand/collapse indicator.
  final IconData? arrowIcon;
  /// Color of the expand/collapse icon.
  final Color? arrowIconColor;
  /// Creates a copy of this theme with selective overrides.
  AccordionTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<Curve?>? reverseCurve, ValueGetter<double?>? padding, ValueGetter<double?>? iconGap, ValueGetter<double?>? dividerHeight, ValueGetter<Color?>? dividerColor, ValueGetter<IconData?>? arrowIcon, ValueGetter<Color?>? arrowIconColor});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
