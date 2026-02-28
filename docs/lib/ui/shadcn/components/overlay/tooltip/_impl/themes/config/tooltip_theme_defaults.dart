import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in tooltip widgets
// ═══════════════════════════════════════════════════════════

class TooltipThemeDefaults {
  const TooltipThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    this.backgroundColor = const Color(0xFF171717),
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  /// From `TooltipContainer`: `surfaceOpacity ?? compTheme?.surfaceOpacity`
  final double? surfaceOpacity;

  /// From `TooltipContainer`: `surfaceBlur ?? compTheme?.surfaceBlur`
  final double? surfaceBlur;

  /// From `TooltipContainer`: density-based symmetric padding fallback.
  final EdgeInsetsGeometry padding;

  /// From `TooltipContainer`: `defaultValue: theme.colorScheme.primary`
  final Color backgroundColor;

  /// From `TooltipContainer`: `defaultValue: BorderRadius.circular(theme.radiusSm)`
  final BorderRadiusGeometry borderRadius;
}
