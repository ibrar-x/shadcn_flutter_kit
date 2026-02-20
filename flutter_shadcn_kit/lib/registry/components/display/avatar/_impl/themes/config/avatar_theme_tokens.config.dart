/// Global token override entrypoint for the avatar component.
class AvatarThemeTokensConfigGlobalDefaults {
  final Object? size;
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? badgeAlignment;
  final Object? badgeGap;
  final Object? textStyle;

  const AvatarThemeTokensConfigGlobalDefaults({
    this.size = 'theme.scaling * 40',
    this.borderRadius = 'theme.radius * size',
    this.backgroundColor = 'theme.colorScheme.muted',
    this.badgeAlignment = 'AlignmentDirectional(offset, offset)',
    this.badgeGap = 'theme.density.baseGap * theme.scaling * gapXs',
    this.textStyle,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'size': size,
    'borderRadius': borderRadius,
    'backgroundColor': backgroundColor,
    'badgeAlignment': badgeAlignment,
    'badgeGap': badgeGap,
    'textStyle': textStyle,
  };
}

class AvatarThemeTokensConfigGlobalTokens {
  const AvatarThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class AvatarThemeTokensConfig {
  const AvatarThemeTokensConfig._();

  /// Global component theme override for `AvatarTheme`.
  static Object? global;
  static const String globalType = 'AvatarTheme';
  static const AvatarThemeTokensConfigGlobalDefaults globalDefaults =
      AvatarThemeTokensConfigGlobalDefaults();
  static const AvatarThemeTokensConfigGlobalTokens globalTokens =
      AvatarThemeTokensConfigGlobalTokens();
}
