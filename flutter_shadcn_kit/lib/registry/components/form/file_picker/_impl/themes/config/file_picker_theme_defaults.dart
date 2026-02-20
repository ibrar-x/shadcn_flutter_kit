// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class FilePickerThemeConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? borderRadius;
  final Object? padding;
  final Object? minHeight;
  final Object? icon;

  const FilePickerThemeConfigGlobalDefaults({
    this.backgroundColor = 'theme.colorScheme.background',
    this.borderRadius,
    this.padding,
    this.minHeight = '220 * scaling',
    this.icon,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'backgroundColor': backgroundColor,
    'borderRadius': borderRadius,
    'padding': padding,
    'minHeight': minHeight,
    'icon': icon,
  };
}

const filePickerThemeTokensConfigGlobalDefaults = FilePickerThemeConfigGlobalDefaults();
