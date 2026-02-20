/// Global token override entrypoint for the avatar component.
class AvatarThemeTokensConfig {
  const AvatarThemeTokensConfig._();

  /// Global component theme override for `AvatarTheme`.
  static Object? global;
  static const String globalType = 'AvatarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'size': null,
    'borderRadius': null,
    'backgroundColor': null,
    'badgeAlignment': null,
    'badgeGap': null,
    'textStyle': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
