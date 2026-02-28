import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class MenuPopupThemeTokens {
  const MenuPopupThemeTokens({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final double? surfaceOpacity;
  final double? surfaceBlur;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const menuPopupThemeTokens = MenuPopupThemeTokens();
