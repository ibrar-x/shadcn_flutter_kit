part of '../../filter_bar.dart';

class _FilterBarLayout {
  final bool isSingleRow;
  final double maxSearchWidth;
  final double sortWidth;

  const _FilterBarLayout({
    required this.isSingleRow,
    required this.maxSearchWidth,
    required this.sortWidth,
  });

  factory _FilterBarLayout.resolve({
    required double maxWidth,
    required FilterBarStyle style,
    required int trailingControlCount,
    required bool hasSortControl,
    required bool hasDateControl,
    required bool hasCounterText,
    required bool hasClearAction,
  }) {
    if (!maxWidth.isFinite || maxWidth <= 0) {
      return _FilterBarLayout(
        isSingleRow: false,
        maxSearchWidth: double.infinity,
        sortWidth: style.minSortWidth,
      );
    }

    final controlCount =
        1 +
        (hasSortControl ? 1 : 0) +
        (hasDateControl ? 1 : 0) +
        trailingControlCount +
        (hasCounterText ? 1 : 0) +
        (hasClearAction ? 1 : 0);
    final gapWidth = style.spacing * (controlCount > 1 ? controlCount - 1 : 0);
    final minWidth =
        style.minSearchWidth +
        (hasSortControl ? style.minSortWidth : 0) +
        (hasDateControl ? 164 : 0) +
        (trailingControlCount * 140) +
        (hasCounterText ? 90 : 0) +
        (hasClearAction ? 86 : 0) +
        gapWidth;

    final isSingleRow = maxWidth >= minWidth;
    return _FilterBarLayout(
      isSingleRow: isSingleRow,
      maxSearchWidth: isSingleRow ? maxWidth * 0.42 : double.infinity,
      sortWidth: style.minSortWidth,
    );
  }
}
