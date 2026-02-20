// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'file_picker_theme_defaults.dart';
import 'file_picker_theme_tokens.dart';

class FilePickerThemeConfig {
  const FilePickerThemeConfig._();

  static const Object? fileUploadDropzoneTheme = null;
  static const String fileUploadDropzoneThemeType = 'FileUploadDropzoneTheme';
  static const FileUploadDropzoneThemeDefaults fileUploadDropzoneThemeDefaults = FileUploadDropzoneThemeDefaults();
  static const FileUploadDropzoneThemeTokens fileUploadDropzoneThemeTokenConfig = fileUploadDropzoneThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == fileUploadDropzoneThemeType) {
      return fileUploadDropzoneTheme as T?;
    }
    return null;
  }
}
