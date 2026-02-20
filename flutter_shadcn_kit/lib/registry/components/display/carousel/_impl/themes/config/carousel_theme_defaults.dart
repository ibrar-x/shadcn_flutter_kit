// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class CarouselThemeDefaults {
  final Object? alignment;
  final Object? direction;
  final Object? wrap;
  final Object? pauseOnHover;
  final Object? autoplaySpeed;
  final Object? draggable;
  final Object? speed;
  final Object? curve;

  const CarouselThemeDefaults({
    this.alignment = 'CarouselAlignment.center',
    this.direction = 'Axis.horizontal',
    this.wrap = true,
    this.pauseOnHover = true,
    this.autoplaySpeed,
    this.draggable = true,
    this.speed = 'const Duration(milliseconds: 200)',
    this.curve = 'Curves.easeInOut',
  });
}
