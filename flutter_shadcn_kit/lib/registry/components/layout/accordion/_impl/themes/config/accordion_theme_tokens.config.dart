/// Global token override entrypoint for the accordion component.
class AccordionThemeTokensConfig {
  const AccordionThemeTokensConfig._();

  /// Global component theme override for `AccordionTheme`.
  static Object? global;
  static const String globalType = 'AccordionTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'duration': null,
    'curve': null,
    'reverseCurve': null,
    'padding': null,
    'iconGap': null,
    'dividerHeight': null,
    'dividerColor': null,
    'arrowIcon': null,
    'arrowIconColor': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
