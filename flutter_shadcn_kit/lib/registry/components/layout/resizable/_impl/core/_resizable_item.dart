part of '../../resizable.dart';

class _ResizableItem extends ResizableItem {
  _ResizableItem({
    required super.value,
    super.min,
    super.max,
    super.collapsed,
    super.collapsedSize,
    required this.controller,
  });

  final ResizablePaneController controller;
}
