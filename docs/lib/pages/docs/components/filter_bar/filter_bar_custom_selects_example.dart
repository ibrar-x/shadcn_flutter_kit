import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/form/select/select.dart';
import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';

class FilterBarCustomSelectsExample extends StatefulWidget {
  const FilterBarCustomSelectsExample({super.key});

  @override
  State<FilterBarCustomSelectsExample> createState() =>
      _FilterBarCustomSelectsExampleState();
}

class _FilterBarCustomSelectsExampleState
    extends State<FilterBarCustomSelectsExample> {
  static const List<FilterSortOption> _sortOptions = [
    FilterSortOption(id: 'newest', label: 'Newest'),
    FilterSortOption(id: 'oldest', label: 'Oldest'),
  ];

  static const List<String> _statuses = ['open', 'in_progress', 'closed'];
  static const List<String> _priorities = ['low', 'medium', 'high'];

  final List<_Issue> _issues = List.generate(
    18,
    (index) => _Issue(
      title: 'Issue #${index + 1}',
      status: _statuses[index % _statuses.length],
      priority: _priorities[index % _priorities.length],
      createdAt: DateTime(2026, 1, 1).add(Duration(days: index)),
    ),
  );

  FilterState _state = const FilterState(
    sortId: 'newest',
    customFilters: {
      'status': 'open',
    },
  );

  @override
  Widget build(BuildContext context) {
    final visible = _filteredIssues();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterBar(
          state: _state,
          sortOptions: _sortOptions,
          enableDateRange: true,
          resultsCount: visible.length,
          customFilters: [
            _statusFilter(),
            _priorityFilter(),
          ],
          onStateChanged: (next) {
            setState(() {
              _state = next;
            });
          },
        ),
        const SizedBox(height: 12),
        Text(
          'First visible: ${visible.take(4).map((item) => item.title).join(', ')}',
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

  FilterCustomFilter _priorityFilter() {
    return FilterCustomFilter(
      id: 'priority',
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 190,
          child: Select<String>(
            value: state.customValue<String>('priority'),
            canUnselect: true,
            placeholder: const Text('Priority'),
            itemBuilder: (context, value) => Text(_label(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _priorities
                    .map(
                      (priority) => SelectItemButton<String>(
                        value: priority,
                        child: Text(_label(priority)),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              onStateChanged(state.setCustomValue('priority', next));
            },
          ),
        );
      },
    );
  }

  List<_Issue> _filteredIssues() {
    final query = _state.search.trim().toLowerCase();
    final selectedStatus = _state.customValue<String>('status');
    final selectedPriority = _state.customValue<String>('priority');
    final range = _state.dateRange?.toDateTimeRange();

    var filtered = _issues.where((issue) {
      if (query.isNotEmpty && !issue.title.toLowerCase().contains(query)) {
        return false;
      }
      if (selectedStatus != null && issue.status != selectedStatus) {
        return false;
      }
      if (selectedPriority != null && issue.priority != selectedPriority) {
        return false;
      }
      if (range != null) {
        final date = issue.createdAt;
        if (date.isBefore(range.start) || date.isAfter(range.end)) {
          return false;
        }
      }
      return true;
    }).toList(growable: false);

    if (_state.sortId == 'oldest') {
      return filtered;
    }
    return filtered.reversed.toList(growable: false);
  }

  String _label(String value) {
    return value
        .split('_')
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }
}

class _Issue {
  final String title;
  final String status;
  final String priority;
  final DateTime createdAt;

  const _Issue({
    required this.title,
    required this.status,
    required this.priority,
    required this.createdAt,
  });
}
