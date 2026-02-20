// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class RefreshTriggerThemeConfigGlobalDefaults {
  final Object? minExtent;
  final Object? maxExtent;
  final Object? indicatorBuilder;
  final Object? curve;
  final Object? completeDuration;

  const RefreshTriggerThemeConfigGlobalDefaults({
    this.minExtent = '75.0 * theme.scaling',
    this.maxExtent = '150.0 * theme.scaling',
    this.indicatorBuilder = 'RefreshTrigger.defaultIndicatorBuilder',
    this.curve = 'Curves.easeOutSine',
    this.completeDuration = 'const Duration(milliseconds: 500)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'minExtent': minExtent,
    'maxExtent': maxExtent,
    'indicatorBuilder': indicatorBuilder,
    'curve': curve,
    'completeDuration': completeDuration,
  };
}

const refreshTriggerThemeTokensConfigGlobalDefaults = RefreshTriggerThemeConfigGlobalDefaults();
