import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror KeyboardShortcutThemeDefaults
// ═══════════════════════════════════════════════════════════

class KeyboardShortcutThemeTokens {
  const KeyboardShortcutThemeTokens({
    this.spacing = 2.0,
    this.keyPadding = const EdgeInsets.symmetric(
      horizontal: 6.0,
      vertical: 4.0,
    ),
    this.keyShadow,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final double spacing;
  final EdgeInsetsGeometry keyPadding;
  final List<BoxShadow>? keyShadow;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const keyboardShortcutThemeTokens = KeyboardShortcutThemeTokens();
