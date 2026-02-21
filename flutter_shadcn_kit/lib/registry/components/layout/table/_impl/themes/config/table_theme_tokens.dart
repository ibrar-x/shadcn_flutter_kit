import 'package:flutter/widgets.dart';

import '../../../table.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class TableThemeTokens {
  const TableThemeTokens({
    this.border,
    this.borderRadius,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.cellTheme,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final Color backgroundColor;
  final TableCellTheme? cellTheme;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const tableThemeTokens = TableThemeTokens();

class ResizableTableThemeTokens {
  const ResizableTableThemeTokens({
    this.tableTheme,
    this.resizerThickness = 4.0,
    this.resizerColor = const Color(0xFF171717),
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final TableTheme? tableTheme;
  final double resizerThickness;
  final Color resizerColor;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const resizableTableThemeTokens = ResizableTableThemeTokens();
