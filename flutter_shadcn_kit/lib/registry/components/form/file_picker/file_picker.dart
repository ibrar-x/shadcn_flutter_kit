// ignore_for_file: use_super_parameters

import 'dart:async';
import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '_impl/utils/file_like.dart';
import '_impl/utils/file_picker_adapter.dart';
import '_impl/utils/file_upload_models.dart';
import '_impl/utils/file_upload_controller.dart';
import '_impl/utils/file_validation.dart';
import '_impl/themes/file_upload_dropzone_theme.dart';
import '../../../shared/icons/radix_icons.dart';
import '../../../shared/primitives/outlined_container.dart';
import '../../../shared/primitives/overlay.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/geometry_extensions.dart';
import '../../control/button/button.dart';
import '../../display/linear_progress_indicator/linear_progress_indicator.dart';
import '../dropzone/dropzone.dart';
import '../file_input/file_input.dart';

export '_impl/utils/file_like.dart';
export '_impl/utils/file_upload_models.dart';
export '_impl/utils/file_upload_controller.dart';
export '_impl/themes/file_upload_dropzone_theme.dart';

part '_impl/core/file_item.dart';
part '_impl/core/file_upload_items_view.dart';

enum FileUploadCompactTrigger { icon, button }

enum FileUploadVariant { dragDrop, tile, mobile }

enum _FileUploadMobileMode { button, popover }

abstract class FileUploadOptions {
  const FileUploadOptions();
  FileUploadVariant get variant;
}

class FileUploadDragDropOptions extends FileUploadOptions {
  const FileUploadDragDropOptions({
    this.enableDragDrop = true,
    this.enableDropzoneClick = true,
    this.dropTargetBuilder,
    this.icon,
  });

  final bool enableDragDrop;
  final bool enableDropzoneClick;
  final FileUploadDropTargetBuilder? dropTargetBuilder;
  final Widget? icon;

  @override
  FileUploadVariant get variant => FileUploadVariant.dragDrop;
}

class FileUploadTileOptions extends FileUploadOptions {
  const FileUploadTileOptions({this.actionLabel, this.icon});

  final String? actionLabel;
  final Widget? icon;

  @override
  FileUploadVariant get variant => FileUploadVariant.tile;
}

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

  final bool popover;
  final List<FileUploadPickOption>? popoverItems;
  final Widget? icon;
  final FileUploadCompactTrigger trigger;
  final String? buttonLabel;

  @override
  FileUploadVariant get variant => FileUploadVariant.mobile;
}

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

  final String id;
  final String label;
  final Widget? icon;
  final bool? allowMultiple;
  final bool? withData;
  final List<String>? allowedExtensions;
  final List<String>? allowedMimeTypes;

  static const FileUploadPickOption pickFiles = FileUploadPickOption(
    id: 'pick_files',
    label: 'Pick files',
    icon: Icon(RadixIcons.file),
  );

  static const FileUploadPickOption pickImages = FileUploadPickOption(
    id: 'pick_images',
    label: 'Pick images',
    icon: Icon(RadixIcons.image),
    allowedMimeTypes: ['image/*'],
  );
}

typedef FileUploadDropTargetBuilder =
    Widget Function({
      required Widget child,
      required bool enabled,
      required bool withData,
      required ValueChanged<bool> onDragActive,
      required ValueChanged<List<FileLike>> onDrop,
      VoidCallback? onTap,
    });

typedef FileUploadTileSelectionTextBuilder =
    String Function(List<FileLike> files);

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

