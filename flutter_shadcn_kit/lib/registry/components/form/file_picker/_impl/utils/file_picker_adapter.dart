import 'package:flutter/widgets.dart';

import 'file_like.dart';
import 'file_picker_adapter_stub.dart'
    if (dart.library.html) 'file_picker_adapter_web.dart'
    if (dart.library.io) 'file_picker_adapter_io.dart';

abstract class FilePickerAdapter {
  bool get supportsDragDrop;

  Future<List<FileLike>> pickFiles({
    required bool allowMultiple,
    required bool withData,
    List<String>? allowedExtensions,
    List<String>? allowedMimeTypes,
  });

  Widget buildDropTarget({
    required Widget child,
    required bool enabled,
    required bool withData,
    required ValueChanged<bool> onDragActive,
    required ValueChanged<List<FileLike>> onDrop,
  });
}

FilePickerAdapter createFilePickerAdapter() => createAdapter();
