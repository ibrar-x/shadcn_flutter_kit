part of '../../filter_bar.dart';

@immutable
class FilterState {
  static const Object _sentinel = Object();

  final String search;
  final String? sortId;
  final FilterDateRange? dateRange;
  final List<FilterChipData> chips;
  final Map<String, Object?> customFilters;

  const FilterState({
    this.search = '',
    this.sortId,
    this.dateRange,
    this.chips = const [],
    this.customFilters = const {},
  });

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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final otherChips = other is FilterState
        ? other.chips
        : const <FilterChipData>[];
    final sameChips =
        otherChips.length == chips.length &&
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
    Object.hashAll(chips),
    _hashCustomFilters(customFilters),
  );
}

int _hashCustomFilters(Map<String, Object?> values) {
  final keys = values.keys.toList()..sort();
  return Object.hashAll(keys.map((key) => Object.hash(key, values[key])));
}

@immutable
class FilterChipData {
  final String key;
  final String label;

  const FilterChipData({required this.key, required this.label});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterChipData && other.key == key && other.label == label;
  }

  @override
  int get hashCode => Object.hash(key, label);
}

@immutable
class FilterDateRange {
  final DateTime? start;
  final DateTime? end;

  const FilterDateRange({this.start, this.end});

  factory FilterDateRange.fromDateTimeRange(DateTimeRange range) {
    return FilterDateRange(start: range.start, end: range.end);
  }

  bool get isEmpty => start == null && end == null;

  DateTimeRange? toDateTimeRange() {
    if (start == null || end == null) {
      return null;
    }
    return DateTimeRange(start!, end!);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterDateRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hash(start, end);
}

@immutable
class FilterSortOption {
  final String id;
  final String label;

  const FilterSortOption({required this.id, required this.label});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterSortOption && other.id == id && other.label == label;
  }

  @override
  int get hashCode => Object.hash(id, label);
}
