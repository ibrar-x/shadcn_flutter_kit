import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class HiddenThemeDefaults {
  final Axis direction;
  final Duration duration;
  final Curve curve;
  final bool reverse;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  const HiddenThemeDefaults({
    this.direction = Axis.horizontal,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    this.reverse = false,
    this.keepCrossAxisSize = false,
    this.keepMainAxisSize = false,
  });
}
