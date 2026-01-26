---
title: "Class: Pagination"
description: "Widget that renders pagination controls with page buttons and navigation arrows."
---

```dart
/// Widget that renders pagination controls with page buttons and navigation arrows.
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
  const Pagination({super.key, required this.page, required this.totalPages, required this.onPageChanged, this.maxPages = 3, this.showSkipToFirstPage = true, this.showSkipToLastPage = true, this.hidePreviousOnFirstPage = false, this.hideNextOnLastPage = false, this.showLabel, this.gap});
  bool get hasPrevious;
  bool get hasNext;
  Iterable<int> get pages;
  int get firstShownPage;
  int get lastShownPage;
  bool get hasMorePreviousPages;
  bool get hasMoreNextPages;
  Widget build(BuildContext context);
}
```