class FileUpload extends _FileUpload {
  FileUpload({
    super.key,
    Widget? title,
    Widget? subtitle,
    Widget? hint,
    bool enabled = true,
    bool allowMultiple = true,
    bool withData = true,
    int? maxFiles,
    int? maxFileSizeBytes,
    List<String>? allowedExtensions,
    List<String>? allowedMimeTypes,
    List<FileLike>? files,
    FileUploadController? controller,
    ValueChanged<List<FileLike>>? onFilesSelected,
    ValueChanged<List<FileLike>>? onFilesChanged,
    VoidCallback? onUploadStart,
    void Function(FileLike file, double progress)? onProgress,
    ValueChanged<List<FileLike>>? onComplete,
    ValueChanged<FileUploadError>? onError,
    UploadFn? uploadFn,
    FileUploadPickFiles? pickFiles,
    Widget Function(BuildContext context, FileUploadItem item)? itemBuilder,
    bool showFileList = true,
    bool groupListByStatus = true,
    FileUploadItemsLayout itemsLayout = FileUploadItemsLayout.list,
    int itemsGridColumns = 2,
    double? itemsMaxHeight,
    int maxConcurrentUploads = 1,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    double? minHeight,
    FileUploadStatusLabels statusLabels = const FileUploadStatusLabels(),
    String tileEmptySelectionLabel = 'No file chosen',
    FileUploadTileSelectionTextBuilder? tileSelectionTextBuilder,
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
         title: title,
         subtitle: subtitle,
         hint: hint,
         enabled: enabled,
         allowMultiple: allowMultiple,
         withData: withData,
         maxFiles: maxFiles,
         maxFileSizeBytes: maxFileSizeBytes,
         allowedExtensions: allowedExtensions,
         allowedMimeTypes: allowedMimeTypes,
         files: files,
         controller: controller,
         onFilesSelected: onFilesSelected,
         onFilesChanged: onFilesChanged,
         onUploadStart: onUploadStart,
         onProgress: onProgress,
         onComplete: onComplete,
         onError: onError,
         uploadFn: uploadFn,
         pickFiles: pickFiles,
         itemBuilder: itemBuilder,
         showFileList: showFileList,
         groupListByStatus: groupListByStatus,
         itemsLayout: itemsLayout,
         itemsGridColumns: itemsGridColumns,
         itemsMaxHeight: itemsMaxHeight,
         maxConcurrentUploads: maxConcurrentUploads,
         backgroundColor: backgroundColor,
         borderRadius: borderRadius,
         padding: padding,
         minHeight: minHeight,
         statusLabels: statusLabels,
         tileEmptySelectionLabel: tileEmptySelectionLabel,
         tileSelectionTextBuilder: tileSelectionTextBuilder,
         icon: _iconFromOptions(options),
         compactIcon: _compactIconFromOptions(options),
         actionLabel: _actionLabelFromOptions(options),
         enableDragDrop: _enableDragDropFromOptions(options),
         enableDropzoneClick: _enableDropzoneClickFromOptions(options),
         dropTargetBuilder: _dropTargetBuilderFromOptions(options),
         mobileMode: _mobileModeFromOptions(options),
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

  static Widget? _iconFromOptions(FileUploadOptions options) {
    if (options is FileUploadDragDropOptions) {
      return options.icon;
    }
    if (options is FileUploadTileOptions) {
      return options.icon;
    }
    return null;
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
}

enum _FileUploadSurface { dragDrop, tile, mobile }

class _FileUpload extends StatefulWidget {
  const _FileUpload._internal({
    super.key,
    required this.surface,
    this.title,
    this.subtitle,
    this.hint,
    this.icon,
    this.enableDragDrop = false,
    this.enableDropzoneClick = false,
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
    this.mobileMode = _FileUploadMobileMode.button,
    this.compactIcon,
    this.compactTrigger = FileUploadCompactTrigger.icon,
    this.compactButtonLabel,
    this.compactOptions,
  });

  final _FileUploadSurface surface;

  final Widget? title;
  final Widget? subtitle;
  final Widget? hint;
  final Widget? icon;
  final String? actionLabel;

  final bool enableDragDrop;
  final bool enableDropzoneClick;
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

  final _FileUploadMobileMode mobileMode;
  final Widget? compactIcon;
  final FileUploadCompactTrigger compactTrigger;
  final String? compactButtonLabel;
  final List<FileUploadPickOption>? compactOptions;

  @override
  State<_FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<_FileUpload> {
  final FilePickerAdapter _adapter = createFilePickerAdapter();
  final PopoverController _compactPickerPopoverController = PopoverController();
  final List<FileUploadItem> _items = [];
  final List<FileUploadError> _errors = [];
  final Map<String, StreamSubscription<double>> _uploadSubscriptions = {};
  final ListQueue<FileLike> _uploadQueue = ListQueue<FileLike>();

  bool _dragActive = false;
  bool _focused = false;
  bool _completedOnce = false;
  bool _controllerListenerAttached = false;
  int _activeUploads = 0;
  Timer? _dragDebounce;

  List<FileUploadItem> get _effectiveItems {
    if (widget.controller != null) {
      return widget.controller!.items;
    }
    if (widget.files == null) return _items;
    return widget.files!.map(FileUploadItem.fromFile).toList();
  }

  bool get _isUploading => _effectiveItems.any(
    (item) => item.status == FileUploadItemStatus.uploading,
  );

  FileUploadState get _state {
    if (!widget.enabled) return FileUploadState.disabled;
    if (_dragActive) return FileUploadState.dragging;
    if (_isUploading) return FileUploadState.uploading;
    if (_errors.isNotEmpty) return FileUploadState.error;
    if (_completedOnce && _effectiveItems.isNotEmpty) {
      return FileUploadState.success;
    }
    return FileUploadState.idle;
  }

  void _setErrors(List<FileUploadError> errors) {
    setState(() {
      if (errors.isNotEmpty) {
        _completedOnce = false;
      }
      _errors
        ..clear()
        ..addAll(errors);
    });
    for (final error in errors) {
      widget.onError?.call(error);
    }
  }

  void _syncControllerState() {
    if (!mounted || _controllerListenerAttached) {
      return;
    }
    widget.controller?.addListener(_onControllerChanged);
    _controllerListenerAttached = true;
    _onControllerChanged();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    setState(() {
      _errors
        ..clear()
        ..addAll(widget.controller?.errors ?? const []);
      if (widget.controller != null && !widget.controller!.hasItems) {
        _completedOnce = false;
      }
    });
  }

  Future<void> _pickFiles() async {
    await _pickFilesForOption(null);
  }

  Future<void> _pickFilesForOption(FileUploadPickOption? option) async {
    if (!widget.enabled || widget.pickFiles == null) {
      return;
    }

    try {
      final request = FileUploadPickRequest(
        allowMultiple: option?.allowMultiple ?? widget.allowMultiple,
        withData: option?.withData ?? widget.withData,
        allowedExtensions:
            option?.allowedExtensions ?? widget.allowedExtensions,
        allowedMimeTypes: option?.allowedMimeTypes ?? widget.allowedMimeTypes,
      );
      final files = await widget.pickFiles!.call(request);
      if (!mounted || files.isEmpty) return;
      _handleNewFiles(files);
    } catch (_) {
      final error = FileUploadError(
        code: FileUploadErrorCode.uploadFailed,
        message: 'File picking failed.',
      );
      _setErrors([..._errors, error]);
    }
  }

  List<FileUploadPickOption> _resolveCompactOptions() {
    if (widget.compactOptions != null && widget.compactOptions!.isNotEmpty) {
      return widget.compactOptions!;
    }
    if (widget.mobileMode == _FileUploadMobileMode.popover) {
      return const [];
    }
    return const [FileUploadPickOption.pickFiles];
  }

  Future<void> _openCompactPickerOptions() async {
    final options = _resolveCompactOptions();
    if (options.isEmpty) return;
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    await _compactPickerPopoverController.show<void>(
      context: context,
      alignment: AlignmentDirectional.topEnd,
      anchorAlignment: AlignmentDirectional.bottomEnd,
      offset: Offset(0, theme.density.baseGap * scaling),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 180 * scaling,
            maxWidth: 280 * scaling,
          ),
          child: OutlinedContainer(
            child: Padding(
              padding: EdgeInsets.all(theme.density.baseGap * scaling),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final option in options)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: theme.density.baseGap * scaling * 0.25,
                      ),
                      child: Button.ghost(
                        onPressed: () async {
                          _compactPickerPopoverController.closeLater();
                          await _pickFilesForOption(option);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (option.icon != null) ...[
                              option.icon!,
                              DensityGap(0.5),
                            ],
                            Flexible(
                              child: Text(
                                option.label,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompactPickerTrigger() {
    final options = _resolveCompactOptions();
    final firstOption = options.isNotEmpty ? options.first : null;
    final onPressed = !widget.enabled || widget.pickFiles == null
        ? null
        : widget.mobileMode == _FileUploadMobileMode.popover
        ? _openCompactPickerOptions
        : () => _pickFilesForOption(firstOption);
    final icon = widget.compactIcon ?? const Icon(RadixIcons.upload);

    if (widget.compactTrigger == FileUploadCompactTrigger.button) {
      return OutlineButton(
        onPressed: onPressed,
        leading: icon,
        size: ButtonSize.small,
        child: Text(widget.compactButtonLabel ?? 'Pick files'),
      );
    }

    return IconButton.outline(
      onPressed: onPressed,
      density: ButtonDensity.icon,
      size: ButtonSize.small,
      icon: icon,
    );
  }

  Widget _buildTitleBlock(ThemeData theme) {
    if (widget.title == null && widget.subtitle == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          DefaultTextStyle.merge(
            style: theme.typography.large.merge(theme.typography.semiBold),
            child: widget.title!,
          ),
        if (widget.subtitle != null) DensityGap(0.75),
        if (widget.subtitle != null)
          DefaultTextStyle.merge(
            style: theme.typography.small.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            child: widget.subtitle!,
          ),
        DensityGap(gapLg),
      ],
    );
  }

  void _handleNewFiles(List<FileLike> files) {
    final effectiveMaxFiles = widget.allowMultiple
        ? widget.maxFiles
        : (widget.maxFiles ?? 1);

    if (widget.controller != null) {
      final beforeIds = widget.controller!.items
          .map((item) => item.file.id)
          .toSet();
      widget.controller!.addFiles(files);
      _syncControllerState();
      if (widget.uploadFn != null) {
        final addedFiles = widget.controller!.items
            .where((item) => !beforeIds.contains(item.file.id))
            .map((item) => item.file)
            .toList();
        _startUploads(addedFiles);
      }
      return;
    }

    final validation = validateFiles(
      incoming: files,
      existing: _effectiveItems.map((item) => item.file).toList(),
      maxFiles: effectiveMaxFiles,
      maxFileSizeBytes: widget.maxFileSizeBytes,
      allowedExtensions: widget.allowedExtensions,
      allowedMimeTypes: widget.allowedMimeTypes,
    );

    if (validation.errors.isNotEmpty) {
      _setErrors(validation.errors);
    } else {
      _setErrors(const []);
    }

    if (validation.validFiles.isEmpty) {
      return;
    }

    _completedOnce = false;
    widget.onFilesSelected?.call(validation.validFiles);

    if (widget.files == null) {
      setState(() {
        _items.addAll(validation.validFiles.map(FileUploadItem.fromFile));
      });
      widget.onFilesChanged?.call(_items.map((item) => item.file).toList());
    }

    if (widget.uploadFn != null) {
      _startUploads(validation.validFiles);
    }
  }

  void _startUploads(List<FileLike> files) {
    if (widget.uploadFn == null || files.isEmpty) {
      return;
    }
    widget.onUploadStart?.call();
    _completedOnce = false;

    for (final file in files) {
      final item = _effectiveItems.where((entry) => entry.file.id == file.id);
      if (item.isEmpty) continue;
      if (item.first.status == FileUploadItemStatus.success) continue;
      final alreadyQueued = _uploadQueue.any((entry) => entry.id == file.id);
      final alreadyUploading = _uploadSubscriptions.containsKey(file.id);
      if (alreadyQueued || alreadyUploading) continue;
      _updateItemStatus(
        file,
        status: FileUploadItemStatus.idle,
        progress: null,
      );
      _uploadQueue.addLast(file);
    }

    _pumpUploadQueue();
  }

  void _pumpUploadQueue() {
    final maxConcurrent = widget.maxConcurrentUploads < 1
        ? 1
        : widget.maxConcurrentUploads;
    while (_activeUploads < maxConcurrent && _uploadQueue.isNotEmpty) {
      final file = _uploadQueue.removeFirst();
      _startSingleUpload(file);
    }
  }

  void _startSingleUpload(FileLike file) {
    if (widget.uploadFn == null) return;
    _activeUploads += 1;
    _uploadSubscriptions[file.id]?.cancel();
    _updateItemStatus(
      file,
      status: FileUploadItemStatus.uploading,
      progress: 0,
    );

    final stream = widget.uploadFn!.call(file);
    _uploadSubscriptions[file.id] = stream.listen(
      (progress) {
        if (!mounted) return;
        final clamped = progress.clamp(0, 1).toDouble();
        _updateItemStatus(
          file,
          status: FileUploadItemStatus.uploading,
          progress: clamped,
        );
        widget.onProgress?.call(file, clamped);
      },
      onError: (_) {
        if (!mounted) return;
        final uploadError = FileUploadError(
          code: FileUploadErrorCode.uploadFailed,
          message: 'Upload failed for ${file.name}.',
        );
        _setErrors([..._errors, uploadError]);
        _updateItemStatus(
          file,
          status: FileUploadItemStatus.error,
          progress: null,
        );
        _completeUpload(file.id);
      },
      onDone: () {
        if (!mounted) return;
        _updateItemStatus(
          file,
          status: FileUploadItemStatus.success,
          progress: 1,
        );
        _completeUpload(file.id);
      },
    );
  }

  void _completeUpload(String fileId) {
    final sub = _uploadSubscriptions.remove(fileId);
    sub?.cancel();
    if (_activeUploads > 0) {
      _activeUploads -= 1;
    }
    _pumpUploadQueue();
    _checkUploadCompletion();
  }

  void _cancelUploadForFile(String fileId) {
    _uploadQueue.removeWhere((entry) => entry.id == fileId);
    final sub = _uploadSubscriptions.remove(fileId);
    if (sub != null) {
      sub.cancel();
      if (_activeUploads > 0) {
        _activeUploads -= 1;
      }
      _pumpUploadQueue();
    }
  }

  void _clearUploadQueue() {
    _uploadQueue.clear();
    _activeUploads = 0;
  }

  void _updateItemStatus(
    FileLike file, {
    required FileUploadItemStatus status,
    double? progress,
  }) {
    if (widget.controller != null) {
      widget.controller!.updateItem(file, status, progress);
      _syncControllerState();
      return;
    }
    if (widget.files != null) return;

    final index = _items.indexWhere((item) => item.file.id == file.id);
    if (index == -1) return;

    setState(() {
      _items[index] = _items[index].copyWith(
        status: status,
        progress: progress,
      );
    });
  }

  void _checkUploadCompletion() {
    if (!mounted) return;
    if (_uploadQueue.isNotEmpty || _activeUploads > 0) {
      return;
    }

    final items = _effectiveItems;
    if (items.any((item) => item.status == FileUploadItemStatus.uploading)) {
      return;
    }

    if (items.isEmpty) {
      _completedOnce = false;
      setState(() {});
      return;
    }

    _completedOnce = true;
    if (_errors.isEmpty) {
      widget.onComplete?.call(items.map((item) => item.file).toList());
    }
    setState(() {});
  }

  void _removeItem(FileUploadItem item) {
    _cancelUploadForFile(item.file.id);
    if (widget.controller != null) {
      widget.controller!.removeFile(item.file);
      _syncControllerState();
      return;
    }
    if (widget.files != null) return;

    setState(() {
      _items.removeWhere((entry) => entry.file.id == item.file.id);
      if (_items.isEmpty) {
        _completedOnce = false;
      }
    });

    widget.onFilesChanged?.call(_items.map((entry) => entry.file).toList());
  }

  void _handleDrop(List<FileLike> files) {
    if (!widget.enabled) return;
    _handleNewFiles(files);
  }

  void _setDragActive(bool value) {
    if (value) {
      _dragDebounce?.cancel();
      if (_dragActive) return;
      setState(() => _dragActive = true);
      return;
    }

    _dragDebounce?.cancel();
    _dragDebounce = Timer(const Duration(milliseconds: 120), () {
      if (!mounted) return;
      setState(() => _dragActive = false);
    });
  }

  Widget _buildDragDropContent(ThemeData theme, double scaling) {
    final singleItemContent =
        (!widget.allowMultiple && _effectiveItems.isNotEmpty)
        ? FileUploadItemsView(
            items: [_effectiveItems.first],
            layout: FileUploadItemsLayout.list,
            showContainer: false,
            statusLabels: widget.statusLabels,
            itemBuilder: widget.itemBuilder,
          )
        : null;

    if (singleItemContent != null) {
      return singleItemContent;
    }

    final icon =
        widget.icon ??
        Icon(
          RadixIcons.upload,
          size: 28 * scaling,
          color: widget.enabled
              ? theme.colorScheme.mutedForeground
              : theme.colorScheme.mutedForeground.withOpacity(0.5),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        DensityGap(gapMd),
        DefaultTextStyle.merge(
          style: theme.typography.small.copyWith(
            color: widget.enabled
                ? theme.colorScheme.mutedForeground
                : theme.colorScheme.mutedForeground.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
          child: Text(_dragDropLabel()),
        ),
        if (widget.hint != null) ...[
          DensityGap(gapSm),
          DefaultTextStyle.merge(
            style: theme.typography.xSmall.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
            child: widget.hint!,
          ),
        ],
      ],
    );
  }

  String _dragDropLabel() {
    if (!widget.enabled) return 'File uploads disabled';
    if (_dragActive || _state == FileUploadState.dragging) {
      return 'Drop files to upload';
    }
    switch (_state) {
      case FileUploadState.uploading:
        return 'Uploading files...';
      case FileUploadState.success:
        return 'Files ready';
      case FileUploadState.error:
        return 'Fix errors to continue';
      case FileUploadState.idle:
      case FileUploadState.disabled:
      case FileUploadState.dragging:
        return widget.enableDragDrop
            ? 'Drag files here or click to pick files.'
            : 'Click to pick files.';
    }
  }

  Widget _buildDragDropSurface(
    ThemeData theme,
    FileUploadDropzoneTheme? dropzoneTheme,
  ) {
    final scaling = theme.scaling;
    final canDrop = widget.enableDragDrop && _adapter.supportsDragDrop;
    final isEnabled = widget.enabled;
    final dropzoneMinHeight =
        widget.minHeight ?? dropzoneTheme?.minHeight ?? 220 * scaling;

    final dropzone = FileDropzone(
      hotDropEnabled: canDrop,
      hotDropping: _dragActive,
      enabled: isEnabled,
      state: _mapDropzoneState(_state),
      isFocused: _focused,
      showDefaultContent: false,
      content: _buildDragDropContent(theme, scaling),
      backgroundColor: widget.backgroundColor ?? dropzoneTheme?.backgroundColor,
      borderRadius: widget.borderRadius ?? dropzoneTheme?.borderRadius,
      padding: widget.padding ?? dropzoneTheme?.padding,
      minHeight: dropzoneMinHeight,
    );

    final onTap = widget.enableDropzoneClick && widget.enabled
        ? _pickFiles
        : null;

    if (widget.dropTargetBuilder != null) {
      return widget.dropTargetBuilder!(
        child: dropzone,
        enabled: isEnabled && canDrop,
        withData: widget.withData,
        onDragActive: _setDragActive,
        onDrop: _handleDrop,
        onTap: onTap,
      );
    }

    return _adapter.buildDropTarget(
      enabled: isEnabled && canDrop,
      withData: widget.withData,
      onDragActive: _setDragActive,
      onDrop: _handleDrop,
      onTap: onTap,
      child: dropzone,
    );
  }

  Widget _buildTileSurface(
    ThemeData theme,
    FileUploadDropzoneTheme? dropzoneTheme,
  ) {
    final scaling = theme.scaling;
    final minHeight = widget.minHeight ?? 48 * scaling;
    final canPick = widget.enabled && widget.pickFiles != null;
    final backgroundColor =
        widget.backgroundColor ??
        dropzoneTheme?.backgroundColor ??
        theme.colorScheme.background;

    final buttonLabel = widget.actionLabel ?? 'Choose File';
    final selectedLabel = _tileSelectionLabel();
    final hasSelection = _effectiveItems.isNotEmpty;
    final textColor = widget.enabled
        ? theme.colorScheme.foreground
        : theme.colorScheme.mutedForeground.withOpacity(0.7);
    final fileNameColor = hasSelection
        ? textColor
        : theme.colorScheme.mutedForeground.withOpacity(
            widget.enabled ? 1 : 0.7,
          );

    return OutlinedContainer(
      borderWidth: 1,
      borderRadius: widget.borderRadius,
      backgroundColor: backgroundColor,
      boxShadow: _focused
          ? [
              BoxShadow(
                color: theme.colorScheme.ring.withOpacity(0.45),
                blurRadius: 0,
                spreadRadius: 2 * scaling,
              ),
            ]
          : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: GestureDetector(
          onTap: canPick ? _pickFiles : null,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding:
                widget.padding ??
                EdgeInsets.symmetric(
                  horizontal: theme.density.baseContainerPadding * scaling,
                  vertical: theme.density.baseGap * scaling,
                ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.density.baseContainerPadding * scaling,
                    vertical: theme.density.baseGap * scaling,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(6 * scaling),
                  ),
                  child: DefaultTextStyle.merge(
                    style: theme.typography.small
                        .merge(theme.typography.semiBold)
                        .copyWith(color: textColor),
                    child: Text(buttonLabel),
                  ),
                ),
                DensityGap(0.75),
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: theme.typography.small.copyWith(
                      color: fileNameColor,
                    ),
                    child: Text(
                      selectedLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _tileSelectionLabel() {
    final files = _effectiveItems
        .map((item) => item.file)
        .toList(growable: false);
    if (widget.tileSelectionTextBuilder != null) {
      final custom = widget.tileSelectionTextBuilder!.call(files);
      if (custom.trim().isNotEmpty) {
        return custom;
      }
    }
    if (files.isEmpty) {
      return widget.tileEmptySelectionLabel;
    }
    if (files.length == 1) {
      return files.first.name;
    }
    final firstName = files.first.name;
    final remaining = files.length - 1;
    return '$firstName +$remaining more';
  }

  @override
  void didUpdateWidget(covariant _FileUpload oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller &&
        widget.controller != null) {
      if (_controllerListenerAttached) {
        oldWidget.controller?.removeListener(_onControllerChanged);
        _controllerListenerAttached = false;
      }
      _syncControllerState();
    }

    if (widget.files != oldWidget.files && widget.files != null) {
      _errors.clear();
      _completedOnce = widget.files!.isNotEmpty ? _completedOnce : false;
    }
  }

  @override
  void dispose() {
    _dragDebounce?.cancel();
    _compactPickerPopoverController.dispose();
    _clearUploadQueue();

    if (_controllerListenerAttached) {
      widget.controller?.removeListener(_onControllerChanged);
      _controllerListenerAttached = false;
    }

    for (final sub in _uploadSubscriptions.values) {
      sub.cancel();
    }
    _uploadSubscriptions.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final dropzoneTheme = ComponentTheme.maybeOf<FileUploadDropzoneTheme>(
      context,
    );
    final isEnabled = widget.enabled;

    if (widget.surface == _FileUploadSurface.mobile) {
      return FocusableActionDetector(
        enabled: isEnabled,
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) => _pickFiles(),
          ),
        },
        onShowFocusHighlight: (value) => setState(() => _focused = value),
        child: _buildCompactPickerTrigger(),
      );
    }

    final surface = widget.surface == _FileUploadSurface.dragDrop
        ? _buildDragDropSurface(theme, dropzoneTheme)
        : _buildTileSurface(theme, dropzoneTheme);

    final shortcutMap = <ShortcutActivator, Intent>{
      const SingleActivator(LogicalKeyboardKey.enter): const ActivateIntent(),
      const SingleActivator(LogicalKeyboardKey.space): const ActivateIntent(),
    };
    final actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (_) => _pickFiles(),
      ),
    };

    final hasItems = widget.showFileList && _effectiveItems.isNotEmpty;
    final itemsMaxHeight = widget.itemsMaxHeight ?? 260 * scaling;
    final listItems = widget.allowMultiple
        ? _effectiveItems
        : [_effectiveItems.first];
    final showTileHint =
        widget.surface == _FileUploadSurface.tile && widget.hint != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitleBlock(theme),
        FocusableActionDetector(
          enabled: isEnabled,
          shortcuts: shortcutMap,
          actions: actionMap,
          onShowFocusHighlight: (value) => setState(() => _focused = value),
          child: surface,
        ),
        if (showTileHint) DensityGap(gapSm),
        if (showTileHint)
          DefaultTextStyle.merge(
            style: theme.typography.small.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            child: widget.hint!,
          ),
        if (_errors.isNotEmpty) DensityGap(gapMd),
        if (_errors.isNotEmpty)
          Semantics(
            liveRegion: true,
            container: true,
            label: _errors.map((error) => error.message).join(', '),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final error in _errors)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: theme.density.baseGap * scaling * 0.75,
                    ),
                    child: DefaultTextStyle.merge(
                      style: theme.typography.xSmall.copyWith(
                        color: theme.colorScheme.destructive,
                      ),
                      child: Text(error.message),
                    ),
                  ),
              ],
            ),
          ),
        if (hasItems) DensityGap(gapLg),
        if (hasItems)
          FileUploadItemsView(
            items: listItems,
            layout: widget.allowMultiple
                ? widget.itemsLayout
                : FileUploadItemsLayout.list,
            groupByStatus: widget.groupListByStatus,
            statusLabels: widget.statusLabels,
            columns: widget.itemsGridColumns,
            maxHeight: itemsMaxHeight,
            itemBuilder: (context, item) =>
                widget.itemBuilder?.call(context, item) ??
                FileItem(
                  item: item,
                  statusLabels: widget.statusLabels,
                  onRemove: widget.files == null
                      ? () => _removeItem(item)
                      : null,
                ),
          ),
      ],
    );
  }
}

DropzoneState _mapDropzoneState(FileUploadState state) {
  switch (state) {
    case FileUploadState.dragging:
      return DropzoneState.dragging;
    case FileUploadState.uploading:
      return DropzoneState.uploading;
    case FileUploadState.success:
      return DropzoneState.success;
    case FileUploadState.error:
      return DropzoneState.error;
    case FileUploadState.disabled:
      return DropzoneState.disabled;
    case FileUploadState.idle:
      return DropzoneState.idle;
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
