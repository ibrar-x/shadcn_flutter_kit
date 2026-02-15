import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/form/select/select.dart';
import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';
import 'package:docs/ui/shadcn/components/layout/scaffold/scaffold.dart'
    as shadcn_scaffold;
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

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: 320,
        child: DrawerOverlay(
          child: shadcn_scaffold.Scaffold(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxHeight = constraints.maxHeight;
                final sheetConstraints = BoxConstraints(
                  maxWidth: constraints.maxWidth,
                  maxHeight: maxHeight > 300 ? 300 : maxHeight,
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterBar(
                      state: _state,
                      presentation: FilterBarPresentation.sheet,
                      useRootSheetOverlay: false,
                      sheetPosition: OverlayPosition.bottom,
                      sheetTitle: 'Mobile Filters',
                      sheetTriggerLabel: 'Open Filters',
                      sheetConstraints: sheetConstraints,
                      sheetContentPadding: const EdgeInsets.all(12),
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
                                onStateChanged(
                                  state.setCustomValue('status', next),
                                );
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
