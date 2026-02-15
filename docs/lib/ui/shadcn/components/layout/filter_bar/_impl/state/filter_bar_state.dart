// Backward-compatible shim.
//
// FilterBar state models now live in `filter_bar_logic.dart` so logic can be
// used independently from the FilterBar UI widgets.
export '../../filter_bar_logic.dart'
    show
        FilterChipData,
        FilterDateRange,
        FilterSortOption,
        FilterState;
