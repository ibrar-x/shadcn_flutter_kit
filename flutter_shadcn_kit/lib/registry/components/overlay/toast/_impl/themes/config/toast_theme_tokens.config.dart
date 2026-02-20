/// Global token override entrypoint for the toast component.
class ToastThemeTokensConfigGlobalDefaults {
  final Object? padding;
  final Object? margin;
  final Object? duration;
  final Object? animationDuration;
  final Object? animationCurve;
  final Object? width;
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? pauseOnHover;
  final Object? dismissDirections;
  final Object? dismissDragThreshold;
  final Object? overlapStackWhenMultiple;
  final Object? overlapStackOffset;
  final Object? pauseAutoDismissWhenMultiple;
  final Object? stackAnimationDuration;
  final Object? stackAnimationCurve;
  final Object? maxVisibleCount;
  final Object? dismissWholeStackWhenMultiple;

  const ToastThemeTokensConfigGlobalDefaults({
    this.padding,
    this.margin,
    this.duration,
    this.animationDuration,
    this.animationCurve,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.pauseOnHover,
    this.dismissDirections,
    this.dismissDragThreshold,
    this.overlapStackWhenMultiple,
    this.overlapStackOffset,
    this.pauseAutoDismissWhenMultiple,
    this.stackAnimationDuration,
    this.stackAnimationCurve,
    this.maxVisibleCount,
    this.dismissWholeStackWhenMultiple,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'padding': padding,
    'margin': margin,
    'duration': duration,
    'animationDuration': animationDuration,
    'animationCurve': animationCurve,
    'width': width,
    'borderRadius': borderRadius,
    'backgroundColor': backgroundColor,
    'pauseOnHover': pauseOnHover,
    'dismissDirections': dismissDirections,
    'dismissDragThreshold': dismissDragThreshold,
    'overlapStackWhenMultiple': overlapStackWhenMultiple,
    'overlapStackOffset': overlapStackOffset,
    'pauseAutoDismissWhenMultiple': pauseAutoDismissWhenMultiple,
    'stackAnimationDuration': stackAnimationDuration,
    'stackAnimationCurve': stackAnimationCurve,
    'maxVisibleCount': maxVisibleCount,
    'dismissWholeStackWhenMultiple': dismissWholeStackWhenMultiple,
  };
}

class ToastThemeTokensConfigGlobalTokens {
  const ToastThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ToastThemeTokensConfig {
  const ToastThemeTokensConfig._();

  /// Global component theme override for `ToastTheme`.
  static Object? global;
  static const String globalType = 'ToastTheme';
  static const ToastThemeTokensConfigGlobalDefaults globalDefaults =
      ToastThemeTokensConfigGlobalDefaults();
  static const ToastThemeTokensConfigGlobalTokens globalTokens =
      ToastThemeTokensConfigGlobalTokens();
}
