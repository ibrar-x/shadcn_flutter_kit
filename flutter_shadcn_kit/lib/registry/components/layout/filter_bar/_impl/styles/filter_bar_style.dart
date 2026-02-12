part of '../../filter_bar.dart';

/// Type alias for `FilterBarClearResolver` used by public or internal APIs.
typedef FilterBarClearResolver = FilterState Function(FilterState current);
/// Type alias for `FilterStateChanged` used by public or internal APIs.
typedef FilterStateChanged = void Function(FilterState next);
/// Type alias for `FilterCustomFilterBuilder` used by public or internal APIs.
typedef FilterCustomFilterBuilder =
    Widget Function(
      BuildContext context,
      FilterState state,
      FilterStateChanged onStateChanged,
    );

@immutable
/// FilterCustomFilter defines a reusable type for this registry module.
class FilterCustomFilter {
/// Stores `id` state/configuration for this implementation.
  final String id;
/// Stores `builder` state/configuration for this implementation.
  final FilterCustomFilterBuilder builder;

  const FilterCustomFilter({required this.id, required this.builder});
}

@immutable
/// FilterBarStyle defines a reusable type for this registry module.
class FilterBarStyle {
/// Stores `spacing` state/configuration for this implementation.
  final double spacing;
/// Stores `runSpacing` state/configuration for this implementation.
  final double runSpacing;
/// Stores `minSearchWidth` state/configuration for this implementation.
  final double minSearchWidth;
/// Stores `minSortWidth` state/configuration for this implementation.
  final double minSortWidth;
/// Stores `dense` state/configuration for this implementation.
  final bool dense;

/// Creates a `FilterBarStyle` instance.
  const FilterBarStyle({
    this.spacing = 12,
    this.runSpacing = 8,
    this.minSearchWidth = 220,
    this.minSortWidth = 180,
    this.dense = false,
  });

/// Creates a `FilterBarStyle` instance.
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
/// Executes `operator ==` behavior for this component/composite.
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
/// FilterClearPolicy defines a reusable type for this registry module.
class FilterClearPolicy {
/// Stores `clearSearch` state/configuration for this implementation.
  final bool clearSearch;
/// Stores `clearSort` state/configuration for this implementation.
  final bool clearSort;
/// Stores `clearDateRange` state/configuration for this implementation.
  final bool clearDateRange;
/// Stores `clearChips` state/configuration for this implementation.
  final bool clearChips;
/// Stores `clearCustomFilters` state/configuration for this implementation.
  final bool clearCustomFilters;

/// Creates a `FilterClearPolicy` instance.
  const FilterClearPolicy({
    this.clearSearch = true,
    this.clearSort = true,
    this.clearDateRange = true,
    this.clearChips = true,
    this.clearCustomFilters = true,
  });

/// Creates a `FilterClearPolicy` instance.
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
/// Executes `operator ==` behavior for this component/composite.
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
