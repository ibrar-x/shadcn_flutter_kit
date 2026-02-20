/// Global token override entrypoint for the avatar component.
class AvatarThemeTokensConfig {
  const AvatarThemeTokensConfig._();

  /// Global component theme override for `AvatarTheme`.
  static Object? global;
  static const String globalType = 'AvatarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'size': 'theme.scaling * 40',
    'borderRadius': 'theme.radius * size',
    'backgroundColor': 'theme.colorScheme.muted',
    'badgeAlignment': 'AlignmentDirectional(offset, offset)',
    'badgeGap': 'theme.density.baseGap * theme.scaling * gapXs',
    'textStyle': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
