/// Global token override entrypoint for the carousel component.
class CarouselThemeTokensConfig {
  const CarouselThemeTokensConfig._();

  /// Global component theme override for `CarouselTheme`.
  static Object? global;
  static const String globalType = 'CarouselTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'alignment': null,
    'direction': null,
    'wrap': null,
    'pauseOnHover': null,
    'autoplaySpeed': null,
    'draggable': null,
    'speed': null,
    'curve': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
