import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in number ticker widgets
// ═══════════════════════════════════════════════════════════

class NumberTickerThemeDefaults {
  const NumberTickerThemeDefaults({
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.style,
  });

  /// From `NumberTicker`: `defaultValue: Duration(milliseconds: 500)`
  final Duration duration;

  /// From `NumberTicker`: `defaultValue: Curves.easeInOut`
  final Curve curve;

  /// From `NumberTicker`: `defaultValue: null`
  final TextStyle? style;
}
