// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class SelectThemeConfigGlobalDefaults {
  final Object? popupConstraints;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? borderRadius;
  final Object? padding;
  final Object? disableHoverEffect;
  final Object? canUnselect;
  final Object? autoClosePopover;

  const SelectThemeConfigGlobalDefaults({
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

const selectThemeTokensConfigGlobalDefaults = SelectThemeConfigGlobalDefaults();
