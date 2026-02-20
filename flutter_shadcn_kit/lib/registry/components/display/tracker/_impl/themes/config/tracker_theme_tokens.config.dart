/// Global token override entrypoint for the tracker component.
class TrackerThemeTokensConfigGlobalDefaults {
  final Object? radius;
  final Object? gap;
  final Object? itemHeight;

  const TrackerThemeTokensConfigGlobalDefaults({
    this.radius,
    this.gap,
    this.itemHeight,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'radius': radius,
    'gap': gap,
    'itemHeight': itemHeight,
  };
}

class TrackerThemeTokensConfigGlobalTokens {
  const TrackerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TrackerThemeTokensConfig {
  const TrackerThemeTokensConfig._();

  /// Global component theme override for `TrackerTheme`.
  static Object? global;
  static const String globalType = 'TrackerTheme';
  static const TrackerThemeTokensConfigGlobalDefaults globalDefaults =
      TrackerThemeTokensConfigGlobalDefaults();
  static const TrackerThemeTokensConfigGlobalTokens globalTokens =
      TrackerThemeTokensConfigGlobalTokens();
}
