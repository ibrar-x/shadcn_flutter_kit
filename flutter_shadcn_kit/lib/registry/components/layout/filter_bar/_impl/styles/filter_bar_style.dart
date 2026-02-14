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

/// Type alias for `FilterSheetItemBuilder` used by public or internal APIs.
typedef FilterSheetItemBuilder =
    Widget Function(
      BuildContext context,
      FilterState state,
      FilterStateChanged onStateChanged,
    );

/// Type alias for `FilterMatcherCallback` used by public or internal APIs.
typedef FilterMatcherCallback<T> = bool Function(T selected, Object? candidate);

/// FilterBarPresentation defines a reusable type for this registry module.
enum FilterBarPresentation { autoSheet, inline, sheet }

/// Backward compatibility alias.
typedef FilterBarMobileVariant = FilterBarPresentation;

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

  /// Executes `inSet` behavior for this component/composite.
  static FilterMatcher<Set<T>> inSet<T>() {
    return FilterMatcher<Set<T>>((selected, candidate) {
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
/// FilterMatcherOption defines a reusable type for this registry module.
class FilterMatcherOption<T> {
  /// Stores `id` state/configuration for this implementation.
  final String id;

  /// Stores `label` state/configuration for this implementation.
  final String label;

  /// Stores `matcher` state/configuration for this implementation.
  final FilterMatcher<T> matcher;

  /// Creates a `FilterMatcherOption` instance.
  const FilterMatcherOption({
    required this.id,
    required this.label,
    required this.matcher,
  });
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

  /// Stores `matchers` state/configuration for this implementation.
  final List<FilterMatcherOption<T>> matchers;

  /// Stores `defaultMatcherId` state/configuration for this implementation.
  final String? defaultMatcherId;

  /// Creates a `FilterField` instance.
  const FilterField({
    required this.id,
    this.label,
    this.matcher,
    this.matchers = const [],
    this.defaultMatcherId,
  });
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
/// FilterGroup defines a reusable type for this registry module.
class FilterGroup {
  /// Stores `id` state/configuration for this implementation.
  final String id;

  /// Stores `title` state/configuration for this implementation.
  final String title;

  /// Stores `filterIds` state/configuration for this implementation.
  final List<String> filterIds;

  /// Stores `itemBuilder` state/configuration for this implementation.
  final FilterSheetItemBuilder? itemBuilder;

  /// Creates a `FilterGroup` instance.
  const FilterGroup({
    required this.id,
    required this.title,
    this.filterIds = const [],
    this.itemBuilder,
  });
}

/// Backward compatibility alias.
typedef FilterMobileGroup = FilterGroup;

/// FilterBarSheetScaffold defines a reusable type for this registry module.
class FilterBarSheetScaffold extends StatelessWidget {
  /// Creates a `FilterBarSheetScaffold` instance.
  const FilterBarSheetScaffold({
    super.key,
    required this.title,
    required this.child,
    this.onClose,
    this.footer,
    this.maxHeight = 560,
    this.margin = const EdgeInsets.fromLTRB(12, 8, 12, 12),
  });

  /// Stores `title` state/configuration for this implementation.
  final String title;

  /// Stores `child` state/configuration for this implementation.
  final Widget child;

  /// Stores `onClose` state/configuration for this implementation.
  final VoidCallback? onClose;

  /// Stores `footer` state/configuration for this implementation.
  final Widget? footer;

  /// Stores `maxHeight` state/configuration for this implementation.
  final double maxHeight;

  /// Stores `margin` state/configuration for this implementation.
  final EdgeInsetsGeometry margin;

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return SafeArea(
      top: false,
      child: Padding(
        padding: margin,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.card,
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(16 * scaling),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.foreground.withOpacity(0.08),
                blurRadius: 24 * scaling,
                offset: Offset(0, 10 * scaling),
              ),
            ],
          ),
          padding: EdgeInsets.all(16 * scaling),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight * scaling),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(title, style: theme.typography.large)),
                    GhostButton(
                      onPressed: onClose ?? () => closeSheet(context),
                      size: ButtonSize.small,
                      child: const Icon(LucideIcons.x),
                    ),
                  ],
                ),
                SizedBox(height: 12 * scaling),
                Flexible(child: SingleChildScrollView(child: child)),
                if (footer != null) ...[
                  SizedBox(height: 12 * scaling),
                  footer!,
                ],
              ],
            ),
          ),
        ),
      ),
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
