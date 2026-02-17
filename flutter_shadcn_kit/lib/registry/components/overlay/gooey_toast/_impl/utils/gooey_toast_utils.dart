part of '../../gooey_toast.dart';

double _roundnessForShape(double roundness, GooeyToastShapeStyle style) {
  return switch (style) {
    GooeyToastShapeStyle.defaultShape => roundness,
    GooeyToastShapeStyle.soft => roundness * 1.25,
    GooeyToastShapeStyle.sharp => roundness * 0.75,
    GooeyToastShapeStyle.capsule => _kToastHeight / 2,
  };
}

Duration _durationForAnimationStyle(GooeyToastAnimationStyle style) {
  return switch (style) {
    GooeyToastAnimationStyle.sileo => _kMorphDuration,
    GooeyToastAnimationStyle.smooth => const Duration(milliseconds: 760),
    GooeyToastAnimationStyle.snappy => const Duration(milliseconds: 420),
    GooeyToastAnimationStyle.bouncy => const Duration(milliseconds: 680),
  };
}

Curve _curveForAnimationStyle(GooeyToastAnimationStyle style) {
  return switch (style) {
    GooeyToastAnimationStyle.sileo => Curves.easeInOutCubic,
    GooeyToastAnimationStyle.smooth => Curves.easeInOutQuart,
    GooeyToastAnimationStyle.snappy => Curves.easeOutCubic,
    GooeyToastAnimationStyle.bouncy => Curves.elasticOut,
  };
}

Color _toneForState(GooeyToastState state, [GooeyToastTheme? theme]) {
  return switch (state) {
    GooeyToastState.success => theme?.successTone ?? const Color(0xFF63C65E),
    GooeyToastState.loading => theme?.loadingTone ?? const Color(0xFF8A8F98),
    GooeyToastState.error => theme?.errorTone ?? const Color(0xFFEF5E5E),
    GooeyToastState.warning => theme?.warningTone ?? const Color(0xFFEABB4B),
    GooeyToastState.info => theme?.infoTone ?? const Color(0xFF6EA8FF),
    GooeyToastState.action => theme?.actionTone ?? const Color(0xFF7A8DFF),
  };
}

Set<ToastSwipeDirection> _defaultDismissDirections({
  required GooeyToastPosition position,
  required GooeyToastExpandDirection expandDirection,
}) {
  final directions = <ToastSwipeDirection>{
    if (expandDirection == GooeyToastExpandDirection.bottom)
      ToastSwipeDirection.up
    else
      ToastSwipeDirection.down,
  };
  switch (position) {
    case GooeyToastPosition.left:
    case GooeyToastPosition.centerLeft:
      directions.add(ToastSwipeDirection.left);
      break;
    case GooeyToastPosition.right:
    case GooeyToastPosition.centerRight:
      directions.add(ToastSwipeDirection.right);
      break;
    case GooeyToastPosition.center:
      directions.addAll(const {
        ToastSwipeDirection.left,
        ToastSwipeDirection.right,
      });
      break;
  }
  return directions;
}
