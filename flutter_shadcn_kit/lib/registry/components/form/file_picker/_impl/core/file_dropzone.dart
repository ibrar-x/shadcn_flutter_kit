part of '../../file_picker.dart';

/// A stylized dropzone surface for file uploads.
class FileDropzone extends StatelessWidget {
  const FileDropzone({
    super.key,
    this.hotDropEnabled = false,
    this.hotDropping = false,
    this.enabled = true,
    this.state = FileUploadState.idle,
    this.isFocused = false,
    this.hint,
    this.icon,
    this.actionLabel,
    this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight,
  });

  /// Whether drag-and-drop should be emphasized in the copy.
  final bool hotDropEnabled;

  /// Whether the dropzone is actively receiving a drop.
  final bool hotDropping;

  /// Whether the dropzone is enabled.
  final bool enabled;

  /// Current upload state.
  final FileUploadState state;

  /// Whether the dropzone is focused for keyboard interaction.
  final bool isFocused;

  /// Optional helper text displayed under the primary label.
  final Widget? hint;

  /// Optional icon widget shown above the label.
  final Widget? icon;

  /// Button label text for the browse action.
  final String? actionLabel;

  /// Called when the browse action is pressed.
  final VoidCallback? onPressed;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Optional border radius override.
  final BorderRadiusGeometry? borderRadius;

  /// Optional padding override.
  final EdgeInsetsGeometry? padding;

  /// Optional minimum height for the dropzone.
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final borderColor = _resolveBorderColor(theme);
    final effectivePadding = padding ?? EdgeInsets.all(24 * scaling);
    final dropzoneIcon =
        icon ??
        Icon(
          RadixIcons.upload,
          size: 28 * scaling,
          color: enabled
              ? theme.colorScheme.mutedForeground
              : theme.colorScheme.mutedForeground.withOpacity(0.5),
        );
    final label = actionLabel ?? 'Browse files';
    final statusLabel = _resolveStatusLabel();
    final focusRing = isFocused
        ? [
            BoxShadow(
              color: theme.colorScheme.ring.withOpacity(0.45),
              blurRadius: 0,
              spreadRadius: 2 * scaling,
            ),
          ]
        : null;

    return OutlinedContainer(
      borderRadius: borderRadius ?? BorderRadius.circular(16 * scaling),
      borderWidth: 1,
      borderColor: borderColor,
      boxShadow: focusRing,
      backgroundColor: backgroundColor ?? theme.colorScheme.background,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight ?? 0),
        child: Padding(
          padding: effectivePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dropzoneIcon,
              Gap(12 * scaling),
              DefaultTextStyle.merge(
                style: theme.typography.small.copyWith(
                  color: enabled
                      ? theme.colorScheme.mutedForeground
                      : theme.colorScheme.mutedForeground.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
                child: Text(statusLabel),
              ),
              if (hint != null) Gap(8 * scaling),
              if (hint != null)
                DefaultTextStyle.merge(
                  style: theme.typography.xSmall.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                  child: hint!,
                ),
              Gap(16 * scaling),
              OutlineButton(
                onPressed: enabled ? onPressed : null,
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _resolveBorderColor(ThemeData theme) {
    if (!enabled) return theme.colorScheme.muted;
    if (hotDropping) return theme.colorScheme.primary;
    switch (state) {
      case FileUploadState.dragging:
        return theme.colorScheme.primary;
      case FileUploadState.uploading:
        return theme.colorScheme.primary;
      case FileUploadState.success:
        return theme.colorScheme.accent;
      case FileUploadState.error:
        return theme.colorScheme.destructive;
      case FileUploadState.disabled:
        return theme.colorScheme.muted;
      case FileUploadState.idle:
        return theme.colorScheme.muted;
    }
  }

  String _resolveStatusLabel() {
    if (!enabled) return 'File uploads disabled';
    if (hotDropping || state == FileUploadState.dragging) {
      return 'Drop files to upload';
    }
    switch (state) {
      case FileUploadState.dragging:
        return 'Drop files to upload';
      case FileUploadState.uploading:
        return 'Uploading files...';
      case FileUploadState.success:
        return 'Files ready';
      case FileUploadState.error:
        return 'Fix errors to continue';
      case FileUploadState.disabled:
        return 'File uploads disabled';
      case FileUploadState.idle:
        return hotDropEnabled
            ? 'Drag files here or browse to upload'
            : 'Browse to upload files';
    }
  }
}
