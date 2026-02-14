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

/// Type alias for `FilterTypedCustomFilterBuilder` used by public or internal APIs.
typedef FilterTypedCustomFilterBuilder<T> =
    Widget Function(BuildContext context, T? value, ValueChanged<T?> onChanged);

/// Type alias for `FilterMatcherCallback` used by public or internal APIs.
typedef FilterMatcherCallback<T> = bool Function(T selected, Object? candidate);

/// FilterBarMobileVariant defines a reusable type for this registry module.
enum FilterBarMobileVariant { autoSheet, inline, sheet }

@immutable
/// FilterMatcher defines a reusable type for this registry module.
class FilterMatcher<T> {
  /// Stores `_matches` state/configuration for this implementation.
  final FilterMatcherCallback<T> _matches;

  /// Creates a `FilterMatcher` instance.
  const FilterMatcher(this._matches);

  /// Executes `matches` behavior for this component/composite.
  bool matches(T selected, Object? candidate) {
    return _matches(selected, candidate);
  }
}

/// FilterMatchers defines a reusable type for this registry module.
abstract final class FilterMatchers {
  /// Executes `exact` behavior for this component/composite.
  static FilterMatcher<T> exact<T>() {
    return FilterMatcher<T>((selected, candidate) => candidate == selected);
  }

  /// Executes `contains` behavior for this component/composite.
  static FilterMatcher<String> contains({bool caseSensitive = false}) {
    return FilterMatcher<String>((selected, candidate) {
      if (candidate is! String) {
        return false;
      }
      final needle = caseSensitive ? selected : selected.toLowerCase();
      final haystack = caseSensitive ? candidate : candidate.toLowerCase();
      return haystack.contains(needle);
    });
  }

  /// Executes `like` behavior for this component/composite.
  static FilterMatcher<String> like({bool caseSensitive = false}) {
    return FilterMatcher<String>((selected, candidate) {
      if (candidate is! String) {
        return false;
      }
      final expression = _buildLikeExpression(
        selected,
        caseSensitive: caseSensitive,
      );
      return expression.hasMatch(candidate);
    });
  }

  /// Executes `startsWith` behavior for this component/composite.
  static FilterMatcher<String> startsWith({bool caseSensitive = false}) {
    return FilterMatcher<String>((selected, candidate) {
      if (candidate is! String) {
        return false;
      }
      final needle = caseSensitive ? selected : selected.toLowerCase();
      final haystack = caseSensitive ? candidate : candidate.toLowerCase();
      return haystack.startsWith(needle);
    });
  }

  /// Executes `endsWith` behavior for this component/composite.
  static FilterMatcher<String> endsWith({bool caseSensitive = false}) {
    return FilterMatcher<String>((selected, candidate) {
      if (candidate is! String) {
        return false;
      }
      final needle = caseSensitive ? selected : selected.toLowerCase();
      final haystack = caseSensitive ? candidate : candidate.toLowerCase();
      return haystack.endsWith(needle);
    });
  }

  /// Executes `anyOf` behavior for this component/composite.
  static FilterMatcher<Iterable<T>> anyOf<T>() {
    return FilterMatcher<Iterable<T>>((selected, candidate) {
      return selected.contains(candidate);
    });
  }

  /// Executes `greaterThan` behavior for this component/composite.
  static FilterMatcher<T> greaterThan<T extends Comparable<Object>>() {
    return FilterMatcher<T>((selected, candidate) {
      if (candidate is! Comparable<Object>) {
        return false;
      }
      return candidate.compareTo(selected) > 0;
    });
  }

  /// Executes `lessThan` behavior for this component/composite.
  static FilterMatcher<T> lessThan<T extends Comparable<Object>>() {
    return FilterMatcher<T>((selected, candidate) {
      if (candidate is! Comparable<Object>) {
        return false;
      }
      return candidate.compareTo(selected) < 0;
    });
  }

  static RegExp _buildLikeExpression(
    String pattern, {
    required bool caseSensitive,
  }) {
    final buffer = StringBuffer('^');
    for (var i = 0; i < pattern.length; i++) {
      final char = pattern[i];
      if (char == '%') {
        buffer.write('.*');
      } else if (char == '_') {
        buffer.write('.');
      } else {
        buffer.write(RegExp.escape(char));
      }
    }
    buffer.write(r'$');
    return RegExp(buffer.toString(), caseSensitive: caseSensitive);
  }
}

@immutable
/// FilterField defines a reusable type for this registry module.
class FilterField<T> {
  /// Stores `id` state/configuration for this implementation.
  final String id;

  /// Stores `label` state/configuration for this implementation.
  final String? label;

  /// Stores `matcher` state/configuration for this implementation.
  final FilterMatcher<T>? matcher;

  /// Creates a `FilterField` instance.
  const FilterField({required this.id, this.label, this.matcher});
}

@immutable
/// FilterCustomFilter defines a reusable type for this registry module.
class FilterCustomFilter {
  /// Stores `id` state/configuration for this implementation.
  final String id;

  /// Stores `builder` state/configuration for this implementation.
  final FilterCustomFilterBuilder builder;

  const FilterCustomFilter({required this.id, required this.builder});

  /// Executes `typed` behavior for this component/composite.
  static FilterCustomFilter typed<T>({
    required FilterField<T> field,
    required FilterTypedCustomFilterBuilder<T> builder,
  }) {
    return FilterCustomFilter(
      id: field.id,
      builder: (context, state, onStateChanged) {
        return builder(context, state.valueOf<T>(field), (next) {
          onStateChanged(state.setValue<T>(field, next));
        });
      },
    );
  }
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
