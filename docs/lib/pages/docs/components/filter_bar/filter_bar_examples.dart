import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'filter_bar_basic_example.dart';
import 'filter_bar_clear_policy_example.dart';
import 'filter_bar_custom_buttons_example.dart';
import 'filter_bar_custom_selects_example.dart';

const ComponentExample filterBarBasicExample = ComponentExample(
  title: 'Simple',
  builder: _buildFilterBarBasicExample,
  code:
      r'''import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';
import 'package:docs/ui/shadcn/components/layout/outlined_container/outlined_container.dart';

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
    return OutlinedContainer(
      padding: const EdgeInsets.all(12),
      child: FilterBar(
        state: state,
        sortOptions: const [
          FilterSortOption(id: 'newest', label: 'Newest'),
          FilterSortOption(id: 'oldest', label: 'Oldest'),
        ],
        enableDateRange: true,
        searchDebounce: const Duration(milliseconds: 250),
        onStateChanged: (next) => setState(() => state = next),
      ),
    );
  }
}
''',
);

Widget _buildFilterBarBasicExample(BuildContext context) {
  return const FilterBarBasicExample();
}

const ComponentExample filterBarCustomSelectsExample = ComponentExample(
  title: 'Intermediate',
  builder: _buildFilterBarCustomSelectsExample,
  code: r'''final statusField = FilterField<String>(
  id: 'status',
  matcher: FilterMatchers.exact<String>(),
);

final assigneeField = FilterField<String>(
  id: 'assignee_query',
  defaultMatcherId: 'contains',
  matchers: [
    FilterMatcherOption(
      id: 'contains',
      label: 'Contains',
      matcher: FilterMatchers.contains(),
    ),
    FilterMatcherOption(
      id: 'starts_with',
      label: 'Starts with',
      matcher: FilterMatchers.startsWith(),
    ),
  ],
);

FilterBar(
  state: state,
  customFilters: [
    FilterCustomFilter.typed<String>(
      field: statusField,
      builder: (context, value, onChanged) {
        return Select<String>(
          value: value,
          canUnselect: true,
          placeholder: const Text('Status'),
          onChanged: onChanged,
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
  title: 'Advanced',
  builder: _buildFilterBarCustomButtonsExample,
  code: r'''FilterBar(
  state: state,
  presentation: FilterBarPresentation.autoSheet,
  sheetBreakpoint: 980,
  groups: const [
    FilterGroup(
      id: 'quick',
      title: 'Quick',
      filterIds: ['urgency', 'assignee'],
    ),
    FilterGroup(
      id: 'channels',
      title: 'Channels',
      filterIds: ['channels'],
    ),
  ],
  customFilters: [
    // button group + select + checkbox-multi custom widgets
  ],
  onStateChanged: (next) => setState(() => state = next),
)
''',
);

Widget _buildFilterBarCustomButtonsExample(BuildContext context) {
  return const FilterBarCustomButtonsExample();
}

const ComponentExample filterBarClearPolicyExample = ComponentExample(
  title: 'Mobile-only Sheet',
  builder: _buildFilterBarClearPolicyExample,
  code: r'''FilterBar(
  state: state,
  presentation: FilterBarPresentation.sheet,
  sheetPosition: OverlayPosition.right, // or OverlayPosition.bottom
  sheetTitle: 'Mobile Filters',
  sheetTriggerLabel: 'Open Filters',
  enableDateRange: true,
  customFilters: [
    // filters shown in sheet
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
