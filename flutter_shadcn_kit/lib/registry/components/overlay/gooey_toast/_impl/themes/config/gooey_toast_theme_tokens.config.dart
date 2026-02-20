/// Global token override entrypoint for the gooey_toast component.
class GooeyToastThemeTokensConfig {
  const GooeyToastThemeTokensConfig._();

  /// Global component theme override for `GooeyToastTheme`.
  static Object? global;
  static const String globalType = 'GooeyToastTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'width': null,
    'fill': null,
    'roundness': null,
    'titleStyle': null,
    'descriptionStyle': null,
    'pauseOnHover': null,
    'swipeToDismiss': null,
    'dismissDirections': null,
    'dismissDragThreshold': null,
    'spacing': null,
    'overlapStackWhenMultiple': null,
    'overlapStackOffset': null,
    'pauseAutoDismissWhenMultiple': null,
    'stackAnimationDuration': null,
    'stackAnimationCurve': null,
    'maxVisibleCount': null,
    'dismissWholeStackWhenMultiple': null,
    'animationStyle': null,
    'shapeStyle': null,
    'enableGooeyBlur': null,
    'successTone': null,
    'loadingTone': null,
    'errorTone': null,
    'warningTone': null,
    'infoTone': null,
    'actionTone': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
