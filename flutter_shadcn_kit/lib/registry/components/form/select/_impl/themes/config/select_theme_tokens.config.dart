/// Global token override entrypoint for the select component.
class SelectThemeTokensConfigGlobalDefaults {
  final Object? popupConstraints;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? borderRadius;
  final Object? padding;
  final Object? disableHoverEffect;
  final Object? canUnselect;
  final Object? autoClosePopover;

  const SelectThemeTokensConfigGlobalDefaults({
    this.popupConstraints,
    this.popoverAlignment = 'Alignment.topCenter',
    this.popoverAnchorAlignment,
    this.borderRadius,
    this.padding,
    this.disableHoverEffect = false,
    this.canUnselect = false,
    this.autoClosePopover = true,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'popupConstraints': popupConstraints,
    'popoverAlignment': popoverAlignment,
    'popoverAnchorAlignment': popoverAnchorAlignment,
    'borderRadius': borderRadius,
    'padding': padding,
    'disableHoverEffect': disableHoverEffect,
    'canUnselect': canUnselect,
    'autoClosePopover': autoClosePopover,
  };
}

class SelectThemeTokensConfigGlobalTokens {
  const SelectThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class SelectThemeTokensConfig {
  const SelectThemeTokensConfig._();

  /// Global component theme override for `SelectTheme`.
  static Object? global;
  static const String globalType = 'SelectTheme';
  static const SelectThemeTokensConfigGlobalDefaults globalDefaults =
      SelectThemeTokensConfigGlobalDefaults();
  static const SelectThemeTokensConfigGlobalTokens globalTokens =
      SelectThemeTokensConfigGlobalTokens();
}
