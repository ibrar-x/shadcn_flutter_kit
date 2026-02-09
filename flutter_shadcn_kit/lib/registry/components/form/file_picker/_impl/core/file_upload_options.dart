part of '../../file_picker.dart';

/// Visual trigger style used by the compact/mobile file picker variant.
enum FileUploadCompactTrigger { icon, button }

/// Available top-level layouts for [FileUpload].
enum FileUploadVariant { dragDrop, tile, mobile }

/// Internal mode for compact/mobile picker rendering.
enum _FileUploadMobileMode { button, popover }

/// Shared options contract for all [FileUpload] variants.
abstract class FileUploadOptions {
  const FileUploadOptions();

  /// Declares which surface should be rendered.
  FileUploadVariant get variant;
}

/// Options for desktop-style drag-and-drop upload surface.
class FileUploadDragDropOptions extends FileUploadOptions {
  const FileUploadDragDropOptions({
    this.enableDragDrop = true,
    this.enableDropzoneClick = true,
    this.dropTargetBuilder,
    this.icon,
  });

  /// Enables native/web drag-and-drop where supported.
  final bool enableDragDrop;

  /// Allows tapping the dropzone to invoke [FileUploadPickFiles].
  final bool enableDropzoneClick;

  /// Optional wrapper to replace/customize the drop target container.
  final FileUploadDropTargetBuilder? dropTargetBuilder;

  /// Optional icon shown in the drag-drop surface.
  final Widget? icon;

  @override
  FileUploadVariant get variant => FileUploadVariant.dragDrop;
}

/// Options for compact tile-style picker (no drag-and-drop behavior).
class FileUploadTileOptions extends FileUploadOptions {
  const FileUploadTileOptions({this.actionLabel, this.icon});

  /// Label used by the tile action segment.
  final String? actionLabel;

  /// Optional icon if tile visuals include one in future updates.
  final Widget? icon;

  @override
  FileUploadVariant get variant => FileUploadVariant.tile;
}

/// Options for mobile-friendly trigger surfaces.
class FileUploadMobileOptions extends FileUploadOptions {
  const FileUploadMobileOptions({
    this.popover = false,
    this.popoverItems,
    this.icon,
    this.trigger = FileUploadCompactTrigger.icon,
    this.buttonLabel,
  }) : assert(
         !popover || popoverItems != null,
         'popoverItems must be provided when popover is true.',
       );

  /// Shows a popover list of [popoverItems] when true.
  final bool popover;

  /// Menu actions available in popover mode.
  final List<FileUploadPickOption>? popoverItems;

  /// Trigger icon used for compact trigger layouts.
  final Widget? icon;

  /// Trigger type used for compact mode.
  final FileUploadCompactTrigger trigger;

  /// Label used when [trigger] is [FileUploadCompactTrigger.button].
  final String? buttonLabel;

  @override
  FileUploadVariant get variant => FileUploadVariant.mobile;
}

/// Represents one picker action in compact popover menus.
class FileUploadPickOption {
  const FileUploadPickOption({
    required this.id,
    required this.label,
    this.icon,
    this.allowMultiple,
    this.withData,
    this.allowedExtensions,
    this.allowedMimeTypes,
  });

  /// Stable action id for analytics or matching.
  final String id;

  /// User-facing label.
  final String label;

  /// Optional action icon.
  final Widget? icon;

  /// Overrides [FileUpload.allowMultiple] for this action.
  final bool? allowMultiple;

  /// Overrides [FileUpload.withData] for this action.
  final bool? withData;

  /// Overrides [FileUpload.allowedExtensions] for this action.
  final List<String>? allowedExtensions;

  /// Overrides [FileUpload.allowedMimeTypes] for this action.
  final List<String>? allowedMimeTypes;

  /// Generic file action.
  static const FileUploadPickOption pickFiles = FileUploadPickOption(
    id: 'pick_files',
    label: 'Pick files',
    icon: Icon(RadixIcons.file),
  );

  /// Images-only action.
  static const FileUploadPickOption pickImages = FileUploadPickOption(
    id: 'pick_images',
    label: 'Pick images',
    icon: Icon(RadixIcons.image),
    allowedMimeTypes: ['image/*'],
  );
}

/// Builder used to customize the drop target wrapper.
typedef FileUploadDropTargetBuilder =
    Widget Function({
      required Widget child,
      required bool enabled,
      required bool withData,
      required ValueChanged<bool> onDragActive,
      required ValueChanged<List<FileLike>> onDrop,
      VoidCallback? onTap,
    });

/// Builder used to control tile text for selected files.
typedef FileUploadTileSelectionTextBuilder =
    String Function(List<FileLike> files);

/// Placement options for the optional helpful info text.
enum FileUploadHelpfulInfoPlacement { automatic, belowSurface, insideSurface }

/// Snapshot of acceptance constraints used by helpful info builders.
class FileUploadHelpfulInfoData {
  const FileUploadHelpfulInfoData({
    required this.allowMultiple,
    required this.maxFiles,
    required this.maxFileSizeBytes,
    required this.allowedExtensions,
    required this.allowedMimeTypes,
  });

  final bool allowMultiple;
  final int? maxFiles;
  final int? maxFileSizeBytes;
  final List<String>? allowedExtensions;
  final List<String>? allowedMimeTypes;
}

/// Builder used to render optional helpful info for constraints/limits.
typedef FileUploadHelpfulInfoBuilder =
    Widget Function(BuildContext context, FileUploadHelpfulInfoData info);

/// Customizable labels for status sections and badges.
class FileUploadStatusLabels {
  const FileUploadStatusLabels({
    this.uploading = 'Uploading',
    this.completed = 'Completed',
    this.waiting = 'Waiting',
    this.failed = 'Failed',
  });

  final String uploading;
  final String completed;
  final String waiting;
  final String failed;

  /// Maps status enum values to user-facing labels.
  String resolve(FileUploadItemStatus status) {
    switch (status) {
      case FileUploadItemStatus.uploading:
        return uploading;
      case FileUploadItemStatus.success:
        return completed;
      case FileUploadItemStatus.error:
        return failed;
      case FileUploadItemStatus.idle:
        return waiting;
    }
  }
}
