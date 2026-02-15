import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/display/chip/chip.dart';
import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';

class FilterBarBasicExample extends StatefulWidget {
  const FilterBarBasicExample({super.key});

  @override
  State<FilterBarBasicExample> createState() => _FilterBarBasicExampleState();
}

class _FilterBarBasicExampleState extends State<FilterBarBasicExample> {
  static const List<FilterSortOption> _sortOptions = [
    FilterSortOption(id: 'newest', label: 'Newest'),
    FilterSortOption(id: 'oldest', label: 'Oldest'),
  ];

  static const List<String> _orders = [
    'Order #1001',
    'Order #1002',
    'Order #1003',
    'Order #1004',
    'Order #1005',
    'Order #1006',
  ];

  FilterState _state = const FilterState(
    sortId: 'newest',
    chips: [FilterChipData(key: 'tag:vip', label: 'Tag: VIP')],
  );

  @override
  Widget build(BuildContext context) {
    final visible = _filteredOrders();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterBar(
          state: _state,
          presentation: FilterBarPresentation.inline,
          sortOptions: _sortOptions,
          enableDateRange: true,
          searchDebounce: const Duration(milliseconds: 250),
          resultsCount: visible.length,
          onStateChanged: (next) {
            setState(() {
              _state = next;
            });
          },
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: visible
              .map((order) => Chip(child: Text(order)))
              .toList(growable: false),
        ),
      ],
    );
  }

  List<String> _filteredOrders() {
    final query = _state.search.trim().toLowerCase();
    var filtered = _orders
        .where(
          (item) => query.isEmpty || item.toLowerCase().contains(query),
        )
        .toList(growable: false);

    if (_state.sortId == 'newest') {
      filtered = filtered.reversed.toList(growable: false);
    }

    return filtered;
  }
}
