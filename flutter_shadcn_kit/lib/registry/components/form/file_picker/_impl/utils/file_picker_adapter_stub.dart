import 'package:flutter/widgets.dart';

import 'file_like.dart';
import 'file_picker_adapter.dart';

FilePickerAdapter createAdapter() => const _StubFilePickerAdapter();

class _StubFilePickerAdapter implements FilePickerAdapter {
  const _StubFilePickerAdapter();

  @override
  bool get supportsDragDrop => false;

  @override
  Widget buildDropTarget({
    required Widget child,
    required bool enabled,
    required bool withData,
    required ValueChanged<bool> onDragActive,
    required ValueChanged<List<FileLike>> onDrop,
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
    return const [];
  }
}
