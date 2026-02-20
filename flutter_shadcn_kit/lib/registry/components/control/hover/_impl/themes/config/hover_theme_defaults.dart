// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class HoverThemeConfigGlobalDefaults {
  final Object? debounceDuration;
  final Object? hitTestBehavior;
  final Object? waitDuration;
  final Object? minDuration;
  final Object? showDuration;

  const HoverThemeConfigGlobalDefaults({
    this.debounceDuration = 'const Duration(milliseconds: 100)',
    this.hitTestBehavior = 'HitTestBehavior.deferToChild',
    this.waitDuration = 'const Duration(milliseconds: 500)',
    this.minDuration = 'const Duration(milliseconds: 0)',
    this.showDuration = 'const Duration(milliseconds: 200)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'debounceDuration': debounceDuration,
    'hitTestBehavior': hitTestBehavior,
    'waitDuration': waitDuration,
    'minDuration': minDuration,
    'showDuration': showDuration,
  };
}

const hoverThemeTokensConfigGlobalDefaults = HoverThemeConfigGlobalDefaults();
