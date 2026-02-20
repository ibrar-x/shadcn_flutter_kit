// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class CarouselThemeConfigGlobalDefaults {
  final Object? alignment;
  final Object? direction;
  final Object? wrap;
  final Object? pauseOnHover;
  final Object? autoplaySpeed;
  final Object? draggable;
  final Object? speed;
  final Object? curve;

  const CarouselThemeConfigGlobalDefaults({
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

const carouselThemeTokensConfigGlobalDefaults = CarouselThemeConfigGlobalDefaults();
