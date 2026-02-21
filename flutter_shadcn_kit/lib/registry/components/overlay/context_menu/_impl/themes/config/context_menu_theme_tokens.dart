import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror ContextMenuThemeDefaults
// ═══════════════════════════════════════════════════════════

class ContextMenuThemeTokens {
  const ContextMenuThemeTokens({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.direction = Axis.vertical,
    this.popupAnimationDuration = const Duration(milliseconds: 100),
    this.maxWidth = 192.0,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Axis direction;
  final Duration popupAnimationDuration;
  final double maxWidth;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const contextMenuThemeTokens = ContextMenuThemeTokens();
