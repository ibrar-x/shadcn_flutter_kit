part of '../../filter_bar.dart';

extension FilterStateExtensions on FilterState {
  bool get hasActiveFilters =>
      search.trim().isNotEmpty ||
      sortId != null ||
      dateRange != null ||
      chips.isNotEmpty ||
      customFilters.values.any(_isCustomFilterActive);

  int get activeFilterCount {
    var count = 0;
    if (search.trim().isNotEmpty) count += 1;
    if (sortId != null) count += 1;
    if (dateRange != null) count += 1;
    count += chips.length;
    count += customFilters.values.where(_isCustomFilterActive).length;
    return count;
  }

  FilterState withoutChip(String chipKey) {
    final next = chips
        .where((chip) => chip.key != chipKey)
        .toList(growable: false);
    return copyWith(chips: next);
  }

  FilterState cleared({FilterClearPolicy policy = const FilterClearPolicy()}) {
    return copyWith(
      search: policy.clearSearch ? '' : search,
      sortId: policy.clearSort ? null : sortId,
      dateRange: policy.clearDateRange ? null : dateRange,
      chips: policy.clearChips ? const [] : chips,
      customFilters: policy.clearCustomFilters
          ? const <String, Object?>{}
          : customFilters,
    );
  }

  T? customValue<T>(String key) {
    final value = customFilters[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  FilterState setCustomValue(String key, Object? value) {
    final next = Map<String, Object?>.of(customFilters);
    if (_isCustomFilterActive(value)) {
      next[key] = value;
    } else {
      next.remove(key);
    }
    return copyWith(customFilters: next);
  }
}

bool _isCustomFilterActive(Object? value) {
  if (value == null) return false;
  if (value is String) return value.trim().isNotEmpty;
  if (value is bool) return value;
  if (value is Iterable) return value.isNotEmpty;
  if (value is Map) return value.isNotEmpty;
  return true;
}
