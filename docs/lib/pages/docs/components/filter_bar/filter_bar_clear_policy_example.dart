import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/form/select/select.dart';
import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';
import 'package:docs/ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import 'package:docs/ui/shadcn/components/overlay/drawer/drawer.dart';

class FilterBarClearPolicyExample extends StatefulWidget {
  const FilterBarClearPolicyExample({super.key});

  @override
  State<FilterBarClearPolicyExample> createState() =>
      _FilterBarClearPolicyExampleState();
}

class _FilterBarClearPolicyExampleState
    extends State<FilterBarClearPolicyExample> {
  FilterState _state = const FilterState();
  OverlayPosition _sheetPosition = OverlayPosition.bottom;

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: Select<OverlayPosition>(
              value: _sheetPosition,
              itemBuilder: (context, value) {
                if (value == OverlayPosition.right) {
                  return const Text('Open from right');
                }
                return const Text('Open from bottom');
              },
              popup: SelectPopup<OverlayPosition>(
                items: SelectItemList(
                  children: const [
                    SelectItemButton<OverlayPosition>(
                      value: OverlayPosition.bottom,
                      child: Text('Open from bottom'),
                    ),
                    SelectItemButton<OverlayPosition>(
                      value: OverlayPosition.right,
                      child: Text('Open from right'),
                    ),
                  ],
                ),
              ).call,
              onChanged: (next) {
                if (next == null) {
                  return;
                }
                setState(() {
                  _sheetPosition = next;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          FilterBar(
            state: _state,
            presentation: FilterBarPresentation.sheet,
            sheetPosition: _sheetPosition,
            sheetTitle: 'Mobile Filters',
            sheetTriggerLabel: 'Open Filters',
            sortOptions: const [
              FilterSortOption(id: 'newest', label: 'Newest'),
              FilterSortOption(id: 'oldest', label: 'Oldest'),
            ],
            enableDateRange: true,
            customFilters: [
              FilterCustomFilter(
                id: 'status',
                builder: (context, state, onStateChanged) {
                  return Select<String>(
                    value: state.customValue<String>('status'),
                    canUnselect: true,
                    placeholder: const Text('Status'),
                    itemBuilder: (context, value) => Text(value),
                    popup: SelectPopup<String>(
                      items: SelectItemList(
                        children: const [
                          SelectItemButton<String>(
                            value: 'open',
                            child: Text('Open'),
                          ),
                          SelectItemButton<String>(
                            value: 'closed',
                            child: Text('Closed'),
                          ),
                        ],
                      ),
                    ).call,
                    onChanged: (next) {
                      onStateChanged(state.setCustomValue('status', next));
                    },
                  );
                },
              ),
            ],
            onStateChanged: (next) {
              setState(() {
                _state = next;
              });
            },
          ),
        ],
      ),
    );
  }
}
