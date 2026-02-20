/// Global token override entrypoint for the accordion component.
class AccordionThemeTokensConfigGlobalDefaults {
  final Object? duration;
  final Object? curve;
  final Object? reverseCurve;
  final Object? padding;
  final Object? iconGap;
  final Object? dividerHeight;
  final Object? dividerColor;
  final Object? arrowIcon;
  final Object? arrowIconColor;

  const AccordionThemeTokensConfigGlobalDefaults({
    this.duration,
    this.curve,
    this.reverseCurve,
    this.padding,
    this.iconGap,
    this.dividerHeight,
    this.dividerColor,
    this.arrowIcon,
    this.arrowIconColor,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'duration': duration,
    'curve': curve,
    'reverseCurve': reverseCurve,
    'padding': padding,
    'iconGap': iconGap,
    'dividerHeight': dividerHeight,
    'dividerColor': dividerColor,
    'arrowIcon': arrowIcon,
    'arrowIconColor': arrowIconColor,
  };
}

class AccordionThemeTokensConfigGlobalTokens {
  const AccordionThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class AccordionThemeTokensConfig {
  const AccordionThemeTokensConfig._();

  /// Global component theme override for `AccordionTheme`.
  static Object? global;
  static const String globalType = 'AccordionTheme';
  static const AccordionThemeTokensConfigGlobalDefaults globalDefaults =
      AccordionThemeTokensConfigGlobalDefaults();
  static const AccordionThemeTokensConfigGlobalTokens globalTokens =
      AccordionThemeTokensConfigGlobalTokens();
}
