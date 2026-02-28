import 'package:flutter/widgets.dart';

import '../../../../../control/button/button.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror ChipThemeDefaults
// ═══════════════════════════════════════════════════════════

class ChipThemeTokens {
  const ChipThemeTokens({
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    this.style = ButtonVariance.secondary,
    this.buttonPadding = EdgeInsets.zero,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final EdgeInsetsGeometry padding;
  final AbstractButtonStyle style;
  final EdgeInsetsGeometry buttonPadding;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const chipThemeTokens = ChipThemeTokens();
