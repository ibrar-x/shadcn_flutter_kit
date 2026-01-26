part of '../sortable.dart';

class _PendingDropTransform {
  final Matrix4 from;
  final Widget child;
  final SortableData data;

  _PendingDropTransform({
    required this.from,
    required this.child,
    required this.data,
  });
}

