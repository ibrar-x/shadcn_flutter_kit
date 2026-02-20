/// Global token override entrypoint for the empty_state component.
class EmptyStateThemeTokensConfigGlobalDefaults {
  final Object? iconColor;
  final Object? iconSize;
  final Object? titleStyle;
  final Object? descriptionStyle;
  final Object? padding;
  final Object? maxWidth;
  final Object? cardBorderRadius;
  final Object? cardFillColor;
  final Object? iconContainerColor;
  final Object? iconContainerBorderColor;
  final Object? iconContainerBorderRadius;
  final Object? iconContainerPadding;

  const EmptyStateThemeTokensConfigGlobalDefaults({
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
    this.maxWidth,
    this.cardBorderRadius,
    this.cardFillColor,
    this.iconContainerColor,
    this.iconContainerBorderColor,
    this.iconContainerBorderRadius,
    this.iconContainerPadding,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'iconColor': iconColor,
    'iconSize': iconSize,
    'titleStyle': titleStyle,
    'descriptionStyle': descriptionStyle,
    'padding': padding,
    'maxWidth': maxWidth,
    'cardBorderRadius': cardBorderRadius,
    'cardFillColor': cardFillColor,
    'iconContainerColor': iconContainerColor,
    'iconContainerBorderColor': iconContainerBorderColor,
    'iconContainerBorderRadius': iconContainerBorderRadius,
    'iconContainerPadding': iconContainerPadding,
  };
}

class EmptyStateThemeTokensConfigGlobalTokens {
  const EmptyStateThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class EmptyStateThemeTokensConfig {
  const EmptyStateThemeTokensConfig._();

  /// Global component theme override for `EmptyStateTheme`.
  static Object? global;
  static const String globalType = 'EmptyStateTheme';
  static const EmptyStateThemeTokensConfigGlobalDefaults globalDefaults =
      EmptyStateThemeTokensConfigGlobalDefaults();
  static const EmptyStateThemeTokensConfigGlobalTokens globalTokens =
      EmptyStateThemeTokensConfigGlobalTokens();
}
