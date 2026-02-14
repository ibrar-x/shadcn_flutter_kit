part of '../../filter_bar.dart';

/// Extension helpers used by this registry module.
extension FilterStateExtensions on FilterState {
  bool get hasActiveFilters =>
      /// Creates a `search.trim` instance.
      search.trim().isNotEmpty ||
      sortId != null ||
      dateRange != null ||
      chips.isNotEmpty ||
      customFilters.entries.any(
        (entry) =>
            !_isMatcherStateKey(entry.key) &&
            _isCustomFilterActive(entry.value),
      );

  int get activeFilterCount {
    /// Stores `count` state/configuration for this implementation.
    var count = 0;
    if (search.trim().isNotEmpty) count += 1;
    if (sortId != null) count += 1;
    if (dateRange != null) count += 1;
    count += chips.length;
    count += customFilters.entries
        .where(
          (entry) =>
              !_isMatcherStateKey(entry.key) &&
              _isCustomFilterActive(entry.value),
        )
        .length;
    return count;
  }

  /// Executes `withoutChip` behavior for this component/composite.
  FilterState withoutChip(String chipKey) {
    final next = chips
        .where((chip) => chip.key != chipKey)
        .toList(growable: false);
    return copyWith(chips: next);
  }

  /// Executes `cleared` behavior for this component/composite.
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
    /// Stores `value` state/configuration for this implementation.
    final value = customFilters[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Executes `setCustomValue` behavior for this component/composite.
  FilterState setCustomValue(String key, Object? value) {
    final next = Map<String, Object?>.of(customFilters);
    if (_isCustomFilterActive(value)) {
      next[key] = value;
    } else {
      next.remove(key);
    }
    return copyWith(customFilters: next);
  }

  T? valueOf<T>(FilterField<T> field) {
    return customValue<T>(field.id);
  }

  FilterState setValue<T>(FilterField<T> field, T? value) {
    return setCustomValue(field.id, value);
  }

  String? matcherIdOf<T>(FilterField<T> field) {
    if (field.matchers.isEmpty) {
      return null;
    }
    final stored = customFilters[_matcherStateKey(field.id)];
    if (stored is String &&
        field.matchers.any((matcherOption) => matcherOption.id == stored)) {
      return stored;
    }
    return field.defaultMatcherId ?? field.matchers.first.id;
  }

  FilterState setMatcherIdOf<T>(FilterField<T> field, String? matcherId) {
    if (field.matchers.isEmpty) {
      return this;
    }
    final next = Map<String, Object?>.of(customFilters);
    final key = _matcherStateKey(field.id);
    if (matcherId == null) {
      next.remove(key);
      return copyWith(customFilters: next);
    }
    final exists = field.matchers.any(
      (matcherOption) => matcherOption.id == matcherId,
    );
    if (exists) {
      next[key] = matcherId;
    }
    return copyWith(customFilters: next);
  }

  FilterMatcherOption<T>? matcherOptionOf<T>(FilterField<T> field) {
    if (field.matchers.isEmpty) {
      return null;
    }
    final matcherId = matcherIdOf(field);
    if (matcherId == null) {
      return field.matchers.first;
    }
    for (final option in field.matchers) {
      if (option.id == matcherId) {
        return option;
      }
    }
    return field.matchers.first;
  }

  FilterMatcher<T>? matcherOf<T>(FilterField<T> field) {
    return matcherOptionOf(field)?.matcher ?? field.matcher;
  }

  bool matchesValue<T>(FilterField<T> field, Object? candidate) {
    final selected = valueOf(field);
    if (!_isCustomFilterActive(selected)) {
      return true;
    }
    final matcher = matcherOf(field) ?? FilterMatchers.exact<T>();
    return matcher.matches(selected as T, candidate);
  }
}

/// Executes `_isCustomFilterActive` behavior for this component/composite.
bool _isCustomFilterActive(Object? value) {
  if (value == null) return false;
  if (value is String) return value.trim().isNotEmpty;
  if (value is bool) return value;
  if (value is Iterable) return value.isNotEmpty;
  if (value is Map) return value.isNotEmpty;
  return true;
}

String _matcherStateKey(String fieldId) => '__matcher:$fieldId';

bool _isMatcherStateKey(String key) => key.startsWith('__matcher:');
