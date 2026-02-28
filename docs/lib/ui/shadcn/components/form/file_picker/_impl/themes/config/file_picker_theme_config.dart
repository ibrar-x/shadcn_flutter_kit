// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../file_picker.dart';
import 'file_picker_theme_defaults.dart';
import 'file_picker_theme_tokens.dart';

class FilePickerThemeConfig {
  const FilePickerThemeConfig._();

  static const FileUploadDropzoneTheme? fileUploadDropzoneTheme = null;
  static const String fileUploadDropzoneThemeType = 'FileUploadDropzoneTheme';
  static const FileUploadDropzoneThemeDefaults fileUploadDropzoneThemeDefaults =
      FileUploadDropzoneThemeDefaults();
  static const FileUploadDropzoneThemeTokens
  fileUploadDropzoneThemeTokenConfig = fileUploadDropzoneThemeTokens;

  static T? resolve<T extends FileUploadDropzoneTheme>() {
    if (T == FileUploadDropzoneTheme) {
      return fileUploadDropzoneTheme as T?;
    }
    return null;
  }
}
