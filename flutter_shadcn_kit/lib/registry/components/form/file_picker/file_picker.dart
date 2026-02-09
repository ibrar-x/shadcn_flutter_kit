import 'dart:async';

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

enum FileUploadCompactMode { iconButton, iconButtonPopover }

enum FileUploadCompactTrigger { icon, button }

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

abstract class FileUpload extends Widget {
  const FileUpload({super.key});

  const factory FileUpload.dragDrop({
    Key? key,
    Widget? title,
    Widget? subtitle,
    Widget? hint,
    Widget? icon,
    bool enableDragDrop,
    bool enableDropzoneClick,
    bool enabled,
    bool allowMultiple,
    bool withData,
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
    FileUploadDropTargetBuilder? dropTargetBuilder,
    Widget Function(BuildContext context, FileUploadItem item)? itemBuilder,
    bool showFileList,
    FileUploadItemsLayout itemsLayout,
    int itemsGridColumns,
    double? itemsMaxHeight,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    double? minHeight,
  }) = FileUploadDragDrop;

  const factory FileUpload.tile({
    Key? key,
    Widget? title,
    Widget? subtitle,
    Widget? hint,
    Widget? icon,
    String? actionLabel,
    bool enabled,
    bool allowMultiple,
    bool withData,
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
    bool showFileList,
    FileUploadItemsLayout itemsLayout,
    int itemsGridColumns,
    double? itemsMaxHeight,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    double? minHeight,
  }) = FileUploadTilePicker;

  const factory FileUpload.mobile({
    Key? key,
    bool enabled,
    bool allowMultiple,
    bool withData,
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
    Widget? compactIcon,
    FileUploadCompactTrigger compactTrigger,
    String? compactButtonLabel,
    List<FileUploadPickOption>? compactOptions,
  }) = FileUploadMobilePicker;

  const factory FileUpload.mobilePopover({
    Key? key,
    bool enabled,
    bool allowMultiple,
    bool withData,
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
    Widget? compactIcon,
    FileUploadCompactTrigger compactTrigger,
    String? compactButtonLabel,
    List<FileUploadPickOption>? compactOptions,
  }) = FileUploadMobilePicker.popover;
}

class FileUploadDragDrop extends _FileUpload implements FileUpload {
  const FileUploadDragDrop({
    super.key,
    super.title,
    super.subtitle,
    super.hint,
    super.icon,
    super.enableDragDrop,
    super.enableDropzoneClick,
    super.enabled,
    super.allowMultiple,
    super.withData,
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
    super.dropTargetBuilder,
    super.itemBuilder,
    super.showFileList,
    super.itemsLayout,
    super.itemsGridColumns,
    super.itemsMaxHeight,
    super.backgroundColor,
    super.borderRadius,
    super.padding,
    super.minHeight,
  }) : super.dragDrop();
}

class FileUploadTilePicker extends _FileUpload implements FileUpload {
  const FileUploadTilePicker({
    super.key,
    super.title,
    super.subtitle,
    super.hint,
    super.icon,
    super.actionLabel,
    super.enabled,
    super.allowMultiple,
    super.withData,
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
    super.showFileList,
    super.itemsLayout,
    super.itemsGridColumns,
    super.itemsMaxHeight,
    super.backgroundColor,
    super.borderRadius,
    super.padding,
    super.minHeight,
  }) : super.tile();
}

class FileUploadMobilePicker extends _FileUpload implements FileUpload {
  const FileUploadMobilePicker({
    super.key,
    super.enabled,
    super.allowMultiple,
    super.withData,
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
    super.compactIcon,
    super.compactTrigger,
    super.compactButtonLabel,
    super.compactOptions,
  }) : super.mobile();

  const FileUploadMobilePicker.popover({
    super.key,
    super.enabled,
    super.allowMultiple,
    super.withData,
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
    super.compactIcon,
    super.compactTrigger,
    super.compactButtonLabel,
    super.compactOptions,
  }) : super.mobile(compactMode: FileUploadCompactMode.iconButtonPopover);
}

enum _FileUploadSurface { dragDrop, tile, mobile }

class _FileUpload extends StatefulWidget {
  const _FileUpload.dragDrop({
    super.key,
    this.title,
    this.subtitle,
    this.hint,
    this.icon,
    this.enableDragDrop = true,
    this.enableDropzoneClick = true,
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
    this.itemsLayout = FileUploadItemsLayout.list,
    this.itemsGridColumns = 2,
    this.itemsMaxHeight,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight,
  }) : surface = _FileUploadSurface.dragDrop,
       actionLabel = null,
       compactMode = FileUploadCompactMode.iconButton,
       compactIcon = null,
       compactTrigger = FileUploadCompactTrigger.icon,
       compactButtonLabel = null,
       compactOptions = null;

