// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class CarouselThemeTokens {
  final Object? alignment;
  final Object? direction;
  final Object? wrap;
  final Object? pauseOnHover;
  final Object? autoplaySpeed;
  final Object? draggable;
  final Object? speed;
  final Object? curve;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const CarouselThemeTokens({
    this.alignment,
    this.direction,
    this.wrap,
    this.pauseOnHover,
    this.autoplaySpeed,
    this.draggable,
    this.speed,
    this.curve,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const carouselThemeTokens = CarouselThemeTokens();
