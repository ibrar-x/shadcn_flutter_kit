import 'package:flutter/widgets.dart';

import '../../shared/theme/theme.dart';
import '../../shared/utils/style_value.dart';

/// Theme configuration for [MediaQueryVisibility].
class MediaQueryVisibilityTheme extends ComponentThemeData {
  /// Minimum width at which the child is shown.
  final double? minWidth;

  /// Maximum width at which the child is shown.
  final double? maxWidth;

  /// Creates a [MediaQueryVisibilityTheme].
  const MediaQueryVisibilityTheme({this.minWidth, this.maxWidth});

  /// Creates a copy of this theme but with the given fields replaced.
  MediaQueryVisibilityTheme copyWith({
    ValueGetter<double?>? minWidth,
    ValueGetter<double?>? maxWidth,
  }) {
    return MediaQueryVisibilityTheme(
      minWidth: minWidth == null ? this.minWidth : minWidth(),
      maxWidth: maxWidth == null ? this.maxWidth : maxWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MediaQueryVisibilityTheme &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth;
  }

  @override
  int get hashCode => Object.hash(minWidth, maxWidth);
}

/// A widget that conditionally displays children based on media query constraints.
class MediaQueryVisibility extends StatelessWidget {
  /// Minimum screen width to show [child].
  final double? minWidth;

  /// Maximum screen width to show [child].
  final double? maxWidth;

  /// Widget to display when width is within range.
  final Widget child;

  /// Widget to display when width is outside range.
  final Widget? alternateChild;

  /// Creates a [MediaQueryVisibility].
  const MediaQueryVisibility({
    super.key,
    this.minWidth,
    this.maxWidth,
    required this.child,
    this.alternateChild,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final compTheme =
        ComponentTheme.maybeOf<MediaQueryVisibilityTheme>(context);
    final size = mediaQuery.size.width;
    final minWidth = styleValue(
        widgetValue: this.minWidth,
        themeValue: compTheme?.minWidth,
        defaultValue: null);
    final maxWidth = styleValue(
        widgetValue: this.maxWidth,
        themeValue: compTheme?.maxWidth,
        defaultValue: null);
    if (minWidth != null && size < minWidth) {
      return SizedBox(child: alternateChild);
    }
    if (maxWidth != null && size > maxWidth) {
      return SizedBox(child: alternateChild);
    }
    return SizedBox(child: child);
  }
}
