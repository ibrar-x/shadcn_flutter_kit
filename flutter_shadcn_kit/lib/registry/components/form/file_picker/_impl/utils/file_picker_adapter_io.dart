import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/widgets.dart';

import 'file_like.dart';
import 'file_picker_adapter.dart';

FilePickerAdapter createAdapter() => const _IoFilePickerAdapter();

class _IoFilePickerAdapter implements FilePickerAdapter {
  const _IoFilePickerAdapter();

  @override
  bool get supportsDragDrop => false;

  @override
  Widget buildDropTarget({
    required Widget child,
    required bool enabled,
    required bool withData,
    required ValueChanged<bool> onDragActive,
    required ValueChanged<List<FileLike>> onDrop,
    VoidCallback? onTap,
  }) {
    return child;
  }

  @override
  Future<List<FileLike>> pickFiles({
    required bool allowMultiple,
    required bool withData,
    List<String>? allowedExtensions,
    List<String>? allowedMimeTypes,
  }) async {
    final result = await fp.FilePicker.pickFiles(
      allowMultiple: allowMultiple,
      withData: withData,
      type: (allowedExtensions != null && allowedExtensions.isNotEmpty)
          ? fp.FileType.custom
          : fp.FileType.any,
      allowedExtensions:
          (allowedExtensions != null && allowedExtensions.isNotEmpty)
          ? allowedExtensions.map((ext) => ext.replaceFirst('.', '')).toList()
          : null,
    );
    if (result == null) return const [];
    return result.files.map(_fromPlatformFile).toList();
  }

  FileLike _fromPlatformFile(fp.PlatformFile file) {
    return FileLike(
      id:
          file.identifier ??
          '${DateTime.now().microsecondsSinceEpoch}-${file.name}',
      name: file.name,
      size: file.size,
      bytes: file.bytes,
      path: file.path,
      extension: file.extension,
      source: file,
    );
  }
}
