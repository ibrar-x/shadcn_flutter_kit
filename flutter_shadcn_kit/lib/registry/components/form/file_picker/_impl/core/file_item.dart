part of '../../file_picker.dart';

/// A widget representing a single file item in a file upload list.
class FileItem extends StatelessWidget {
  const FileItem({
    super.key,
    required this.item,
    this.statusLabels = const FileUploadStatusLabels(),
    this.onRemove,
    this.onRetry,
    this.onDownload,
    this.onPreview,
    this.thumbnail,
  });

  final FileUploadItem item;
  final FileUploadStatusLabels statusLabels;
  final VoidCallback? onRemove;
  final VoidCallback? onRetry;
  final VoidCallback? onDownload;
  final VoidCallback? onPreview;
  final Widget? thumbnail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final resolvedThumbnail =
        thumbnail ?? _buildThumbnail(context, theme, scaling);
    final statusLabel = _statusLabel(item.status);
    final statusColor = _statusColor(theme, item.status);

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
    if (onRetry != null && item.status == FileUploadItemStatus.error) {
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
      borderWidth: 1,
      child: Padding(
        padding: EdgeInsets.all(theme.density.baseGap * scaling * 1.5),
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
                DensityGap(gapMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle.merge(
                        style: theme.typography.small.merge(
                          theme.typography.semiBold,
                        ),
                        child: Text(item.file.name),
                      ),
                      DensityGap(gapXs),
                      DefaultTextStyle.merge(
                        style: theme.typography.xSmall.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                        child: Wrap(
                          spacing: theme.density.baseGap * scaling,
                          children: [
                            Text(_fileTypeLabel(item.file)),
                            Text(formatFileSize(item.file.size)),
                            if (statusLabel != null)
                              Text(
                                statusLabel,
                                style: theme.typography.xSmall.copyWith(
                                  color: statusColor,
                                ),
                              ),
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
                            padding: EdgeInsets.only(
                              left: theme.density.baseGap * scaling * 0.5,
                            ),
                            child: action,
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
            if (item.progress != null) DensityGap(gapMd),
            if (item.progress != null)
              LinearProgressIndicator(
                value: item.progress!.clamp(0, 1),
                minHeight: 4 * scaling,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(
    BuildContext context,
    ThemeData theme,
    double scaling,
  ) {
    final bytes = item.file.bytes;
    if (bytes != null && item.file.isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6 * scaling),
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
          width: 32 * scaling,
          height: 32 * scaling,
        ),
      );
    }
    final extension = item.file.resolvedExtension;
    return IconTheme(
      data: IconThemeData(
        color: theme.colorScheme.mutedForeground,
        size: 20 * scaling,
      ),
      child: FileIconProvider.buildIcon(context, extension),
    );
  }

  String _fileTypeLabel(FileLike file) {
    final extension = file.resolvedExtension;
    if (extension.isEmpty) return 'File';
    return extension.toUpperCase();
  }

  String? _statusLabel(FileUploadItemStatus status) {
    return statusLabels.resolve(status);
  }

  Color? _statusColor(ThemeData theme, FileUploadItemStatus status) {
    switch (status) {
      case FileUploadItemStatus.uploading:
        return theme.colorScheme.primary;
      case FileUploadItemStatus.success:
        return theme.colorScheme.accent;
      case FileUploadItemStatus.error:
        return theme.colorScheme.destructive;
      case FileUploadItemStatus.idle:
        return theme.colorScheme.mutedForeground;
    }
  }
}
