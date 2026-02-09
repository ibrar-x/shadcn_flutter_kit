import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'filter_bar_basic_example.dart';
import 'filter_bar_clear_policy_example.dart';
import 'filter_bar_custom_buttons_example.dart';
import 'filter_bar_custom_selects_example.dart';

const ComponentExample filterBarBasicExample = ComponentExample(
  title: 'Basic Search, Sort, and Chips',
  builder: _buildFilterBarBasicExample,
  code:
      r'''import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';

class FilterBarBasicExample extends StatefulWidget {
  const FilterBarBasicExample({super.key});

  @override
  State<FilterBarBasicExample> createState() => _FilterBarBasicExampleState();
}

class _FilterBarBasicExampleState extends State<FilterBarBasicExample> {
  FilterState state = const FilterState(
    sortId: 'newest',
    chips: [FilterChipData(key: 'tag:vip', label: 'Tag: VIP')],
  );

  @override
  Widget build(BuildContext context) {
    return FilterBar(
      state: state,
      sortOptions: const [
        FilterSortOption(id: 'newest', label: 'Newest'),
        FilterSortOption(id: 'oldest', label: 'Oldest'),
      ],
      searchDebounce: const Duration(milliseconds: 250),
      onStateChanged: (next) => setState(() => state = next),
    );
  }
}
''',
);

Widget _buildFilterBarBasicExample(BuildContext context) {
  return const FilterBarBasicExample();
}

const ComponentExample filterBarCustomSelectsExample = ComponentExample(
  title: 'Custom Filters with Select Controls',
  builder: _buildFilterBarCustomSelectsExample,
  code: r'''FilterBar(
  state: state,
  enableDateRange: true,
  customFilters: [
    FilterCustomFilter(
      id: 'status',
      builder: (context, state, onStateChanged) {
        return Select<String>(
          value: state.customValue<String>('status'),
          canUnselect: true,
          placeholder: const Text('Status'),
          onChanged: (next) {
            onStateChanged(state.setCustomValue('status', next));
          },
          itemBuilder: (context, value) => Text(value),
          popup: SelectPopup<String>(
            items: SelectItemList(
              children: const [
                SelectItemButton(value: 'open', child: Text('Open')),
                SelectItemButton(value: 'closed', child: Text('Closed')),
              ],
            ),
          ).call,
        );
      },
    ),
  ],
  onStateChanged: (next) => setState(() => state = next),
)
''',
);

Widget _buildFilterBarCustomSelectsExample(BuildContext context) {
  return const FilterBarCustomSelectsExample();
}

const ComponentExample filterBarCustomButtonsExample = ComponentExample(
  title: 'Custom Filter with Button Group',
  builder: _buildFilterBarCustomButtonsExample,
  code: r'''FilterCustomFilter(
  id: 'urgency',
  builder: (context, state, onStateChanged) {
    final urgency = state.customValue<String>('urgency');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GhostButton(
          size: ButtonSize.small,
          onPressed: () => onStateChanged(state.setCustomValue('urgency', null)),
          child: const Text('All'),
        ),
        SecondaryButton(
          size: ButtonSize.small,
          onPressed: () => onStateChanged(
            state.setCustomValue('urgency', 'urgent_only'),
          ),
          child: const Text('Urgent'),
        ),
      ],
    );
  },
)
''',
);

Widget _buildFilterBarCustomButtonsExample(BuildContext context) {
  return const FilterBarCustomButtonsExample();
}

const ComponentExample filterBarClearPolicyExample = ComponentExample(
  title: 'Clear Policy Preserving Custom Filters',
  builder: _buildFilterBarClearPolicyExample,
  code: r'''FilterBar(
  state: state,
  clearPolicy: const FilterClearPolicy(
    clearSearch: true,
    clearSort: true,
    clearDateRange: true,
    clearChips: true,
    clearCustomFilters: false,
  ),
  customFilters: [
    // status/team filters here
  ],
  onStateChanged: (next) => setState(() => state = next),
)
''',
);

Widget _buildFilterBarClearPolicyExample(BuildContext context) {
  return const FilterBarClearPolicyExample();
}

const List<ComponentExample> filterBarExamples = [
  filterBarBasicExample,
  filterBarCustomSelectsExample,
  filterBarCustomButtonsExample,
  filterBarClearPolicyExample,
];
