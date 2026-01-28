part of '../../file_picker.dart';

/// A widget representing a single file item in a file picker or upload list.
///
/// [FileItem] displays information about a selected or uploaded file including
/// name, size, type, and optional thumbnail. It provides interactive controls
/// for file management such as remove, retry, download, and preview actions.
///
/// Supports displaying upload progress for files currently being uploaded and
/// provides visual feedback through thumbnails and status indicators.
///
/// Example:
/// ```dart
/// FileItem(
///   fileName: Text('document.pdf'),
///   fileSize: Text('1.2 MB'),
///   fileType: Text('PDF'),
///   uploadProgress: 0.75, // 75% uploaded
///   onRemove: () => removeFile(),
///   thumbnail: Icon(Icons.picture_as_pdf),
/// )
/// ```
class FileItem extends StatelessWidget {
  /// Optional platform file backing this item.
  final PlatformFile? file;

  /// Upload progress from 0.0 to 1.0, or null if not uploading.
  final double? uploadProgress;

  /// Called when the remove button is pressed.
  final VoidCallback? onRemove;

  /// Called when the retry button is pressed (for failed uploads).
  final VoidCallback? onRetry;

  /// Called when the download button is pressed.
  final VoidCallback? onDownload;

  /// Optional thumbnail widget for the file.
  final Widget? thumbnail;

  /// Called when the preview button is pressed.
  final VoidCallback? onPreview;

  /// Widget displaying the file name.
  final Widget fileName;

  /// Optional widget displaying the file size.
  final Widget? fileSize;

  /// Optional widget displaying the file type/format.
  final Widget? fileType;

  /// Creates a [FileItem].
  const FileItem({
    super.key,
    this.file,
    this.uploadProgress,
    this.onRemove,
    this.onRetry,
    this.onDownload,
    this.thumbnail,
    this.onPreview,
    required this.fileName,
    this.fileSize,
    this.fileType,
  });

  /// Creates a [FileItem] from a [PlatformFile].
  factory FileItem.platform({
    Key? key,
    required PlatformFile file,
    double? uploadProgress,
    VoidCallback? onRemove,
    VoidCallback? onRetry,
    VoidCallback? onDownload,
    VoidCallback? onPreview,
    Widget? thumbnail,
  }) {
    return FileItem(
      key: key,
      file: file,
      uploadProgress: uploadProgress,
      onRemove: onRemove,
      onRetry: onRetry,
      onDownload: onDownload,
      onPreview: onPreview,
      thumbnail: thumbnail,
      fileName: Text(file.name),
      fileSize: file.size > 0 ? Text(formatFileSize(file.size)) : null,
      fileType: file.extension != null
          ? Text(file.extension!.toUpperCase())
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final resolvedThumbnail =
        thumbnail ??
        Icon(
          RadixIcons.file,
          color: theme.colorScheme.mutedForeground,
          size: 20 * scaling,
        );

    final actions = <Widget>[];
    if (onPreview != null) {
      actions.add(
        IconButton.ghost(
          icon: Icon(RadixIcons.eyeOpen, size: 16 * scaling),
          onPressed: onPreview,
        ),
      );
    }
    if (onDownload != null) {
      actions.add(
        IconButton.ghost(
          icon: Icon(RadixIcons.download, size: 16 * scaling),
          onPressed: onDownload,
        ),
      );
    }
    if (onRetry != null) {
      actions.add(
        IconButton.ghost(
          icon: Icon(RadixIcons.update, size: 16 * scaling),
          onPressed: onRetry,
        ),
      );
    }
    if (onRemove != null) {
      actions.add(
        IconButton.ghost(
          icon: Icon(RadixIcons.cross1, size: 16 * scaling),
          onPressed: onRemove,
        ),
      );
    }

    return OutlinedContainer(
      borderRadius: BorderRadius.circular(12 * scaling),
      borderWidth: 1,
      borderColor: theme.colorScheme.muted,
      backgroundColor: theme.colorScheme.background,
      child: Padding(
        padding: EdgeInsets.all(12 * scaling),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40 * scaling,
                  height: 40 * scaling,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(8 * scaling),
                  ),
                  alignment: Alignment.center,
                  child: resolvedThumbnail,
                ),
                Gap(12 * scaling),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle.merge(
                        style: theme.typography.small.merge(
                          theme.typography.semiBold,
                        ),
                        child: fileName,
                      ),
                      if (fileSize != null || fileType != null)
                        Gap(4 * scaling),
                      if (fileSize != null || fileType != null)
                        DefaultTextStyle.merge(
                          style: theme.typography.xSmall.copyWith(
                            color: theme.colorScheme.mutedForeground,
                          ),
                          child: Wrap(
                            spacing: 8 * scaling,
                            children: [
                              if (fileType != null) fileType!,
                              if (fileSize != null) fileSize!,
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if (actions.isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions
                        .map(
                          (action) => Padding(
                            padding: EdgeInsets.only(left: 4 * scaling),
                            child: action,
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
            if (uploadProgress != null) Gap(12 * scaling),
            if (uploadProgress != null)
              LinearProgressIndicator(
                value: uploadProgress!.clamp(0, 1),
                minHeight: 4 * scaling,
              ),
          ],
        ),
      ),
    );
  }
}
