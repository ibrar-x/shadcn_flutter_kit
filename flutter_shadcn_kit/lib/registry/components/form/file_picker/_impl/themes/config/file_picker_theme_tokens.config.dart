/// Global token override entrypoint for the file_picker component.
class FilePickerThemeTokensConfig {
  const FilePickerThemeTokensConfig._();

  /// Global component theme override for `FileUploadDropzoneTheme`.
  static Object? global;
  static const String globalType = 'FileUploadDropzoneTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': null,
    'borderRadius': null,
    'padding': null,
    'minHeight': null,
    'icon': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
