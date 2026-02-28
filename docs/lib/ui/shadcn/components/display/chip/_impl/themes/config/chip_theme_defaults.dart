import 'package:flutter/widgets.dart';

import '../../../../../control/button/button.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in chip widgets
// ═══════════════════════════════════════════════════════════

class ChipThemeDefaults {
  const ChipThemeDefaults({
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    this.style = ButtonVariance.secondary,
    this.buttonPadding = EdgeInsets.zero,
  });

  /// From `Chip`: `EdgeInsets.symmetric(horizontal: ..., vertical: ...)`
  final EdgeInsetsGeometry padding;

  /// From `Chip`: `style ?? componentTheme?.style ?? ButtonVariance.secondary`
  final AbstractButtonStyle style;

  /// From `ChipButton`: `defaultValue: EdgeInsets.zero`
  final EdgeInsetsGeometry buttonPadding;
}
