/// Global token override entrypoint for the file_picker component.
class FilePickerThemeTokensConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? borderRadius;
  final Object? padding;
  final Object? minHeight;
  final Object? icon;

  const FilePickerThemeTokensConfigGlobalDefaults({
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

class FilePickerThemeTokensConfigGlobalTokens {
  const FilePickerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class FilePickerThemeTokensConfig {
  const FilePickerThemeTokensConfig._();

  /// Global component theme override for `FileUploadDropzoneTheme`.
  static Object? global;
  static const String globalType = 'FileUploadDropzoneTheme';
  static const FilePickerThemeTokensConfigGlobalDefaults globalDefaults =
      FilePickerThemeTokensConfigGlobalDefaults();
  static const FilePickerThemeTokensConfigGlobalTokens globalTokens =
      FilePickerThemeTokensConfigGlobalTokens();
}
