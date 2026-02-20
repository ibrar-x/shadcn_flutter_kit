/// Global token override entrypoint for the file_picker component.
class FilePickerThemeTokensConfig {
  const FilePickerThemeTokensConfig._();

  /// Global component theme override for `FileUploadDropzoneTheme`.
  static Object? global;
  static const String globalType = 'FileUploadDropzoneTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': 'theme.colorScheme.background',
    'borderRadius': null,
    'padding': null,
    'minHeight': '220 * scaling',
    'icon': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
