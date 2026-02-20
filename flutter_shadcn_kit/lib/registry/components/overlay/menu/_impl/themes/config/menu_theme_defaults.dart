// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class MenuThemeConfigGlobalDefaults {
  final Object? itemPadding;
  final Object? subMenuOffset;

  const MenuThemeConfigGlobalDefaults({
    this.itemPadding = 'EdgeInsets.zero',
    this.subMenuOffset,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'itemPadding': itemPadding,
    'subMenuOffset': subMenuOffset,
  };
}

class MenuThemeConfigMenuPopupThemeDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? padding;
  final Object? fillColor;
  final Object? borderColor;
  final Object? borderRadius;

  const MenuThemeConfigMenuPopupThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
    'padding': padding,
    'fillColor': fillColor,
    'borderColor': borderColor,
    'borderRadius': borderRadius,
  };
}

class MenuThemeConfigMenubarThemeDefaults {
  final Object? border;
  final Object? subMenuOffset;
  final Object? padding;
  final Object? borderColor;
  final Object? backgroundColor;
  final Object? borderRadius;

  const MenuThemeConfigMenubarThemeDefaults({
    this.border,
    this.subMenuOffset,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'border': border,
    'subMenuOffset': subMenuOffset,
    'padding': padding,
    'borderColor': borderColor,
    'backgroundColor': backgroundColor,
    'borderRadius': borderRadius,
  };
}

const menuThemeTokensConfigGlobalDefaults = MenuThemeConfigGlobalDefaults();
const menuThemeTokensConfigMenuPopupThemeDefaults = MenuThemeConfigMenuPopupThemeDefaults();
const menuThemeTokensConfigMenubarThemeDefaults = MenuThemeConfigMenubarThemeDefaults();
