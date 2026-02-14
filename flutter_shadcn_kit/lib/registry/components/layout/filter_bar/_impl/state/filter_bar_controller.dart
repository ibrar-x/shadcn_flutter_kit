part of '../../filter_bar.dart';

/// FilterBarController defines a reusable type for this registry module.
class FilterBarController extends ValueNotifier<FilterState> {
  /// Creates a `FilterBarController` instance.
  FilterBarController([super.value = const FilterState()]);

  /// Executes `setState` behavior for this component/composite.
  void setState(FilterState next) {
    if (next == value) {
      return;
    }
    value = next;
  }

  /// Executes `update` behavior for this component/composite.
  void update(FilterState Function(FilterState current) transform) {
    setState(transform(value));
  }

  /// Executes `clear` behavior for this component/composite.
  void clear({FilterClearPolicy policy = const FilterClearPolicy()}) {
    setState(value.cleared(policy: policy));
  }
}
