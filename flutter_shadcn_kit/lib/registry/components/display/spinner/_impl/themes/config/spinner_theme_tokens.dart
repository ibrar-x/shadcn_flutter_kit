import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror SpinnerThemeDefaults
// ═══════════════════════════════════════════════════════════

class SpinnerThemeTokens {
  const SpinnerThemeTokens({
    this.color,
    this.size = 24.0,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final Color? color;
  final double size;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const spinnerThemeTokens = SpinnerThemeTokens();
