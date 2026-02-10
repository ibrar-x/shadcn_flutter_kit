part of '../../file_picker.dart';

/// Internal surface discriminator for [FileUpload] rendering.
enum _FileUploadSurface { dragDrop, tile, mobile }

/// UI-only file upload component with pluggable picking/upload integrations.
class FileUpload extends _FileUpload {
  /// Creates a [FileUpload] widget.
  ///
  /// The `options` parameter selects the surface variant while core behavior
  /// (validation, upload, callbacks, file list rendering) remains shared.
  FileUpload({
    super.key,
    super.title,
    super.subtitle,
    super.hint,
    super.enabled = true,
    super.allowMultiple = true,
    super.withData = true,
    super.maxFiles,
    super.maxFileSizeBytes,
    super.allowedExtensions,
    super.allowedMimeTypes,
    super.files,
    super.controller,
    super.onFilesSelected,
    super.onFilesChanged,
    super.onUploadStart,
    super.onProgress,
    super.onComplete,
    super.onError,
    super.uploadFn,
    super.pickFiles,
    super.itemBuilder,
    super.showFileList = true,
    super.groupListByStatus = true,
    super.itemsLayout = FileUploadItemsLayout.list,
    super.itemsGridColumns = 2,
    super.itemsMaxHeight,
    super.maxConcurrentUploads = 1,
    super.backgroundColor,
    super.borderRadius,
    super.padding,
    super.minHeight,
    super.statusLabels = const FileUploadStatusLabels(),
    super.tileEmptySelectionLabel = 'No file chosen',
    super.tileSelectionTextBuilder,
    super.showHelpfulInfo = false,
    super.helpfulInfoPlacement = FileUploadHelpfulInfoPlacement.automatic,
    super.helpfulInfoBuilder,
    FileUploadOptions options = const FileUploadDragDropOptions(),
  }) : assert(
         maxConcurrentUploads > 0,
         'maxConcurrentUploads must be greater than 0.',
       ),
       assert(
         options is! FileUploadMobileOptions ||
             !options.popover ||
             (options.popoverItems?.isNotEmpty ?? false),
         'popoverItems must be provided and non-empty when mobile popover is enabled.',
       ),
       super._internal(
         surface: _surfaceFromOptions(options),
         loading: _loadingFromOptions(options),
         itemLoading: _itemLoadingFromOptions(options),
         icon: _iconFromOptions(options),
         surfaceSubtitle: _surfaceSubtitleFromOptions(options),
         surfaceHint: _surfaceHintFromOptions(options),
         actionLabel: _actionLabelFromOptions(options),
         enableDragDrop: _enableDragDropFromOptions(options),
         enableDropzoneClick: _enableDropzoneClickFromOptions(options),
         dragDropIdleLabel: _dragDropIdleLabelFromOptions(options),
         dragDropClickToPickLabel: _dragDropClickToPickLabelFromOptions(
           options,
         ),
         dragDropDraggingLabel: _dragDropDraggingLabelFromOptions(options),
         dragDropUploadingLabel: _dragDropUploadingLabelFromOptions(options),
         dragDropSuccessLabel: _dragDropSuccessLabelFromOptions(options),
         dragDropErrorLabel: _dragDropErrorLabelFromOptions(options),
         dragDropDisabledLabel: _dragDropDisabledLabelFromOptions(options),
         dropTargetBuilder: _dropTargetBuilderFromOptions(options),
         mobileMode: _mobileModeFromOptions(options),
         compactIcon: _compactIconFromOptions(options),
         compactTrigger: _compactTriggerFromOptions(options),
         compactButtonLabel: _compactButtonLabelFromOptions(options),
         compactOptions: _compactOptionsFromOptions(options),
       );

  static _FileUploadSurface _surfaceFromOptions(FileUploadOptions options) {
    return switch (options.variant) {
      FileUploadVariant.dragDrop => _FileUploadSurface.dragDrop,
      FileUploadVariant.tile => _FileUploadSurface.tile,
      FileUploadVariant.mobile => _FileUploadSurface.mobile,
    };
  }

