part of '../sortable.dart';

class _DroppingTarget<T> {
  final _SortableState<T> source;
  final ValueNotifier<_SortableDraggingSession<T>?> candidate;
  final _SortableDropLocation location;

  _DroppingTarget({
    required this.source,
    required this.candidate,
    required this.location,
  });

  void dispose(_SortableDraggingSession<T> target) {
    if (candidate.value == target) {
      candidate.value = null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _DroppingTarget<T> &&
        other.source == source &&
        other.candidate == candidate &&
        other.location == location;
  }

  @override
  int get hashCode => Object.hash(source, candidate, location);

  @override
  String toString() => '_DroppingTarget($source, $location)';
}

