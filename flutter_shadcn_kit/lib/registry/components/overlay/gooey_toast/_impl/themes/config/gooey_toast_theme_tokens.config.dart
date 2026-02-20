/// Global token override entrypoint for the gooey_toast component.
class GooeyToastThemeTokensConfigGlobalDefaults {
  final Object? width;
  final Object? fill;
  final Object? roundness;
  final Object? titleStyle;
  final Object? descriptionStyle;
  final Object? pauseOnHover;
  final Object? swipeToDismiss;
  final Object? dismissDirections;
  final Object? dismissDragThreshold;
  final Object? spacing;
  final Object? overlapStackWhenMultiple;
  final Object? overlapStackOffset;
  final Object? pauseAutoDismissWhenMultiple;
  final Object? stackAnimationDuration;
  final Object? stackAnimationCurve;
  final Object? maxVisibleCount;
  final Object? dismissWholeStackWhenMultiple;
  final Object? animationStyle;
  final Object? shapeStyle;
  final Object? enableGooeyBlur;
  final Object? successTone;
  final Object? loadingTone;
  final Object? errorTone;
  final Object? warningTone;
  final Object? infoTone;
  final Object? actionTone;

  const GooeyToastThemeTokensConfigGlobalDefaults({
    this.width,
    this.fill = 'GooeyToastDefaults.fill',
    this.roundness,
    this.titleStyle,
    this.descriptionStyle,
    this.pauseOnHover,
    this.swipeToDismiss,
    this.dismissDirections,
    this.dismissDragThreshold,
    this.spacing,
    this.overlapStackWhenMultiple,
    this.overlapStackOffset,
    this.pauseAutoDismissWhenMultiple,
    this.stackAnimationDuration,
    this.stackAnimationCurve,
    this.maxVisibleCount,
    this.dismissWholeStackWhenMultiple,
    this.animationStyle,
    this.shapeStyle,
    this.enableGooeyBlur,
    this.successTone,
    this.loadingTone,
    this.errorTone,
    this.warningTone,
    this.infoTone,
    this.actionTone,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'width': width,
    'fill': fill,
    'roundness': roundness,
    'titleStyle': titleStyle,
    'descriptionStyle': descriptionStyle,
    'pauseOnHover': pauseOnHover,
    'swipeToDismiss': swipeToDismiss,
    'dismissDirections': dismissDirections,
    'dismissDragThreshold': dismissDragThreshold,
    'spacing': spacing,
    'overlapStackWhenMultiple': overlapStackWhenMultiple,
    'overlapStackOffset': overlapStackOffset,
    'pauseAutoDismissWhenMultiple': pauseAutoDismissWhenMultiple,
    'stackAnimationDuration': stackAnimationDuration,
    'stackAnimationCurve': stackAnimationCurve,
    'maxVisibleCount': maxVisibleCount,
    'dismissWholeStackWhenMultiple': dismissWholeStackWhenMultiple,
    'animationStyle': animationStyle,
    'shapeStyle': shapeStyle,
    'enableGooeyBlur': enableGooeyBlur,
    'successTone': successTone,
    'loadingTone': loadingTone,
    'errorTone': errorTone,
    'warningTone': warningTone,
    'infoTone': infoTone,
    'actionTone': actionTone,
  };
}

class GooeyToastThemeTokensConfigGlobalTokens {
  const GooeyToastThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class GooeyToastThemeTokensConfig {
  const GooeyToastThemeTokensConfig._();

  /// Global component theme override for `GooeyToastTheme`.
  static Object? global;
  static const String globalType = 'GooeyToastTheme';
  static const GooeyToastThemeTokensConfigGlobalDefaults globalDefaults =
      GooeyToastThemeTokensConfigGlobalDefaults();
  static const GooeyToastThemeTokensConfigGlobalTokens globalTokens =
      GooeyToastThemeTokensConfigGlobalTokens();
}
