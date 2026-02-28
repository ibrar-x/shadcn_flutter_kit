part of '../../sortable.dart';

/// _DropTransform defines a reusable type for this registry module.
class _DropTransform {
/// Stores `layer` state/configuration for this implementation.
  final _SortableLayerState layer;
/// Stores `from` state/configuration for this implementation.
  final Matrix4 from;
/// Stores `to` state/configuration for this implementation.
  final Matrix4 to;
/// Stores `child` state/configuration for this implementation.
  final Widget child;
/// Stores `state` state/configuration for this implementation.
  final _SortableState state;

/// Stores `start` state/configuration for this implementation.
  Duration? start;

  final ValueNotifier<double> progress = ValueNotifier(0);

/// Creates a `_DropTransform` instance.
  _DropTransform({
    required this.layer,
    required this.from,
    required this.to,
    required this.child,
    required this.state,
  });
}