  static bool _enableDragDropFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.enableDragDrop;
    }
    return false;
  }

  static bool _enableDropzoneClickFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.enableDropzoneClick;
    }
    return false;
  }

  static FileUploadDropTargetBuilder? _dropTargetBuilderFromOptions(
    FileUploadOptions options,
  ) {
    if (options is FileUploadDragDropOptions) {
      return options.dropTargetBuilder;
    }
    return null;
  }

  static String? _actionLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadTileOptions) {
      return options.actionLabel;
    }
    return null;
  }

  static Widget? _surfaceSubtitleFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.subtitle;
    }
    if (options is FileUploadTileOptions) {
      return options.subtitle;
    }
    return null;
  }

  static Widget? _surfaceHintFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.hint;
    }
    if (options is FileUploadTileOptions) {
      return options.hint;
    }
    return null;
  }

  static Widget? _iconFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.icon;
    }
    if (options is FileUploadTileOptions) {
      return options.icon;
    }
    return null;
  }

  static FileUploadLoadingOptions _loadingFromOptions(
    FileUploadOptions options,
  ) {
    if (options is FileUploadDragDropOptions) {
      return options.loading;
    }
    if (options is FileUploadTileOptions) {
      return options.loading;
    }
    if (options is FileUploadMobileOptions) {
      return options.loading;
    }
    return const FileUploadLoadingOptions();
  }

  static FileUploadItemLoadingOptions _itemLoadingFromOptions(
    FileUploadOptions options,
  ) {
    if (options is FileUploadDragDropOptions) {
      return options.itemLoading;
    }
    if (options is FileUploadTileOptions) {
      return options.itemLoading;
    }
    if (options is FileUploadMobileOptions) {
      return options.itemLoading;
    }
    return const FileUploadItemLoadingOptions();
  }

  static Widget? _compactIconFromOptions(FileUploadOptions options) {
    if (options is FileUploadMobileOptions) {
      return options.icon;
    }
    return null;
  }

  static _FileUploadMobileMode _mobileModeFromOptions(
    FileUploadOptions options,
  ) {
    if (options is FileUploadMobileOptions && options.popover) {
      return _FileUploadMobileMode.popover;
    }
    return _FileUploadMobileMode.button;
  }

  static FileUploadCompactTrigger _compactTriggerFromOptions(
    FileUploadOptions options,
  ) {
    if (options is FileUploadMobileOptions) {
      return options.trigger;
    }
    return FileUploadCompactTrigger.icon;
  }

  static String? _compactButtonLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadMobileOptions) {
      return options.buttonLabel;
    }
    return null;
  }

  static List<FileUploadPickOption>? _compactOptionsFromOptions(
    FileUploadOptions options,
  ) {
    if (options is FileUploadMobileOptions) {
      return options.popoverItems;
    }
    return null;
  }

  static String? _dragDropIdleLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.idleLabel;
    }
    return null;
  }

  static String? _dragDropClickToPickLabelFromOptions(
    FileUploadOptions options,
  ) {
    if (options is FileUploadDragDropOptions) {
      return options.clickToPickLabel;
    }
    return null;
  }

  static String? _dragDropDraggingLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.draggingLabel;
    }
    return null;
  }

  static String? _dragDropUploadingLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.uploadingLabel;
    }
    return null;
  }

  static String? _dragDropSuccessLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.successLabel;
    }
    return null;
  }

  static String? _dragDropErrorLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.errorLabel;
    }
    return null;
  }

  static String? _dragDropDisabledLabelFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.disabledLabel;
    }
    return null;
  }
}

