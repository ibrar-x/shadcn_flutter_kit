/// Global token override entrypoint for the carousel component.
class CarouselThemeTokensConfig {
  const CarouselThemeTokensConfig._();

  /// Global component theme override for `CarouselTheme`.
  static Object? global;
  static const String globalType = 'CarouselTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'alignment': 'CarouselAlignment.center',
    'direction': 'Axis.horizontal',
    'wrap': true,
    'pauseOnHover': true,
    'autoplaySpeed': null,
    'draggable': true,
    'speed': 'const Duration(milliseconds: 200)',
    'curve': 'Curves.easeInOut',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
