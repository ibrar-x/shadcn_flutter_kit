import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../shared/icons/radix_icons.dart';
import '../../../shared/primitives/outlined_container.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/geometry_extensions.dart';
import '../../control/button/button.dart';
import '../../display/linear_progress_indicator/linear_progress_indicator.dart';

part '_impl/core/file_dropzone.dart';
part '_impl/core/file_item.dart';

// const fileByteUnits = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
// const fileBitUnits = ['Bi', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
// String formatFileSize(int bytes, List<String> units) {
//   if (bytes <= 0) return '0 ${units[0]}';
//   final
// }

/// A file picker widget for selecting and managing file uploads.
///
/// **Work in Progress** - This component is under active development and
/// may have incomplete functionality or undergo API changes.
///
/// Provides a comprehensive interface for file selection with drag-and-drop
/// support, file management capabilities, and customizable presentation.
/// Displays selected files as a list of manageable items with options
/// for adding, removing, and organizing uploaded files.
///
/// Supports hot drop functionality for drag-and-drop file uploads and
/// provides visual feedback during file operations. The picker can be
/// customized with titles, subtitles, and custom file item presentations.
///
/// Example:
/// ```dart
/// FilePicker(
///   title: Text('Upload Documents'),
///   subtitle: Text('Drag files here or click to browse'),
///   hotDropEnabled: true,
///   onAdd: () => _selectFiles(),
///   children: selectedFiles.map((file) =>
///     FileItem(file: file, onRemove: () => _removeFile(file))
///   ).toList(),
/// )
/// ```
class FilePicker extends StatelessWidget {
  /// Title widget displayed above the file picker.
  final Widget? title;

  /// Subtitle widget displayed below the title.
  final Widget? subtitle;

  /// Whether drag-and-drop functionality is enabled.
  final bool hotDropEnabled;

  /// Whether a drag-and-drop operation is currently in progress.
  final bool hotDropping;

  /// List of file item widgets to display.
  final List<Widget> children;

  /// Optional widget shown above the dropzone actions.
  final Widget? hint;

  /// Label for the add/browse button.
  final String? actionLabel;

  /// Optional dropzone icon widget.
  final Widget? icon;

  /// Optional background color for the dropzone container.
  final Color? backgroundColor;

  /// Optional border radius for the dropzone container.
  final BorderRadiusGeometry? borderRadius;

  /// Optional padding inside the dropzone container.
  final EdgeInsetsGeometry? padding;

  /// Optional minimum height for the dropzone container.
  final double? minHeight;

  /// Callback when the add file button is pressed.
  final VoidCallback? onAdd;

  /// Creates a [FilePicker].
  ///
  /// Parameters:
  /// - [title] (`Widget?`, optional): Title displayed above picker.
  /// - [subtitle] (`Widget?`, optional): Subtitle below title.
  /// - [hotDropEnabled] (`bool`, default: `false`): Enable drag-and-drop.
  /// - [hotDropping] (`bool`, default: `false`): Currently dropping files.
  /// - [onAdd] (`VoidCallback?`, optional): Called when add button pressed.
  /// - [children] (`List<Widget>`, required): File item widgets.
  const FilePicker({
    super.key,
    this.title,
    this.subtitle,
    this.hotDropEnabled = false,
    this.hotDropping = false,
    this.onAdd,
    this.hint,
    this.actionLabel,
    this.icon,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null || subtitle != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                DefaultTextStyle.merge(
                  style: theme.typography.large.merge(
                    theme.typography.semiBold,
                  ),
                  child: title!,
                ),
              if (subtitle != null) Gap(6 * scaling),
              if (subtitle != null)
                DefaultTextStyle.merge(
                  style: theme.typography.small.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                  child: subtitle!,
                ),
              Gap(16 * scaling),
            ],
          ),
        FileDropzone(
          hotDropEnabled: hotDropEnabled,
          hotDropping: hotDropping,
          hint: hint,
          icon: icon,
          actionLabel: actionLabel,
          onPressed: onAdd,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          padding: padding,
          minHeight: minHeight,
        ),
        if (children.isNotEmpty) Gap(16 * scaling),
        if (children.isNotEmpty)
          Column(
            children: [
              for (final child in children) ...[child, Gap(12 * scaling)],
            ],
          ),
      ],
    );
  }
}

String formatFileSize(int bytes) {
  if (bytes <= 0) return '0 B';
  const units = ['B', 'KB', 'MB', 'GB', 'TB'];
  var size = bytes.toDouble();
  var unitIndex = 0;
  while (size >= 1024 && unitIndex < units.length - 1) {
    size /= 1024;
    unitIndex += 1;
  }
  final value = size < 10 ? size.toStringAsFixed(1) : size.toStringAsFixed(0);
  return '$value ${units[unitIndex]}';
}
