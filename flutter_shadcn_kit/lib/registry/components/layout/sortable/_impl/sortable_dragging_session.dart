part of '../sortable.dart';

class _SortableDraggingSession<T> {
  final GlobalKey key = GlobalKey();
  final Matrix4 transform;
  final Size size;
  final Widget ghost;
  final Widget placeholder;
  final SortableData<T> data;
  final ValueNotifier<Offset> offset;
  final _SortableLayerState layer;
  final RenderBox layerRenderBox;
  final Offset minOffset;
  final Offset maxOffset;
  final bool lock;
  final _SortableState<T> target;

  _SortableDraggingSession({
    required this.target,
    required this.layer,
    required this.layerRenderBox,
    required this.maxOffset,
    required this.transform,
    required this.size,
    required this.ghost,
    required this.placeholder,
    required this.data,
    required this.minOffset,
    required this.lock,
    required Offset offset,
  }) : offset = ValueNotifier(offset);
}

