import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in skeleton widgets
// ═══════════════════════════════════════════════════════════

class SkeletonThemeDefaults {
  const SkeletonThemeDefaults({
    this.duration = const Duration(seconds: 1),
    this.fromColor = const Color(0x0D171717),
    this.toColor = const Color(0x1A171717),
    this.enableSwitchAnimation = true,
  });

  /// From `ShadcnSkeletonizerConfigLayer`: `defaultValue: Duration(seconds: 1)`
  final Duration duration;

  /// From `ShadcnSkeletonizerConfigLayer`: `theme.colorScheme.primary.scaleAlpha(0.05)`
  final Color fromColor;

  /// From `ShadcnSkeletonizerConfigLayer`: `theme.colorScheme.primary.scaleAlpha(0.1)`
  final Color toColor;

  /// From `ShadcnSkeletonizerConfigLayer`: `defaultValue: true`
  final bool enableSwitchAnimation;
}
