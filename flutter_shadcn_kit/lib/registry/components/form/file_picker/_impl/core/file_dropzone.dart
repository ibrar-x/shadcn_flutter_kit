part of '../../file_picker.dart';

/// A stylized dropzone surface for file uploads.
class FileDropzone extends StatelessWidget {
  const FileDropzone({
    super.key,
    this.hotDropEnabled = false,
    this.hotDropping = false,
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
    final borderColor = hotDropping
        ? theme.colorScheme.primary
        : theme.colorScheme.muted;
    final effectivePadding = padding ?? EdgeInsets.all(24 * scaling);
    final dropzoneIcon =
        icon ??
        Icon(
          RadixIcons.upload,
          size: 28 * scaling,
          color: theme.colorScheme.mutedForeground,
        );
    final label = actionLabel ?? 'Browse files';

    return OutlinedContainer(
      borderRadius: borderRadius ?? BorderRadius.circular(16 * scaling),
      borderWidth: 1,
      borderColor: borderColor,
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
                  color: theme.colorScheme.mutedForeground,
                ),
                textAlign: TextAlign.center,
                child: Text(
                  hotDropping
                      ? 'Drop files to upload'
                      : hotDropEnabled
                      ? 'Drag files here or browse to upload'
                      : 'Browse to upload files',
                ),
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
              OutlineButton(onPressed: onPressed, child: Text(label)),
            ],
          ),
        ),
      ),
    );
  }
}
