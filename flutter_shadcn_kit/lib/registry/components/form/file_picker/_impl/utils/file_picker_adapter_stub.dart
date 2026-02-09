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
    VoidCallback? onTap,
  }) {
    if (onTap == null || !enabled) {
      return child;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
