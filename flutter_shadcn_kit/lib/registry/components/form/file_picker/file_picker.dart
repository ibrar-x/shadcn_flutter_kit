import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '_impl/utils/file_like.dart';
import '_impl/utils/file_upload_models.dart';
import '_impl/utils/file_validation.dart';
import '_impl/utils/file_picker_adapter.dart';
import '../../../shared/icons/radix_icons.dart';
import '../../../shared/primitives/outlined_container.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/geometry_extensions.dart';
import '../../control/button/button.dart';
import '../../display/linear_progress_indicator/linear_progress_indicator.dart';
import '../dropzone/dropzone.dart';
import '../file_input/file_input.dart';
import '_impl/utils/file_upload_controller.dart';
import '_impl/themes/file_upload_dropzone_theme.dart';

export '_impl/utils/file_like.dart';
export '_impl/utils/file_upload_models.dart';
export '_impl/utils/file_upload_controller.dart';
export '_impl/themes/file_upload_dropzone_theme.dart';

part '_impl/core/file_item.dart';
part '_impl/core/file_upload_items_view.dart';

// const fileByteUnits = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
// const fileBitUnits = ['Bi', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
// String formatFileSize(int bytes, List<String> units) {
//   if (bytes <= 0) return '0 ${units[0]}';
//   final
// }

/// A file upload widget for selecting and managing file uploads.
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
/// FileUpload(
///   title: Text('Upload Documents'),
///   subtitle: Text('Drag files here or click to browse'),
///   onFilesSelected: (files) => _onFilesSelected(files),
///   uploadFn: (file) => _uploadFile(file),
/// )
/// ```
class FileUpload extends StatefulWidget {
  /// Title widget displayed above the file picker.
  final Widget? title;

  /// Subtitle widget displayed below the title.
  final Widget? subtitle;

  /// Whether drag-and-drop functionality is enabled.
  final bool enableDragDrop;

  /// Whether file selection is enabled.
  final bool enabled;

  /// Whether multiple file selection is allowed.
  final bool allowMultiple;

  /// Whether file bytes should be eagerly loaded.
  final bool withData;

  /// Maximum number of files allowed, including existing files.
  final int? maxFiles;

  /// Maximum file size in bytes.
  final int? maxFileSizeBytes;

  /// Allowed file extensions (without dots).
  final List<String>? allowedExtensions;

  /// Allowed mime types (supports wildcards like image/*).
  final List<String>? allowedMimeTypes;

  /// Optional list of files to display (controlled).
  final List<FileLike>? files;

  /// Optional controller to manage files and uploads.
  final FileUploadController? controller;

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

  /// Called when new files are selected and validated.
  final ValueChanged<List<FileLike>>? onFilesSelected;

  /// Called when the internal file list changes (uncontrolled mode).
  final ValueChanged<List<FileLike>>? onFilesChanged;

  /// Called when uploads begin.
  final VoidCallback? onUploadStart;

  /// Called as upload progress updates.
  final void Function(FileLike file, double progress)? onProgress;

  /// Called when all uploads complete successfully.
  final ValueChanged<List<FileLike>>? onComplete;

  /// Called for validation or upload errors.
  final ValueChanged<FileUploadError>? onError;

  /// Optional upload function that returns progress stream.
  final UploadFn? uploadFn;

  /// Optional builder for file list items.
  final Widget Function(BuildContext context, FileUploadItem item)? itemBuilder;

  /// Whether the file list should be shown.
  final bool showFileList;

  /// Optional layout for the built-in items view.
  final FileUploadItemsLayout itemsLayout;

  /// Optional column count when [itemsLayout] is grid.
  final int itemsGridColumns;

  /// Optional max height for the items list before it scrolls.
  final double? itemsMaxHeight;

