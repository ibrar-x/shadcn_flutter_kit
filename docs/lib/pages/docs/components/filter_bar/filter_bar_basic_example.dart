import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';
import 'package:docs/ui/shadcn/components/layout/outlined_container/outlined_container.dart';

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
    return OutlinedContainer(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBar(
            state: _state,
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
          Text('Visible orders: ${visible.join(', ')}'),
        ],
      ),
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
