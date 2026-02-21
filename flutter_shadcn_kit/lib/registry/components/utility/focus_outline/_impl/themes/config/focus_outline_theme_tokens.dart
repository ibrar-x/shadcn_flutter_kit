import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror FocusOutlineThemeDefaults
// ═══════════════════════════════════════════════════════════

class FocusOutlineThemeTokens {
  const FocusOutlineThemeTokens({
    this.align = 3.0,
    this.borderRadius,
    this.border = const Border.fromBorderSide(
      BorderSide(color: Color(0x80A1A1A1), width: 3.0),
    ),
    this.shape = BoxShape.rectangle,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final double align;
  final BorderRadiusGeometry? borderRadius;
  final Border border;
  final BoxShape shape;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const focusOutlineThemeTokens = FocusOutlineThemeTokens();
