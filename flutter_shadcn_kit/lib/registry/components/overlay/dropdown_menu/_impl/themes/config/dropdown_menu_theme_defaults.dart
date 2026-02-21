import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in dropdown menu widgets
// ═══════════════════════════════════════════════════════════

class DropdownMenuThemeDefaults {
  const DropdownMenuThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.minWidth = 192.0,
    this.subMenuOffset = const Offset(8.0, -4.0),
    this.direction = Axis.vertical,
  });

  /// From `MenuPopup`: `defaultValue: theme.surfaceOpacity`
  final double? surfaceOpacity;

  /// From `MenuPopup`: `defaultValue: theme.surfaceBlur`
  final double? surfaceBlur;

  /// From `_DropdownMenuState`: `BoxConstraints(minWidth: 192)`
  final double minWidth;

  /// From `_DropdownMenuState`: `subMenuOffset: const Offset(8, -4)`
  final Offset subMenuOffset;

  /// From `_DropdownMenuState`: `direction: Axis.vertical`
  final Axis direction;
}
