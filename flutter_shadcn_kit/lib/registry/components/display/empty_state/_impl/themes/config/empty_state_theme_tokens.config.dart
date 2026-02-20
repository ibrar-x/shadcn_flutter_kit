/// Global token override entrypoint for the empty_state component.
class EmptyStateThemeTokensConfig {
  const EmptyStateThemeTokensConfig._();

  /// Global component theme override for `EmptyStateTheme`.
  static Object? global;
  static const String globalType = 'EmptyStateTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'iconColor': null,
    'iconSize': null,
    'titleStyle': null,
    'descriptionStyle': null,
    'padding': null,
    'maxWidth': null,
    'cardBorderRadius': null,
    'cardFillColor': null,
    'iconContainerColor': null,
    'iconContainerBorderColor': null,
    'iconContainerBorderRadius': null,
    'iconContainerPadding': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
