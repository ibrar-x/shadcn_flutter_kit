import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in keyboard shortcut widgets
// ═══════════════════════════════════════════════════════════

class KeyboardShortcutThemeDefaults {
  const KeyboardShortcutThemeDefaults({
    this.spacing = 2.0,
    this.keyPadding = const EdgeInsets.symmetric(
      horizontal: 6.0,
      vertical: 4.0,
    ),
    this.keyShadow,
  });

  /// From `KeyboardDisplay`: `defaultValue: 2 * theme.scaling`
  final double spacing;

  /// From `KeyboardKeyDisplay`: `EdgeInsets.symmetric(...0.75, ...0.5)`
  final EdgeInsetsGeometry keyPadding;

  /// From `KeyboardKeyDisplay`: `defaultValue: null`
  final List<BoxShadow>? keyShadow;
}
