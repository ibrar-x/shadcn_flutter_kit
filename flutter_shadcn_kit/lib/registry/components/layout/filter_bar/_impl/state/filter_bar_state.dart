part of '../../filter_bar.dart';

@immutable
/// FilterState defines a reusable type for this registry module.
class FilterState {
  static const Object _sentinel = Object();

/// Stores `search` state/configuration for this implementation.
  final String search;
/// Stores `sortId` state/configuration for this implementation.
  final String? sortId;
/// Stores `dateRange` state/configuration for this implementation.
  final FilterDateRange? dateRange;
/// Stores `chips` state/configuration for this implementation.
  final List<FilterChipData> chips;
/// Stores `customFilters` state/configuration for this implementation.
  final Map<String, Object?> customFilters;

/// Creates a `FilterState` instance.
  const FilterState({
    this.search = '',
    this.sortId,
    this.dateRange,
    this.chips = const [],
    this.customFilters = const {},
  });

/// Creates a `FilterState` instance.
  FilterState copyWith({
    String? search,
    Object? sortId = _sentinel,
    Object? dateRange = _sentinel,
    List<FilterChipData>? chips,
    Object? customFilters = _sentinel,
  }) {
    return FilterState(
      search: search ?? this.search,
      sortId: identical(sortId, _sentinel) ? this.sortId : sortId as String?,
      dateRange: identical(dateRange, _sentinel)
          ? this.dateRange
          : dateRange as FilterDateRange?,
      chips: chips ?? this.chips,
      customFilters: identical(customFilters, _sentinel)
          ? this.customFilters
          : customFilters as Map<String, Object?>,
    );
  }

  @override
/// Executes `operator ==` behavior for this component/composite.
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final otherChips = other is FilterState
        ? other.chips
        : const <FilterChipData>[];
    final sameChips =
        otherChips.length == chips.length &&
/// Creates a `chips.asMap` instance.
        chips.asMap().entries.every(
          (entry) => otherChips[entry.key] == entry.value,
        );
    final otherCustomFilters = other is FilterState
        ? other.customFilters
        : const <String, Object?>{};
    final sameCustomFilters =
        otherCustomFilters.length == customFilters.length &&
        customFilters.keys.every(
          (key) =>
/// Creates a `otherCustomFilters.containsKey` instance.
              otherCustomFilters.containsKey(key) &&
              otherCustomFilters[key] == customFilters[key],
        );
    return other is FilterState &&
        other.search == search &&
        other.sortId == sortId &&
        other.dateRange == dateRange &&
        sameChips &&
        sameCustomFilters;
  }

  @override
  int get hashCode => Object.hash(
    search,
    sortId,
    dateRange,
/// Creates a `Object.hashAll` instance.
    Object.hashAll(chips),
/// Creates a `_hashCustomFilters` instance.
    _hashCustomFilters(customFilters),
  );
}

/// Executes `_hashCustomFilters` behavior for this component/composite.
int _hashCustomFilters(Map<String, Object?> values) {
  final keys = values.keys.toList()..sort();
  return Object.hashAll(keys.map((key) => Object.hash(key, values[key])));
}

@immutable
/// FilterChipData defines a reusable type for this registry module.
class FilterChipData {
/// Stores `key` state/configuration for this implementation.
  final String key;
/// Stores `label` state/configuration for this implementation.
  final String label;

  const FilterChipData({required this.key, required this.label});

  @override
/// Executes `operator ==` behavior for this component/composite.
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterChipData && other.key == key && other.label == label;
  }

  @override
  int get hashCode => Object.hash(key, label);
}

@immutable
/// FilterDateRange defines a reusable type for this registry module.
class FilterDateRange {
/// Stores `start` state/configuration for this implementation.
  final DateTime? start;
/// Stores `end` state/configuration for this implementation.
  final DateTime? end;

  const FilterDateRange({this.start, this.end});

/// Factory constructor that creates `FilterDateRange.fromDateTimeRange` instances.
  factory FilterDateRange.fromDateTimeRange(DateTimeRange range) {
    return FilterDateRange(start: range.start, end: range.end);
  }

/// Stores `isEmpty` state/configuration for this implementation.
  bool get isEmpty => start == null && end == null;

/// Executes `toDateTimeRange` behavior for this component/composite.
  DateTimeRange? toDateTimeRange() {
    if (start == null || end == null) {
      return null;
    }
    return DateTimeRange(start!, end!);
  }

  @override
/// Executes `operator ==` behavior for this component/composite.
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterDateRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hash(start, end);
}

@immutable
/// FilterSortOption defines a reusable type for this registry module.
class FilterSortOption {
/// Stores `id` state/configuration for this implementation.
  final String id;
/// Stores `label` state/configuration for this implementation.
  final String label;

  const FilterSortOption({required this.id, required this.label});

  @override
/// Executes `operator ==` behavior for this component/composite.
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterSortOption && other.id == id && other.label == label;
  }

  @override
  int get hashCode => Object.hash(id, label);
}
