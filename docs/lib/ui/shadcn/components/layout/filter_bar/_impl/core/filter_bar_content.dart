part of '../../filter_bar.dart';

class _FilterBarContent extends StatelessWidget {
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

  final FilterState state;
  final TextEditingController searchController;
  final List<FilterSortOption> sortOptions;
  final bool enableDateRange;
  final int? resultsCount;
  final String searchPlaceholder;
  final String searchLabel;
  final List<Widget> trailingFilters;
  final List<FilterCustomFilter> customFilters;
  final FilterBarStyle style;
  final bool showClearAllWhenEmpty;
  final String? activeFilterCountLabel;
  final String clearAllLabel;
  final String sortLabel;
  final String dateRangeLabel;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onSortChanged;
  final ValueChanged<FilterChipData> onRemoveChip;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
  final VoidCallback onClearDateRange;
  final VoidCallback onClearAll;
  final FilterStateChanged onStateChanged;

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = _FilterBarResolvedTheme.resolve(context, style);
    final countLabel = _resolveCountLabel();
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
                Wrap(
                  spacing: style.spacing,
                  runSpacing: style.runSpacing,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
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
                            InputFeature.leading(Icon(LucideIcons.search)),
                            InputFeature.clear(),
                          ],
                        ),
                      ),
                    ),
                    if (sortOptions.isNotEmpty)
                      _buildSortControl(layout.sortWidth),
                    if (enableDateRange) _buildDateRangeControl(context),
                    ...customFilters.map(
                      (customFilter) =>
                          customFilter.builder(context, state, onStateChanged),
                    ),
                    ...trailingFilters,
                    if (countLabel != null)
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
                  SizedBox(height: style.runSpacing),
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

  String? _resolveCountLabel() {
    if (resultsCount != null) {
      return _formatResultsCount(resultsCount!);
    }
    if (activeFilterCountLabel != null &&
        activeFilterCountLabel!.trim().isNotEmpty) {
      return activeFilterCountLabel;
    }
    final activeCount = state.activeFilterCount;
    if (activeCount > 0) {
      return _formatActiveFilterCount(activeCount);
    }
    return null;
  }

  String? _resolveSortValue() {
    final sortId = state.sortId;
    if (sortId == null) {
      return null;
    }
    final exists = sortOptions.any((option) => option.id == sortId);
    return exists ? sortId : null;
  }

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

  Widget _buildDateRangeControl(BuildContext context) {
    final hasDateRange = state.dateRange != null;
    final localizations = ShadcnLocalizations.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                _formatCompactDateRangeLabel(localizations, value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            },
            editorBuilder: (context, handler) {
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
          GhostButton(
            onPressed: onClearDateRange,
            size: ButtonSize.small,
            child: const Icon(LucideIcons.x),
          ),
      ],
    );
  }
}
