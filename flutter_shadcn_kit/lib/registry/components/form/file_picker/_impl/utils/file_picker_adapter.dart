import 'package:flutter/widgets.dart';

import 'file_like.dart';
import 'file_picker_adapter_stub.dart'
    if (dart.library.html) 'file_picker_adapter_web.dart'
    if (dart.library.io) 'file_picker_adapter_io.dart';

/// FilePickerAdapter represents a form-related type in the registry.
abstract class FilePickerAdapter {
  /// Field storing `supportsDragDrop` for this form implementation.
  bool get supportsDragDrop;

  Widget buildDropTarget({
    required Widget child,
    required bool enabled,
    required bool withData,
    required ValueChanged<bool> onDragActive,
    required ValueChanged<List<FileLike>> onDrop,
    VoidCallback? onTap,
  });
}

/// Performs `createFilePickerAdapter` logic for this form component.
FilePickerAdapter createFilePickerAdapter() => createAdapter();
