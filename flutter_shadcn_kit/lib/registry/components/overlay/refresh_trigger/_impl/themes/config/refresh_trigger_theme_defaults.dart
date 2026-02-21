import 'package:flutter/widgets.dart';

import '../../../refresh_trigger.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in refresh trigger widgets
// ═══════════════════════════════════════════════════════════

class RefreshTriggerThemeDefaults {
  const RefreshTriggerThemeDefaults({
    this.minExtent = 75.0,
    this.maxExtent = 150.0,
    this.indicatorBuilder = RefreshTrigger.defaultIndicatorBuilder,
    this.curve = Curves.easeOutSine,
    this.completeDuration = const Duration(milliseconds: 500),
  });

  /// From `RefreshTriggerState`: `defaultValue: 75.0 * theme.scaling`
  final double minExtent;

  /// From `RefreshTriggerState`: `defaultValue: 150.0 * theme.scaling`
  final double maxExtent;

  /// From `RefreshTriggerState`: fallback to `RefreshTrigger.defaultIndicatorBuilder`
  final RefreshIndicatorBuilder indicatorBuilder;

  /// From `RefreshTriggerState`: `compTheme?.curve ?? Curves.easeOutSine`
  final Curve curve;

  /// From `RefreshTriggerState`: fallback to `Duration(milliseconds: 500)`
  final Duration completeDuration;
}
