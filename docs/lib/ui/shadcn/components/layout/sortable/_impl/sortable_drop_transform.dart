part of '../sortable.dart';

class _DropTransform {
  final _SortableLayerState layer;
  final Matrix4 from;
  final Matrix4 to;
  final Widget child;
  final _SortableState state;

  Duration? start;

  final ValueNotifier<double> progress = ValueNotifier(0);

  _DropTransform({
    required this.layer,
    required this.from,
    required this.to,
    required this.child,
    required this.state,
  });
}

