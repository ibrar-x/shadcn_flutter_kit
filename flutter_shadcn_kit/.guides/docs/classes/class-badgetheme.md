---
title: "Class: BadgeTheme"
description: "Theme data for customizing badge widget appearance across different styles."
---

```dart
/// Theme data for customizing badge widget appearance across different styles.
class BadgeTheme extends ComponentThemeData {
  /// Style for [PrimaryBadge].
  final AbstractButtonStyle? primaryStyle;
  /// Style for [SecondaryBadge].
  final AbstractButtonStyle? secondaryStyle;
  /// Style for [OutlineBadge].
  final AbstractButtonStyle? outlineStyle;
  /// Style for [DestructiveBadge].
  final AbstractButtonStyle? destructiveStyle;
  /// Creates a [BadgeTheme].
  const BadgeTheme({this.primaryStyle, this.secondaryStyle, this.outlineStyle, this.destructiveStyle});
  /// Returns a copy of this theme with the given fields replaced.
  BadgeTheme copyWith({ValueGetter<AbstractButtonStyle?>? primaryStyle, ValueGetter<AbstractButtonStyle?>? secondaryStyle, ValueGetter<AbstractButtonStyle?>? outlineStyle, ValueGetter<AbstractButtonStyle?>? destructiveStyle});
  bool operator ==(Object other);
  int get hashCode;
}
```
