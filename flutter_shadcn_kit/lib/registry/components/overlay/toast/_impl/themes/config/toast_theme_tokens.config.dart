/// Global token override entrypoint for the toast component.
class ToastThemeTokensConfig {
  const ToastThemeTokensConfig._();

  /// Global component theme override for `ToastTheme`.
  static Object? global;
  static const String globalType = 'ToastTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'padding': null,
    'margin': null,
    'duration': null,
    'animationDuration': null,
    'animationCurve': null,
    'width': null,
    'borderRadius': null,
    'backgroundColor': null,
    'pauseOnHover': null,
    'dismissDirections': null,
    'dismissDragThreshold': null,
    'overlapStackWhenMultiple': null,
    'overlapStackOffset': null,
    'pauseAutoDismissWhenMultiple': null,
    'stackAnimationDuration': null,
    'stackAnimationCurve': null,
    'maxVisibleCount': null,
    'dismissWholeStackWhenMultiple': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
