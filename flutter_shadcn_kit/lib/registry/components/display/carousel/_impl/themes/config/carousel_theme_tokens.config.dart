/// Global token override entrypoint for the carousel component.
class CarouselThemeTokensConfigGlobalDefaults {
  final Object? alignment;
  final Object? direction;
  final Object? wrap;
  final Object? pauseOnHover;
  final Object? autoplaySpeed;
  final Object? draggable;
  final Object? speed;
  final Object? curve;

  const CarouselThemeTokensConfigGlobalDefaults({
    this.alignment = 'CarouselAlignment.center',
    this.direction = 'Axis.horizontal',
    this.wrap = true,
    this.pauseOnHover = true,
    this.autoplaySpeed,
    this.draggable = true,
    this.speed = 'const Duration(milliseconds: 200)',
    this.curve = 'Curves.easeInOut',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'alignment': alignment,
    'direction': direction,
    'wrap': wrap,
    'pauseOnHover': pauseOnHover,
    'autoplaySpeed': autoplaySpeed,
    'draggable': draggable,
    'speed': speed,
    'curve': curve,
  };
}

class CarouselThemeTokensConfigGlobalTokens {
  const CarouselThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class CarouselThemeTokensConfig {
  const CarouselThemeTokensConfig._();

  /// Global component theme override for `CarouselTheme`.
  static Object? global;
  static const String globalType = 'CarouselTheme';
  static const CarouselThemeTokensConfigGlobalDefaults globalDefaults =
      CarouselThemeTokensConfigGlobalDefaults();
  static const CarouselThemeTokensConfigGlobalTokens globalTokens =
      CarouselThemeTokensConfigGlobalTokens();
}