  /// Creates a [FileUpload].
  ///
  /// Parameters:
  /// - [title] (`Widget?`, optional): Title displayed above picker.
  /// - [subtitle] (`Widget?`, optional): Subtitle below title.
  /// - [enableDragDrop] (`bool`, default: `true`): Enable drag-and-drop.
  /// - [enabled] (`bool`, default: `true`): Enable picking/uploading.
  /// - [allowMultiple] (`bool`, default: `true`): Allow multi-file picking.
  /// - [uploadFn] (`UploadFn?`, optional): Upload handler for progress.
  const FileUpload({
    super.key,
    this.title,
    this.subtitle,
    this.enableDragDrop = true,
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
    this.itemBuilder,
    this.showFileList = true,
    this.itemsLayout = FileUploadItemsLayout.list,
    this.itemsGridColumns = 2,
    this.itemsMaxHeight,
    this.hint,
    this.actionLabel,
    this.icon,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight,
  });

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  final FilePickerAdapter _adapter = createFilePickerAdapter();
  final List<FileUploadItem> _items = [];
  final List<FileUploadError> _errors = [];
  final Map<String, StreamSubscription<double>> _uploadSubscriptions = {};
  bool _dragActive = false;
  Timer? _dragDebounce;
  bool _focused = false;
  bool _completedOnce = false;

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
    if (!mounted) return;
    if (_controllerListenerAttached) return;
    widget.controller?.addListener(_onControllerChanged);
    _controllerListenerAttached = true;
    _onControllerChanged();
  }

  bool _controllerListenerAttached = false;

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
    if (!widget.enabled) return;
    final files = await _adapter.pickFiles(
      allowMultiple: widget.allowMultiple,
      allowedExtensions: widget.allowedExtensions,
      allowedMimeTypes: widget.allowedMimeTypes,
      withData: widget.withData,
    );
    if (!mounted || files.isEmpty) return;
    _handleNewFiles(files);
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
        onError: (Object error) {
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
    if (_items.any((item) => item.status == FileUploadItemStatus.uploading)) {
      return;
    }
    if (_items.isEmpty) {
      _completedOnce = false;
      setState(() {});
      return;
    }
    _completedOnce = true;
    if (_errors.isEmpty) {
      widget.onComplete?.call(_items.map((item) => item.file).toList());
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

  @override
  void didUpdateWidget(covariant FileUpload oldWidget) {
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
    final canDrop = widget.enableDragDrop && _adapter.supportsDragDrop;
    final dropzoneMinHeight =
        widget.minHeight ?? dropzoneTheme?.minHeight ?? 220 * scaling;
    final itemsMaxHeight = widget.itemsMaxHeight ?? 260 * scaling;
    final shortcutMap = <ShortcutActivator, Intent>{
      const SingleActivator(LogicalKeyboardKey.enter): const ActivateIntent(),
      const SingleActivator(LogicalKeyboardKey.space): const ActivateIntent(),
    };
    final actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) => _pickFiles(),
      ),
    };
    final singleItemContent =
        (!widget.allowMultiple && _effectiveItems.isNotEmpty)
        ? FileUploadItemsView(
            items: [_effectiveItems.first],
            layout: FileUploadItemsLayout.list,
            showContainer: false,
            itemBuilder: widget.itemBuilder,
          )
        : null;
    final dropzone = FileDropzone(
      hotDropEnabled: canDrop,
      hotDropping: _dragActive,
      enabled: isEnabled,
      state: _mapDropzoneState(_state),
      isFocused: _focused,
      showDefaultContent: widget.allowMultiple || _effectiveItems.isEmpty,
      content: singleItemContent,
      hint: widget.hint,
      icon: widget.icon ?? dropzoneTheme?.icon,
      actionLabel: widget.actionLabel,
      onPressed: isEnabled ? _pickFiles : null,
      backgroundColor: widget.backgroundColor ?? dropzoneTheme?.backgroundColor,
      borderRadius: widget.borderRadius ?? dropzoneTheme?.borderRadius,
      padding: widget.padding ?? dropzoneTheme?.padding,
      minHeight: dropzoneMinHeight,
    );
    final dropTarget = _adapter.buildDropTarget(
      enabled: isEnabled && canDrop,
      withData: widget.withData,
      onDragActive: _setDragActive,
      onDrop: _handleDrop,
      onTap: isEnabled ? _pickFiles : null,
      child: dropzone,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title != null || widget.subtitle != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null)
                DefaultTextStyle.merge(
                  style: theme.typography.large.merge(
                    theme.typography.semiBold,
                  ),
                  child: widget.title!,
                ),
              if (widget.subtitle != null) Gap(6 * scaling),
              if (widget.subtitle != null)
                DefaultTextStyle.merge(
                  style: theme.typography.small.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                  child: widget.subtitle!,
                ),
              Gap(16 * scaling),
            ],
          ),
        FocusableActionDetector(
          enabled: isEnabled,
          shortcuts: shortcutMap,
          actions: actionMap,
          onShowFocusHighlight: (value) => setState(() => _focused = value),
          child: dropTarget,
        ),
        if (_errors.isNotEmpty) Gap(12 * scaling),
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
                    padding: EdgeInsets.only(bottom: 6 * scaling),
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
        if (widget.showFileList &&
            _effectiveItems.isNotEmpty &&
            widget.allowMultiple)
          Gap(16 * scaling),
        if (widget.showFileList &&
            _effectiveItems.isNotEmpty &&
            widget.allowMultiple)
          FileUploadItemsView(
            items: _effectiveItems,
            layout: widget.itemsLayout,
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
