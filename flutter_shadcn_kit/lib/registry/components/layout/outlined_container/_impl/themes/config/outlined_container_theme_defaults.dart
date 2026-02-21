import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class OutlinedContainerThemeDefaults {
  final Color backgroundColor;
  final Color borderColor;

  /// Widget fallback: theme.borderRadiusLg
  final BorderRadiusGeometry borderRadius;
  final BorderStyle borderStyle;
  final double borderWidth;
  final List<BoxShadow> boxShadow;
  final EdgeInsetsGeometry padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const OutlinedContainerThemeDefaults({
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.borderColor = const Color(0xFFF5F5F5),
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.borderStyle = BorderStyle.solid,
    this.borderWidth = 1.0,
    this.boxShadow = const <BoxShadow>[],
    this.padding = EdgeInsets.zero,
    this.surfaceOpacity,
    this.surfaceBlur,
  });
}
