import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../control/button/button.dart';
import '../../display/chip/chip.dart';
import '../../display/calendar/calendar.dart';
import '../../form/date_picker/date_picker.dart';
import '../../form/form_field/form_field.dart';
import '../../form/select/select.dart';
import '../../form/text_field/text_field.dart';
import '../../../shared/icons/lucide_icons.dart';
import '../../../shared/localizations/shadcn_localizations.dart';
import '../../../shared/theme/theme.dart';

part '_impl/core/filter_bar_content.dart';
part '_impl/extensions/filter_state_extensions.dart';
part '_impl/state/filter_bar_state.dart';
part '_impl/styles/filter_bar_style.dart';
part '_impl/themes/filter_bar_theme.dart';
part '_impl/utils/filter_bar_utils.dart';
part '_impl/variants/filter_bar_layout.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({
    super.key,
    required this.state,
    required this.onStateChanged,
    this.sortOptions = const [],
    this.enableDateRange = false,
    this.resultsCount,
    this.searchPlaceholder = 'Search',
    this.searchLabel = 'Search',
    this.searchDebounce,
    this.trailingFilters = const [],
    this.customFilters = const [],
    this.style,
    this.clearPolicy = const FilterClearPolicy(),
    this.onClearAll,
    this.showClearAllWhenEmpty = false,
    this.activeFilterCountLabel,
    this.clearAllLabel = 'Clear all',
    this.sortLabel = 'Sort',
    this.dateRangeLabel = 'Date range',
  });

  final FilterState state;
  final ValueChanged<FilterState> onStateChanged;
  final List<FilterSortOption> sortOptions;
  final bool enableDateRange;
  final int? resultsCount;
  final String searchPlaceholder;
  final String searchLabel;
  final Duration? searchDebounce;
  final List<Widget> trailingFilters;
  final List<FilterCustomFilter> customFilters;
  final FilterBarStyle? style;
  final FilterClearPolicy clearPolicy;
  final FilterBarClearResolver? onClearAll;
  final bool showClearAllWhenEmpty;
  final String? activeFilterCountLabel;
  final String clearAllLabel;
  final String sortLabel;
  final String dateRangeLabel;

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late final TextEditingController _searchController;
  _Debouncer? _searchDebouncer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.state.search);
    _syncDebouncer();
  }

  @override
  void didUpdateWidget(covariant FilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_searchController.text != widget.state.search) {
      _searchController.value = _searchController.value.copyWith(
        text: widget.state.search,
        selection: TextSelection.collapsed(offset: widget.state.search.length),
      );
    }
    if (oldWidget.searchDebounce != widget.searchDebounce) {
      _syncDebouncer();
    }
  }

  @override
  void dispose() {
    _searchDebouncer?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _syncDebouncer() {
    final debounce = widget.searchDebounce;
    if (debounce == null || debounce <= Duration.zero) {
      _searchDebouncer?.dispose();
      _searchDebouncer = null;
      return;
    }
    _searchDebouncer ??= _Debouncer(debounce);
    _searchDebouncer!.duration = debounce;
  }

  void _emit(FilterState next) {
    if (next == widget.state) {
      return;
    }
    widget.onStateChanged(next);
  }

  void _onSearchChanged(String value) {
    if (_searchDebouncer == null) {
      _emit(widget.state.copyWith(search: value));
      return;
    }
    _searchDebouncer!.schedule(() {
      if (!mounted) {
        return;
      }
      _emit(widget.state.copyWith(search: value));
    });
  }

  void _onSortChanged(String? sortId) {
    _emit(widget.state.copyWith(sortId: sortId));
  }

  void _onRemoveChip(FilterChipData chip) {
    _emit(widget.state.withoutChip(chip.key));
  }

  void _onDateRangeChanged(DateTimeRange? range) {
    _emit(
      widget.state.copyWith(
        dateRange: range == null
            ? null
            : FilterDateRange.fromDateTimeRange(range),
      ),
    );
  }

  void _onClearDateRange() {
    _emit(widget.state.copyWith(dateRange: null));
  }

  void _onClearAll() {
    final clearResolver = widget.onClearAll;
    final next = clearResolver != null
        ? clearResolver(widget.state)
        : widget.state.cleared(policy: widget.clearPolicy);
    _emit(next);
  }

  @override
  Widget build(BuildContext context) {
    return _FilterBarContent(
      state: widget.state,
      searchController: _searchController,
      sortOptions: widget.sortOptions,
      enableDateRange: widget.enableDateRange,
      resultsCount: widget.resultsCount,
      searchPlaceholder: widget.searchPlaceholder,
      searchLabel: widget.searchLabel,
      trailingFilters: widget.trailingFilters,
      customFilters: widget.customFilters,
      style: widget.style ?? const FilterBarStyle(),
      showClearAllWhenEmpty: widget.showClearAllWhenEmpty,
      activeFilterCountLabel: widget.activeFilterCountLabel,
      clearAllLabel: widget.clearAllLabel,
      sortLabel: widget.sortLabel,
      dateRangeLabel: widget.dateRangeLabel,
      onSearchChanged: _onSearchChanged,
      onSortChanged: _onSortChanged,
      onRemoveChip: _onRemoveChip,
      onDateRangeChanged: _onDateRangeChanged,
      onClearDateRange: _onClearDateRange,
      onClearAll: _onClearAll,
      onStateChanged: _emit,
    );
  }
}
