import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror ProgressThemeDefaults
// ═══════════════════════════════════════════════════════════

class ProgressThemeTokens {
  const ProgressThemeTokens({
    this.color,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.minHeight = 8.0,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final Color? color;
  final Color? backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final double minHeight;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const progressThemeTokens = ProgressThemeTokens();
