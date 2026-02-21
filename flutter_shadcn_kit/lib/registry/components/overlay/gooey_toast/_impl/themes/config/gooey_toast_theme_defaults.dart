import 'package:flutter/widgets.dart';

import '../../../gooey_toast.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class GooeyToastThemeDefaults {
  const GooeyToastThemeDefaults({
    this.width = GooeyToastDefaults.toastWidth,
    this.fill = GooeyToastDefaults.fill,
    this.roundness = GooeyToastDefaults.roundness,
    this.titleStyle,
    this.descriptionStyle,
    this.pauseOnHover = GooeyToastDefaults.pauseOnHover,
    this.swipeToDismiss = GooeyToastDefaults.swipeToDismiss,
    this.dismissDirections,
    this.dismissDragThreshold = GooeyToastDefaults.dismissDragThreshold,
    this.spacing = GooeyToastDefaults.spacing,
    this.overlapStackWhenMultiple,
    this.overlapStackOffset,
    this.pauseAutoDismissWhenMultiple,
    this.stackAnimationDuration,
    this.stackAnimationCurve,
    this.maxVisibleCount,
    this.dismissWholeStackWhenMultiple,
    this.animationStyle = GooeyToastDefaults.animationStyle,
    this.shapeStyle = GooeyToastDefaults.shapeStyle,
    this.enableGooeyBlur = GooeyToastDefaults.enableGooeyBlur,
    this.successTone = GooeyToastDefaults.successTone,
    this.loadingTone = GooeyToastDefaults.loadingTone,
    this.errorTone = GooeyToastDefaults.errorTone,
    this.warningTone = GooeyToastDefaults.warningTone,
    this.infoTone = GooeyToastDefaults.infoTone,
    this.actionTone = GooeyToastDefaults.actionTone,
  });

  final double width;
  final Color fill;
  final double roundness;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final bool pauseOnHover;
  final bool swipeToDismiss;
  final Set<GooeyToastSwipeDirection>? dismissDirections;
  final double dismissDragThreshold;
  final double spacing;
  final bool? overlapStackWhenMultiple;
  final double? overlapStackOffset;
  final bool? pauseAutoDismissWhenMultiple;
  final Duration? stackAnimationDuration;
  final Curve? stackAnimationCurve;
  final int? maxVisibleCount;
  final bool? dismissWholeStackWhenMultiple;
  final GooeyToastAnimationStyle animationStyle;
  final GooeyToastShapeStyle shapeStyle;
  final bool enableGooeyBlur;
  final Color successTone;
  final Color loadingTone;
  final Color errorTone;
  final Color warningTone;
  final Color infoTone;
  final Color actionTone;
}
