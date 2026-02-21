import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class CollapsibleThemeDefaults {
  const CollapsibleThemeDefaults({
    this.padding = 16.0,
    this.iconExpanded = Icons.unfold_less,
    this.iconCollapsed = Icons.unfold_more,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.iconGap = 16.0,
  });

  final double padding;
  final IconData iconExpanded;
  final IconData iconCollapsed;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double iconGap;
}
