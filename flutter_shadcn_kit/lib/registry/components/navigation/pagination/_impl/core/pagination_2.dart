part of '../../pagination.dart';

class Pagination extends StatelessWidget {
  final int page;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int maxPages;
  final bool showSkipToFirstPage;
  final bool showSkipToLastPage;
  final bool hidePreviousOnFirstPage;
  final bool hideNextOnLastPage;
  final bool? showLabel;
  final double? gap;

  const Pagination({
    super.key,
    required this.page,
    required this.totalPages,
    required this.onPageChanged,
    this.maxPages = 3,
    this.showSkipToFirstPage = true,
    this.showSkipToLastPage = true,
    this.hidePreviousOnFirstPage = false,
    this.hideNextOnLastPage = false,
    this.showLabel,
    this.gap,
  });

  bool get hasPrevious => page > 1;
  bool get hasNext => page < totalPages;

  Iterable<int> get pages sync* {
    if (totalPages <= maxPages) {
      yield* List.generate(totalPages, (index) => index + 1);
    } else {
      final start = page - maxPages ~/ 2;
      final end = page + maxPages ~/ 2;
      if (start < 1) {
        yield* List.generate(maxPages, (index) => index + 1);
      } else if (end > totalPages) {
        yield* List.generate(
          maxPages,
          (index) => totalPages - maxPages + index + 1,
        );
      } else {
        yield* List.generate(maxPages, (index) => start + index);
      }
    }
  }

  int get firstShownPage {
    if (totalPages <= maxPages) {
      return 1;
    } else {
      final start = page - maxPages ~/ 2;
      return start < 1 ? 1 : start;
    }
  }

  int get lastShownPage {
    if (totalPages <= maxPages) {
      return totalPages;
    } else {
      final end = page + maxPages ~/ 2;
      return end > totalPages ? totalPages : end;
    }
  }

  bool get hasMorePreviousPages => firstShownPage > 1;
  bool get hasMoreNextPages => lastShownPage < totalPages;

  Widget _buildPreviousLabel(
    ShadcnLocalizations localizations,
    bool showLabel,
  ) {
    if (showLabel) {
      return GhostButton(
        onPressed: hasPrevious ? () => onPageChanged(page - 1) : null,
        leading: const Icon(RadixIcons.chevronLeft).iconXSmall(),
        child: Text(localizations.buttonPrevious),
      );
    }
    return GhostButton(
      onPressed: hasPrevious ? () => onPageChanged(page - 1) : null,
      child: const Icon(RadixIcons.chevronLeft).iconXSmall(),
    );
  }

  Widget _buildNextLabel(ShadcnLocalizations localizations, bool showLabel) {
    if (showLabel) {
      return GhostButton(
        onPressed: hasNext ? () => onPageChanged(page + 1) : null,
        trailing: const Icon(RadixIcons.chevronRight).iconXSmall(),
        child: Text(localizations.buttonNext),
      );
    }
    return GhostButton(
      onPressed: hasNext ? () => onPageChanged(page + 1) : null,
      child: const Icon(RadixIcons.chevronRight).iconXSmall(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<PaginationTheme>(context);
    final gapValue = styleValue(
      widgetValue: gap,
      themeValue: compTheme?.gap,
      defaultValue: 4 * scaling,
    );
    final showLabel = styleValue(
      widgetValue: this.showLabel,
      themeValue: compTheme?.showLabel,
      defaultValue: true,
    );
    final localizations = ShadcnLocalizations.of(context);

    final rowChildren = <Widget>[];
    if (!hidePreviousOnFirstPage || hasPrevious) {
      rowChildren.add(_buildPreviousLabel(localizations, showLabel));
    }
    if (hasMorePreviousPages) {
      if (showSkipToFirstPage && firstShownPage - 1 > 1) {
        rowChildren.add(
          GhostButton(
            onPressed: () => onPageChanged(1),
            child: const Text('1'),
          ),
        );
      }
      rowChildren.add(
        GhostButton(
          onPressed: () => onPageChanged(firstShownPage - 1),
          child: const MoreDots(),
        ),
      );
    }
    for (final p in pages) {
      if (p == page) {
        rowChildren.add(
          OutlineButton(onPressed: () => onPageChanged(p), child: Text('$p')),
        );
      } else {
        rowChildren.add(
          GhostButton(onPressed: () => onPageChanged(p), child: Text('$p')),
        );
      }
    }
    if (hasMoreNextPages) {
      rowChildren.add(
        GhostButton(
          onPressed: () => onPageChanged(lastShownPage + 1),
          child: const MoreDots(),
        ),
      );
      if (showSkipToLastPage && lastShownPage + 1 < totalPages) {
        rowChildren.add(
          GhostButton(
            onPressed: () => onPageChanged(totalPages),
            child: Text('$totalPages'),
          ),
        );
      }
    }
    if (!hideNextOnLastPage || hasNext) {
      rowChildren.add(_buildNextLabel(localizations, showLabel));
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _applyGap(rowChildren, gapValue),
      ),
    );
  }

  static List<Widget> _applyGap(List<Widget> children, double gap) {
    if (gap <= 0 || children.length <= 1) {
      return children;
    }
    final spaced = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i < children.length - 1) {
        spaced.add(SizedBox(width: gap));
      }
    }
    return spaced;
  }
}
