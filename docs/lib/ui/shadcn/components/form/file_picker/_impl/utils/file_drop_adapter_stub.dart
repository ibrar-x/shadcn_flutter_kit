import 'package:flutter/widgets.dart';

import 'file_drop_adapter.dart';
import 'file_like.dart';

FileDropAdapter createAdapter() => const _StubFileDropAdapter();

class _StubFileDropAdapter implements FileDropAdapter {
  const _StubFileDropAdapter();

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
