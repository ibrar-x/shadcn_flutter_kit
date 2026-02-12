part of '../../filter_bar.dart';

/// _FilterBarContent defines a reusable type for this registry module.
class _FilterBarContent extends StatelessWidget {
/// Creates a `_FilterBarContent` instance.
  const _FilterBarContent({
    required this.state,
    required this.searchController,
    required this.sortOptions,
    required this.enableDateRange,
    required this.resultsCount,
    required this.searchPlaceholder,
    required this.searchLabel,
    required this.trailingFilters,
    required this.customFilters,
    required this.style,
    required this.showClearAllWhenEmpty,
    required this.activeFilterCountLabel,
    required this.clearAllLabel,
    required this.sortLabel,
    required this.dateRangeLabel,
    required this.onSearchChanged,
    required this.onSortChanged,
    required this.onRemoveChip,
    required this.onDateRangeChanged,
    required this.onClearDateRange,
    required this.onClearAll,
    required this.onStateChanged,
  });

/// Stores `state` state/configuration for this implementation.
  final FilterState state;
/// Stores `searchController` state/configuration for this implementation.
  final TextEditingController searchController;
/// Stores `sortOptions` state/configuration for this implementation.
  final List<FilterSortOption> sortOptions;
/// Stores `enableDateRange` state/configuration for this implementation.
  final bool enableDateRange;
/// Stores `resultsCount` state/configuration for this implementation.
  final int? resultsCount;
/// Stores `searchPlaceholder` state/configuration for this implementation.
  final String searchPlaceholder;
/// Stores `searchLabel` state/configuration for this implementation.
  final String searchLabel;
/// Stores `trailingFilters` state/configuration for this implementation.
  final List<Widget> trailingFilters;
/// Stores `customFilters` state/configuration for this implementation.
  final List<FilterCustomFilter> customFilters;
/// Stores `style` state/configuration for this implementation.
  final FilterBarStyle style;
/// Stores `showClearAllWhenEmpty` state/configuration for this implementation.
  final bool showClearAllWhenEmpty;
/// Stores `activeFilterCountLabel` state/configuration for this implementation.
  final String? activeFilterCountLabel;
/// Stores `clearAllLabel` state/configuration for this implementation.
  final String clearAllLabel;
/// Stores `sortLabel` state/configuration for this implementation.
  final String sortLabel;
/// Stores `dateRangeLabel` state/configuration for this implementation.
  final String dateRangeLabel;
/// Stores `onSearchChanged` state/configuration for this implementation.
  final ValueChanged<String> onSearchChanged;
/// Stores `onSortChanged` state/configuration for this implementation.
  final ValueChanged<String?> onSortChanged;
/// Stores `onRemoveChip` state/configuration for this implementation.
  final ValueChanged<FilterChipData> onRemoveChip;
/// Stores `onDateRangeChanged` state/configuration for this implementation.
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
/// Stores `onClearDateRange` state/configuration for this implementation.
  final VoidCallback onClearDateRange;
/// Stores `onClearAll` state/configuration for this implementation.
  final VoidCallback onClearAll;
/// Stores `onStateChanged` state/configuration for this implementation.
  final FilterStateChanged onStateChanged;

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final resolvedTheme = _FilterBarResolvedTheme.resolve(context, style);
    final countLabel = _resolveCountLabel();
/// Stores `showClearAll` state/configuration for this implementation.
    final showClearAll = showClearAllWhenEmpty || state.hasActiveFilters;

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = _FilterBarLayout.resolve(
          maxWidth: constraints.maxWidth,
          style: style,
          trailingControlCount: trailingFilters.length + customFilters.length,
          hasSortControl: sortOptions.isNotEmpty,
          hasDateControl: enableDateRange,
          hasCounterText: countLabel != null,
          hasClearAction: showClearAll,
        );

        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: resolvedTheme.borderRadius,
            border: Border.fromBorderSide(resolvedTheme.borderSide),
          ),
          child: Padding(
            padding: resolvedTheme.contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
/// Creates a `Wrap` instance.
                Wrap(
                  spacing: style.spacing,
                  runSpacing: style.runSpacing,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
/// Creates a `ConstrainedBox` instance.
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: style.minSearchWidth,
                        maxWidth: layout.maxSearchWidth,
                      ),
                      child: Semantics(
                        textField: true,
                        label: searchLabel,
                        child: TextField(
                          controller: searchController,
                          onChanged: onSearchChanged,
                          placeholder: Text(searchPlaceholder),
                          features: const [
/// Creates a `InputFeature.leading` instance.
                            InputFeature.leading(Icon(LucideIcons.search)),
/// Creates a `InputFeature.clear` instance.
                            InputFeature.clear(),
                          ],
                        ),
                      ),
                    ),
                    if (sortOptions.isNotEmpty)
