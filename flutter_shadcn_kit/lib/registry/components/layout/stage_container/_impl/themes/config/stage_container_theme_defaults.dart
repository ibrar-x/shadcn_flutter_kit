import 'package:flutter/widgets.dart';

import '../../../stage_container.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in stage container widgets
// ═══════════════════════════════════════════════════════════

class StageContainerThemeDefaults {
  const StageContainerThemeDefaults({
    this.breakpoint = StageBreakpoint.defaultBreakpoints,
    this.padding = const EdgeInsets.symmetric(horizontal: 72.0),
  });

  /// From `StageContainer`: `breakpoint = StageBreakpoint.defaultBreakpoints`
  final StageBreakpoint breakpoint;

  /// From `StageContainer`: `EdgeInsets.symmetric(horizontal: baseContainerPadding * 4.5)`
  final EdgeInsets padding;
}
