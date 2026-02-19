part of '../../gooey_toast.dart';

/// Resolves effective corner roundness based on selected [style].
double _roundnessForShape(double roundness, GooeyToastShapeStyle style) {
  return switch (style) {
    GooeyToastShapeStyle.defaultShape => roundness,
    GooeyToastShapeStyle.soft => roundness * 1.25,
    GooeyToastShapeStyle.sharp => roundness * 0.75,
    GooeyToastShapeStyle.capsule => _kToastHeight / 2,
  };
}

/// Returns animation duration for each toast animation [style].
Duration _durationForAnimationStyle(GooeyToastAnimationStyle style) {
  return switch (style) {
    GooeyToastAnimationStyle.sileo => _kMorphDuration,
    GooeyToastAnimationStyle.smooth => const Duration(milliseconds: 760),
    GooeyToastAnimationStyle.snappy => const Duration(milliseconds: 420),
    GooeyToastAnimationStyle.bouncy => const Duration(milliseconds: 680),
  };
}

/// Returns animation curve for each toast animation [style].
Curve _curveForAnimationStyle(GooeyToastAnimationStyle style) {
  return switch (style) {
    GooeyToastAnimationStyle.sileo => Curves.easeInOutCubic,
    GooeyToastAnimationStyle.smooth => Curves.easeInOutQuart,
    GooeyToastAnimationStyle.snappy => Curves.easeOutCubic,
    GooeyToastAnimationStyle.bouncy => Curves.elasticOut,
  };
}

/// Resolves tone color for a toast [state], optionally from [theme] overrides.
Color _toneForState(GooeyToastState state, [GooeyToastTheme? theme]) {
  return switch (state) {
    GooeyToastState.success =>
      theme?.successTone ?? GooeyToastDefaults.successTone,
    GooeyToastState.loading =>
      theme?.loadingTone ?? GooeyToastDefaults.loadingTone,
    GooeyToastState.error => theme?.errorTone ?? GooeyToastDefaults.errorTone,
    GooeyToastState.warning =>
      theme?.warningTone ?? GooeyToastDefaults.warningTone,
    GooeyToastState.info => theme?.infoTone ?? GooeyToastDefaults.infoTone,
    GooeyToastState.action =>
      theme?.actionTone ?? GooeyToastDefaults.actionTone,
  };
}

/// Computes default swipe dismiss directions for [position] and [expandDirection].
Set<GooeyToastSwipeDirection> _defaultDismissDirections({
  required GooeyToastPosition position,
  required GooeyToastExpandDirection expandDirection,
}) {
  final directions = <GooeyToastSwipeDirection>{
    if (expandDirection == GooeyToastExpandDirection.bottom)
      GooeyToastSwipeDirection.up
    else
      GooeyToastSwipeDirection.down,
  };
  switch (position) {
    case GooeyToastPosition.left:
    case GooeyToastPosition.centerLeft:
      directions.add(GooeyToastSwipeDirection.left);
      break;
    case GooeyToastPosition.right:
    case GooeyToastPosition.centerRight:
      directions.add(GooeyToastSwipeDirection.right);
      break;
    case GooeyToastPosition.center:
      directions.addAll(const {
        GooeyToastSwipeDirection.left,
        GooeyToastSwipeDirection.right,
      });
      break;
  }
  return directions;
}
