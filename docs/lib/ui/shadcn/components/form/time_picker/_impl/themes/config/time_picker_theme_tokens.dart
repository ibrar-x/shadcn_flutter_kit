import 'package:flutter/widgets.dart';

import '../../../../form_field/form_field.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class TimePickerThemeTokens {
  const TimePickerThemeTokens({
    this.mode = PromptMode.dialog,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.use24HourFormat,
    this.showSeconds = false,
    this.dialogTitle,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final PromptMode mode;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final bool? use24HourFormat;
  final bool showSeconds;
  final Widget? dialogTitle;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const timePickerThemeTokens = TimePickerThemeTokens();