/// Creates a `_buildSortControl` instance.
                      _buildSortControl(layout.sortWidth),
                    if (enableDateRange) _buildDateRangeControl(context),
                    ...customFilters.map(
                      (customFilter) =>
/// Creates a `customFilter.builder` instance.
                          customFilter.builder(context, state, onStateChanged),
                    ),
                    ...trailingFilters,
                    if (countLabel != null)
/// Creates a `Padding` instance.
                      Padding(
                        padding: EdgeInsets.only(
                          top: layout.isSingleRow ? 0 : 4,
                        ),
                        child: Text(
                          countLabel,
                          style: resolvedTheme.helperTextStyle,
                        ),
                      ),
                    if (showClearAll)
/// Creates a `GhostButton` instance.
                      GhostButton(
                        size: style.dense
                            ? ButtonSize.small
                            : ButtonSize.normal,
                        onPressed: state.hasActiveFilters ? onClearAll : null,
                        child: Text(clearAllLabel),
                      ),
                  ],
                ),
                if (state.chips.isNotEmpty) ...[
/// Creates a `SizedBox` instance.
                  SizedBox(height: style.runSpacing),
/// Creates a `Wrap` instance.
                  Wrap(
                    spacing: style.spacing,
                    runSpacing: style.runSpacing,
                    children: state.chips
                        .map(
                          (chip) => Chip(
                            trailing: ChipButton(
                              onPressed: () => onRemoveChip(chip),
                              child: const Icon(LucideIcons.x),
                            ),
                            child: Text(chip.label),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

/// Executes `_resolveCountLabel` behavior for this component/composite.
  String? _resolveCountLabel() {
    if (resultsCount != null) {
      return _formatResultsCount(resultsCount!);
    }
    if (activeFilterCountLabel != null &&
        activeFilterCountLabel!.trim().isNotEmpty) {
      return activeFilterCountLabel;
    }
/// Stores `activeCount` state/configuration for this implementation.
    final activeCount = state.activeFilterCount;
    if (activeCount > 0) {
      return _formatActiveFilterCount(activeCount);
    }
    return null;
  }

/// Executes `_resolveSortValue` behavior for this component/composite.
  String? _resolveSortValue() {
/// Stores `sortId` state/configuration for this implementation.
    final sortId = state.sortId;
    if (sortId == null) {
      return null;
    }
    final exists = sortOptions.any((option) => option.id == sortId);
    return exists ? sortId : null;
  }

/// Executes `_buildSortControl` behavior for this component/composite.
  Widget _buildSortControl(double width) {
    return SizedBox(
      width: width,
      child: Select<String>(
        value: _resolveSortValue(),
        onChanged: onSortChanged,
        placeholder: Text(sortLabel),
        itemBuilder: (context, value) {
          final option = sortOptions.firstWhere(
            (item) => item.id == value,
            orElse: () => FilterSortOption(id: value, label: value),
          );
          return Text(option.label);
        },
        popup: SelectPopup<String>(
          items: SelectItemList(
            children: sortOptions
                .map(
                  (option) => SelectItemButton<String>(
                    value: option.id,
                    child: Text(option.label),
                  ),
                )
                .toList(growable: false),
          ),
        ).call,
      ),
    );
  }

/// Executes `_buildDateRangeControl` behavior for this component/composite.
  Widget _buildDateRangeControl(BuildContext context) {
/// Stores `hasDateRange` state/configuration for this implementation.
    final hasDateRange = state.dateRange != null;
    final localizations = ShadcnLocalizations.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
/// Creates a `SizedBox` instance.
        SizedBox(
          width: style.minSortWidth,
          child: ObjectFormField<DateTimeRange>(
            mode: PromptMode.popover,
            value: state.dateRange?.toDateTimeRange(),
            onChanged: onDateRangeChanged,
            placeholder: Text(dateRangeLabel),
            trailing: const Icon(LucideIcons.calendarRange),
            builder: (context, value) {
              return Text(
/// Creates a `_formatCompactDateRangeLabel` instance.
                _formatCompactDateRangeLabel(localizations, value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            },
            editorBuilder: (context, handler) {
/// Stores `value` state/configuration for this implementation.
              DateTimeRange? value = handler.value;
              return LayoutBuilder(
                builder: (context, constraints) {
                  return DatePickerDialog(
                    selectionMode: CalendarSelectionMode.range,
                    viewMode: constraints.biggest.width < 500
                        ? CalendarSelectionMode.single
                        : CalendarSelectionMode.range,
                    initialViewType: CalendarViewType.date,
                    initialValue: value == null
                        ? null
                        : CalendarValue.range(value.start, value.end),
                    onChanged: (value) {
                      if (value == null) {
                        handler.value = null;
                      } else {
                        final range = value.toRange();
                        handler.value = DateTimeRange(range.start, range.end);
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
        if (hasDateRange)
/// Creates a `GhostButton` instance.
          GhostButton(
            onPressed: onClearDateRange,
            size: ButtonSize.small,
            child: const Icon(LucideIcons.x),
          ),
      ],
    );
  }
}
