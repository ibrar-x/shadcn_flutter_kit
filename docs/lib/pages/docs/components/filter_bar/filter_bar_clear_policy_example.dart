import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/form/select/select.dart';
import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';

class FilterBarClearPolicyExample extends StatefulWidget {
  const FilterBarClearPolicyExample({super.key});

  @override
  State<FilterBarClearPolicyExample> createState() =>
      _FilterBarClearPolicyExampleState();
}

class _FilterBarClearPolicyExampleState
    extends State<FilterBarClearPolicyExample> {
  static const _statuses = ['open', 'in_progress', 'closed'];
  static const _teams = ['platform', 'growth', 'support'];

  FilterState _state = const FilterState(
    sortId: 'newest',
    customFilters: {
      'status': 'open',
      'team': 'platform',
    },
  );

  @override
  Widget build(BuildContext context) {
    final status = _state.customValue<String>('status') ?? 'any';
    final team = _state.customValue<String>('team') ?? 'any';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterBar(
          state: _state,
          sortOptions: const [
            FilterSortOption(id: 'newest', label: 'Newest'),
            FilterSortOption(id: 'oldest', label: 'Oldest'),
          ],
          customFilters: [
            _statusFilter(),
            _teamFilter(),
          ],
          clearPolicy: const FilterClearPolicy(
            clearSearch: true,
            clearSort: true,
            clearDateRange: true,
            clearChips: true,
            clearCustomFilters: false,
          ),
          onStateChanged: (next) {
            setState(() {
              _state = next;
            });
          },
        ),
        const SizedBox(height: 12),
        Text(
          'Clear all keeps custom filters: status=$status, team=$team',
        ),
      ],
    );
  }

  FilterCustomFilter _statusFilter() {
    return FilterCustomFilter(
      id: 'status',
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 190,
          child: Select<String>(
            value: state.customValue<String>('status'),
            canUnselect: true,
            placeholder: const Text('Status'),
            itemBuilder: (context, value) => Text(_label(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _statuses
                    .map(
                      (status) => SelectItemButton<String>(
                        value: status,
                        child: Text(_label(status)),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              onStateChanged(state.setCustomValue('status', next));
            },
          ),
        );
      },
    );
  }

  FilterCustomFilter _teamFilter() {
    return FilterCustomFilter(
      id: 'team',
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 190,
          child: Select<String>(
            value: state.customValue<String>('team'),
            canUnselect: true,
            placeholder: const Text('Team'),
            itemBuilder: (context, value) => Text(_label(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _teams
                    .map(
                      (team) => SelectItemButton<String>(
                        value: team,
                        child: Text(_label(team)),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              onStateChanged(state.setCustomValue('team', next));
            },
          ),
        );
      },
    );
  }

  String _label(String value) {
    return value
        .split('_')
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }
}