/// Internal shared widget used by [FileUpload] after option mapping.
class _FileUpload extends StatefulWidget {
  const _FileUpload._internal({
    super.key,
    required this.surface,
    this.loading = const FileUploadLoadingOptions(),
    this.itemLoading = const FileUploadItemLoadingOptions(),
    this.title,
    this.subtitle,
    this.hint,
    this.surfaceSubtitle,
    this.surfaceHint,
    this.icon,
    this.enableDragDrop = false,
    this.enableDropzoneClick = false,
    this.dragDropIdleLabel,
    this.dragDropClickToPickLabel,
    this.dragDropDraggingLabel,
    this.dragDropUploadingLabel,
    this.dragDropSuccessLabel,
    this.dragDropErrorLabel,
    this.dragDropDisabledLabel,
    this.actionLabel,
    this.enabled = true,
    this.allowMultiple = true,
    this.withData = true,
    this.maxFiles,
    this.maxFileSizeBytes,
    this.allowedExtensions,
    this.allowedMimeTypes,
    this.files,
    this.controller,
    this.onFilesSelected,
    this.onFilesChanged,
    this.onUploadStart,
    this.onProgress,
    this.onComplete,
    this.onError,
    this.uploadFn,
    this.pickFiles,
    this.dropTargetBuilder,
    this.itemBuilder,
    this.showFileList = true,
    this.groupListByStatus = true,
    this.itemsLayout = FileUploadItemsLayout.list,
    this.itemsGridColumns = 2,
    this.itemsMaxHeight,
    this.maxConcurrentUploads = 1,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight,
    this.statusLabels = const FileUploadStatusLabels(),
    this.tileEmptySelectionLabel = 'No file chosen',
    this.tileSelectionTextBuilder,
    this.showHelpfulInfo = false,
    this.helpfulInfoPlacement = FileUploadHelpfulInfoPlacement.automatic,
    this.helpfulInfoBuilder,
    this.mobileMode = _FileUploadMobileMode.button,
    this.compactIcon,
    this.compactTrigger = FileUploadCompactTrigger.icon,
    this.compactButtonLabel,
    this.compactOptions,
  });

  final _FileUploadSurface surface;
  final FileUploadLoadingOptions loading;
  final FileUploadItemLoadingOptions itemLoading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? hint;
  final Widget? surfaceSubtitle;
  final Widget? surfaceHint;
  final Widget? icon;
  final String? actionLabel;

  final bool enableDragDrop;
  final bool enableDropzoneClick;
  final String? dragDropIdleLabel;
  final String? dragDropClickToPickLabel;
  final String? dragDropDraggingLabel;
  final String? dragDropUploadingLabel;
  final String? dragDropSuccessLabel;
  final String? dragDropErrorLabel;
  final String? dragDropDisabledLabel;
  final bool enabled;
  final bool allowMultiple;
  final bool withData;

  final int? maxFiles;
  final int? maxFileSizeBytes;
  final List<String>? allowedExtensions;
  final List<String>? allowedMimeTypes;

  final List<FileLike>? files;
  final FileUploadController? controller;

  final ValueChanged<List<FileLike>>? onFilesSelected;
  final ValueChanged<List<FileLike>>? onFilesChanged;
  final VoidCallback? onUploadStart;
  final void Function(FileLike file, double progress)? onProgress;
  final ValueChanged<List<FileLike>>? onComplete;
  final ValueChanged<FileUploadError>? onError;
  final UploadFn? uploadFn;
  final FileUploadPickFiles? pickFiles;

  final FileUploadDropTargetBuilder? dropTargetBuilder;

  final Widget Function(BuildContext context, FileUploadItem item)? itemBuilder;
  final bool showFileList;
  final bool groupListByStatus;
  final FileUploadItemsLayout itemsLayout;
  final int itemsGridColumns;
  final double? itemsMaxHeight;
  final int maxConcurrentUploads;

  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? minHeight;

  final FileUploadStatusLabels statusLabels;
  final String tileEmptySelectionLabel;
  final FileUploadTileSelectionTextBuilder? tileSelectionTextBuilder;
  final bool showHelpfulInfo;
  final FileUploadHelpfulInfoPlacement helpfulInfoPlacement;
  final FileUploadHelpfulInfoBuilder? helpfulInfoBuilder;

  final _FileUploadMobileMode mobileMode;
  final Widget? compactIcon;
  final FileUploadCompactTrigger compactTrigger;
  final String? compactButtonLabel;
  final List<FileUploadPickOption>? compactOptions;

  @override
  State<_FileUpload> createState() => _FileUploadState();
}