  const _FileUpload.tile({
    super.key,
    this.title,
    this.subtitle,
    this.hint,
    this.icon,
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
    this.itemBuilder,
    this.showFileList = true,
    this.itemsLayout = FileUploadItemsLayout.grid,
    this.itemsGridColumns = 2,
    this.itemsMaxHeight,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight,
  }) : surface = _FileUploadSurface.tile,
       enableDragDrop = false,
       enableDropzoneClick = false,
       dropTargetBuilder = null,
       compactMode = FileUploadCompactMode.iconButton,
       compactIcon = null,
       compactTrigger = FileUploadCompactTrigger.icon,
       compactButtonLabel = null,
       compactOptions = null;

  const _FileUpload.mobile({
    super.key,
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
    this.compactIcon,
    this.compactTrigger = FileUploadCompactTrigger.icon,
    this.compactButtonLabel,
    this.compactOptions,
    this.compactMode = FileUploadCompactMode.iconButton,
  }) : surface = _FileUploadSurface.mobile,
       title = null,
       subtitle = null,
       hint = null,
       icon = null,
       actionLabel = null,
       itemBuilder = null,
       showFileList = false,
       itemsLayout = FileUploadItemsLayout.list,
       itemsGridColumns = 2,
       itemsMaxHeight = null,
       enableDragDrop = false,
       enableDropzoneClick = false,
       dropTargetBuilder = null,
       backgroundColor = null,
       borderRadius = null,
       padding = null,
       minHeight = null;

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
  final FileUploadItemsLayout itemsLayout;
  final int itemsGridColumns;
  final double? itemsMaxHeight;

  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? minHeight;

  final FileUploadCompactMode compactMode;
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

  bool _dragActive = false;
  bool _focused = false;
  bool _completedOnce = false;
  bool _controllerListenerAttached = false;
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
    if (widget.compactMode == FileUploadCompactMode.iconButtonPopover) {
      return const [
        FileUploadPickOption.pickFiles,
        FileUploadPickOption.pickImages,
      ];
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (option.icon != null) ...[
                              option.icon!,
                              DensityGap(0.5),
                            ],
                            Text(option.label),
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
        : widget.compactMode == FileUploadCompactMode.iconButtonPopover
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
      widget.controller!.addFiles(files);
      _syncControllerState();
      if (widget.uploadFn != null) {
        widget.controller!.startUploads(widget.uploadFn!);
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
    widget.onUploadStart?.call();
    _completedOnce = false;
    for (final file in files) {
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
        },
        onDone: () {
          if (!mounted) return;
          _updateItemStatus(
            file,
            status: FileUploadItemStatus.success,
            progress: 1,
          );
          _checkUploadCompletion();
        },
      );
    }
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
    final minHeight =
        widget.minHeight ?? dropzoneTheme?.minHeight ?? 220 * scaling;
    final icon =
        widget.icon ??
        dropzoneTheme?.icon ??
        Icon(
          RadixIcons.file,
          size: 28 * scaling,
          color: widget.enabled
              ? theme.colorScheme.mutedForeground
              : theme.colorScheme.mutedForeground.withOpacity(0.5),
        );

    final buttonLabel =
        widget.actionLabel ??
        (widget.allowMultiple ? 'Add files' : 'Choose file');

    return OutlinedContainer(
      borderWidth: 1,
      borderRadius: widget.borderRadius,
      backgroundColor: widget.backgroundColor,
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
        child: Padding(
          padding:
              widget.padding ??
              EdgeInsets.all(
                theme.density.baseContainerPadding * scaling * 1.5,
              ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                DensityGap(gapMd),
                DefaultTextStyle.merge(
                  style: theme.typography.small.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                  child: const Text('Select files to upload'),
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
                DensityGap(gapLg),
                OutlineButton(
                  onPressed: widget.enabled && widget.pickFiles != null
                      ? _pickFiles
                      : null,
                  child: Text(buttonLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
            columns: widget.itemsGridColumns,
            maxHeight: itemsMaxHeight,
            itemBuilder: (context, item) =>
                widget.itemBuilder?.call(context, item) ??
                FileItem(
                  item: item,
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
