import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in spinner widgets
// ═══════════════════════════════════════════════════════════

class SpinnerThemeDefaults {
  const SpinnerThemeDefaults({this.color, this.size = 24.0});

  /// From `Spinner.resolveColor`: `defaultValue: null`
  final Color? color;

  /// From `CircleSpinner`: `resolveSize(context, 24)`
  final double size;
}
