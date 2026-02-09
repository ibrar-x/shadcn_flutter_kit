part of '../../filter_bar.dart';

typedef FilterBarClearResolver = FilterState Function(FilterState current);
typedef FilterStateChanged = void Function(FilterState next);
typedef FilterCustomFilterBuilder =
    Widget Function(
      BuildContext context,
      FilterState state,
      FilterStateChanged onStateChanged,
    );

@immutable
class FilterCustomFilter {
  final String id;
  final FilterCustomFilterBuilder builder;

  const FilterCustomFilter({required this.id, required this.builder});
}

@immutable
class FilterBarStyle {
  final double spacing;
  final double runSpacing;
  final double minSearchWidth;
  final double minSortWidth;
  final bool dense;

  const FilterBarStyle({
    this.spacing = 12,
    this.runSpacing = 8,
    this.minSearchWidth = 220,
    this.minSortWidth = 180,
    this.dense = false,
  });

  FilterBarStyle copyWith({
    double? spacing,
    double? runSpacing,
    double? minSearchWidth,
    double? minSortWidth,
    bool? dense,
  }) {
    return FilterBarStyle(
      spacing: spacing ?? this.spacing,
      runSpacing: runSpacing ?? this.runSpacing,
      minSearchWidth: minSearchWidth ?? this.minSearchWidth,
      minSortWidth: minSortWidth ?? this.minSortWidth,
      dense: dense ?? this.dense,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterBarStyle &&
        other.spacing == spacing &&
        other.runSpacing == runSpacing &&
        other.minSearchWidth == minSearchWidth &&
        other.minSortWidth == minSortWidth &&
        other.dense == dense;
  }

  @override
  int get hashCode =>
      Object.hash(spacing, runSpacing, minSearchWidth, minSortWidth, dense);
}

@immutable
class FilterClearPolicy {
  final bool clearSearch;
  final bool clearSort;
  final bool clearDateRange;
  final bool clearChips;
  final bool clearCustomFilters;

  const FilterClearPolicy({
    this.clearSearch = true,
    this.clearSort = true,
    this.clearDateRange = true,
    this.clearChips = true,
    this.clearCustomFilters = true,
  });

  FilterClearPolicy copyWith({
    bool? clearSearch,
    bool? clearSort,
    bool? clearDateRange,
    bool? clearChips,
    bool? clearCustomFilters,
  }) {
    return FilterClearPolicy(
      clearSearch: clearSearch ?? this.clearSearch,
      clearSort: clearSort ?? this.clearSort,
      clearDateRange: clearDateRange ?? this.clearDateRange,
      clearChips: clearChips ?? this.clearChips,
      clearCustomFilters: clearCustomFilters ?? this.clearCustomFilters,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterClearPolicy &&
        other.clearSearch == clearSearch &&
        other.clearSort == clearSort &&
        other.clearDateRange == clearDateRange &&
        other.clearChips == clearChips &&
        other.clearCustomFilters == clearCustomFilters;
  }

  @override
  int get hashCode => Object.hash(
    clearSearch,
    clearSort,
    clearDateRange,
    clearChips,
    clearCustomFilters,
  );
}
