import 'dart:async';

import 'package:flutter/foundation.dart';

import 'file_like.dart';
import 'file_upload_models.dart';
import 'file_validation.dart';

class FileUploadController extends ChangeNotifier
    implements FileUploadControllerBase {
  FileUploadController({
    List<FileUploadItem>? initialItems,
    this.allowMultiple = true,
    this.maxFiles,
    this.maxFileSizeBytes,
    this.allowedExtensions,
    this.allowedMimeTypes,
  }) : _items = List<FileUploadItem>.from(initialItems ?? const []);

  final bool allowMultiple;
  final int? maxFiles;
  final int? maxFileSizeBytes;
  final List<String>? allowedExtensions;
  final List<String>? allowedMimeTypes;

  final List<FileUploadError> _errors = [];
  final Map<String, StreamSubscription<double>> _uploads = {};
  List<FileUploadItem> _items;

  @override
  List<FileUploadItem> get items => List.unmodifiable(_items);

  @override
  List<FileUploadError> get errors => List.unmodifiable(_errors);

  @override
  bool get isUploading => _items.any(
        (item) => item.status == FileUploadItemStatus.uploading,
      );

  @override
  bool get hasItems => _items.isNotEmpty;

  @override
  void setItems(List<FileUploadItem> items) {
    _items = List<FileUploadItem>.from(items);
    notifyListeners();
  }

  @override
  void clear() {
    _items = [];
    _errors.clear();
    notifyListeners();
  }

  @override
  void addFiles(List<FileLike> files) {
    final effectiveMaxFiles = allowMultiple ? maxFiles : (maxFiles ?? 1);
    final validation = validateFiles(
      incoming: files,
      existing: _items.map((item) => item.file).toList(),
      maxFiles: effectiveMaxFiles,
      maxFileSizeBytes: maxFileSizeBytes,
      allowedExtensions: allowedExtensions,
      allowedMimeTypes: allowedMimeTypes,
    );

    _errors
      ..clear()
      ..addAll(validation.errors);

    if (validation.validFiles.isEmpty) {
      notifyListeners();
      return;
    }

    _items.addAll(validation.validFiles.map(FileUploadItem.fromFile));
    notifyListeners();
  }

  @override
  void removeFile(FileLike file) {
    _items.removeWhere((item) => item.file.id == file.id);
    notifyListeners();
  }

  @override
  void updateItem(FileLike file, FileUploadItemStatus status, double? progress) {
    final index = _items.indexWhere((item) => item.file.id == file.id);
    if (index == -1) return;
    _items[index] = _items[index].copyWith(status: status, progress: progress);
    notifyListeners();
  }

  @override
  void startUploads(UploadFn uploadFn) {
    for (final item in _items) {
      if (item.status == FileUploadItemStatus.success) continue;
      _uploads[item.file.id]?.cancel();
      updateItem(item.file, FileUploadItemStatus.uploading, 0);
      _uploads[item.file.id] = uploadFn(item.file).listen(
        (progress) {
          final clamped = progress.clamp(0, 1).toDouble();
          updateItem(item.file, FileUploadItemStatus.uploading, clamped);
        },
        onError: (_) {
          updateItem(item.file, FileUploadItemStatus.error, null);
        },
        onDone: () {
          updateItem(item.file, FileUploadItemStatus.success, 1);
        },
      );
    }
  }

  @override
  void dispose() {
    for (final sub in _uploads.values) {
      sub.cancel();
    }
    _uploads.clear();
    super.dispose();
  }
}

abstract class FileUploadControllerBase {
  List<FileUploadItem> get items;
  List<FileUploadError> get errors;
  bool get isUploading;
  bool get hasItems;
  void setItems(List<FileUploadItem> items);
  void clear();
  void addFiles(List<FileLike> files);
  void removeFile(FileLike file);
  void updateItem(FileLike file, FileUploadItemStatus status, double? progress);
  void startUploads(UploadFn uploadFn);
}
