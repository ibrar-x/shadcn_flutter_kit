import 'package:flutter/widgets.dart';

import '../../../stepper.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror StepperThemeDefaults
// ═══════════════════════════════════════════════════════════

class StepperThemeTokens {
  const StepperThemeTokens({
    this.direction = Axis.horizontal,
    this.size = StepSize.medium,
    this.variant = StepVariant.circle,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final Axis direction;
  final StepSize size;
  final StepVariant variant;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const stepperThemeTokens = StepperThemeTokens();
