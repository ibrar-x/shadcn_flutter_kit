import 'file_like.dart';

typedef UploadFn = Stream<double> Function(FileLike file);

enum FileUploadState { idle, dragging, uploading, success, error, disabled }

enum FileUploadItemStatus { idle, uploading, success, error }

class FileUploadItem {
  const FileUploadItem({
    required this.file,
    this.status = FileUploadItemStatus.idle,
    this.progress,
  });

  final FileLike file;
  final FileUploadItemStatus status;
  final double? progress;

  factory FileUploadItem.fromFile(FileLike file) {
    return FileUploadItem(file: file);
  }

  FileUploadItem copyWith({FileUploadItemStatus? status, double? progress}) {
    return FileUploadItem(
      file: file,
      status: status ?? this.status,
      progress: progress,
    );
  }
}

enum FileUploadErrorCode { invalidType, tooLarge, tooMany, uploadFailed }

class FileUploadError {
  const FileUploadError({required this.code, required this.message});

  final FileUploadErrorCode code;
  final String message;
}

class FileValidationResult {
  const FileValidationResult({required this.validFiles, required this.errors});

  final List<FileLike> validFiles;
  final List<FileUploadError> errors;
}
