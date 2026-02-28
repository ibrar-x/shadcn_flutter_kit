part of '../../file_input.dart';

/// Internal data class for [FileIconProvider].
///
/// Stores the configuration for file icon provision and provides
/// a method to build icons based on file extensions.
class FileIconProviderData {
  /// Optional builder function for icons.
  final FileIconBuilder? builder;

  /// Optional map of extension to icon widgets.
  final Map<String, Widget>? icons;

  /// Creates internal data for file icon provision.
  const FileIconProviderData._({this.builder, this.icons});

  /// Builds an icon for the given file extension.
  ///
  /// Uses the builder if provided, otherwise checks the icons map,
  /// and falls back to the default icon builder.
  Widget buildIcon(String extension) {
    if (builder != null) return builder!(extension);
    final icon = icons?[extension];
    if (icon != null) return icon;
    return _buildFileIcon(extension);
  }
}
