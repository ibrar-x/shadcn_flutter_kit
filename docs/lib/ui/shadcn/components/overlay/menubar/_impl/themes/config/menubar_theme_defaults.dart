import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class MenubarThemeDefaults {
  const MenubarThemeDefaults({
    this.border = true,
    this.subMenuOffset = const Offset(-4.0, 8.0),
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });

  final bool border;
  final Offset subMenuOffset;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
}
