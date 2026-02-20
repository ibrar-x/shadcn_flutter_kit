// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class HoverCardThemeConfigGlobalDefaults {
  final Object? debounce;
  final Object? wait;
  final Object? popoverAlignment;
  final Object? anchorAlignment;
  final Object? popoverOffset;
  final Object? behavior;

  const HoverCardThemeConfigGlobalDefaults({
    this.debounce = 'const Duration(milliseconds: 500)',
    this.wait = 'const Duration(milliseconds: 500)',
    this.popoverAlignment = 'Alignment.topCenter',
    this.anchorAlignment = 'Alignment.bottomCenter',
    this.popoverOffset = 'const Offset(0, 8)',
    this.behavior = 'HitTestBehavior.deferToChild',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'debounce': debounce,
    'wait': wait,
    'popoverAlignment': popoverAlignment,
    'anchorAlignment': anchorAlignment,
    'popoverOffset': popoverOffset,
    'behavior': behavior,
  };
}

const hoverCardThemeTokensConfigGlobalDefaults = HoverCardThemeConfigGlobalDefaults();
