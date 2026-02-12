part of '../../sortable.dart';

/// _PendingDropTransform defines a reusable type for this registry module.
class _PendingDropTransform {
/// Stores `from` state/configuration for this implementation.
  final Matrix4 from;
/// Stores `child` state/configuration for this implementation.
  final Widget child;
/// Stores `data` state/configuration for this implementation.
  final SortableData data;

/// Creates a `_PendingDropTransform` instance.
  _PendingDropTransform({
    required this.from,
    required this.child,
    required this.data,
  });
}
