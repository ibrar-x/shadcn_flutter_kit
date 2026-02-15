import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/display/chip/chip.dart';
import 'package:docs/ui/shadcn/components/form/select/select.dart';
import 'package:docs/ui/shadcn/components/form/text_field/text_field.dart';
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

  static final _statusField = FilterField<String>(
    id: 'status',
    matcher: FilterMatchers.exact<String>(),
  );
  static final _assigneeField = FilterField<String>(
    id: 'assignee_query',
    defaultMatcherId: 'contains',
    matchers: [
      FilterMatcherOption(
        id: 'contains',
        label: 'Contains',
        matcher: FilterMatchers.contains(),
      ),
      FilterMatcherOption(
        id: 'is',
        label: 'Is',
        matcher: FilterMatchers.exact<String>(),
      ),
      FilterMatcherOption(
        id: 'starts_with',
        label: 'Starts with',
        matcher: FilterMatchers.startsWith(),
      ),
    ],
  );

  final List<_Issue> _issues = List.generate(
    18,
    (index) => _Issue(
      title: 'Issue #${index + 1}',
      status: ['open', 'in_progress', 'closed'][index % 3],
      priority: ['low', 'medium', 'high'][index % 3],
      createdAt: DateTime(2026, 1, 1).add(Duration(days: index)),
      assignee: ['alex', 'sam', 'morgan', 'riley'][index % 4],
    ),
  );

  FilterState _state = const FilterState(
    sortId: 'newest',
  );

  @override
  Widget build(BuildContext context) {
    final visible = _filteredIssues();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterBar(
          state: _state,
          presentation: FilterBarPresentation.inline,
          sortOptions: _sortOptions,
          resultsCount: visible.length,
          customFilters: [
            _statusFilter(),
            _assigneeMatcherFilter(),
          ],
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
              .take(6)
              .map((issue) => Chip(child: Text(issue.title)))
              .toList(growable: false),
        ),
      ],
    );
  }

  FilterCustomFilter _statusFilter() {
    return FilterCustomFilter.typed<String>(
      field: _statusField,
      builder: (context, value, onChanged) {
        return SizedBox(
          width: 180,
          child: Select<String>(
            value: value,
            canUnselect: true,
            placeholder: const Text('Status'),
            itemBuilder: (context, value) => Text(_label(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: ['open', 'in_progress', 'closed']
                    .map(
                      (status) => SelectItemButton<String>(
                        value: status,
                        child: Text(_label(status)),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: onChanged,
          ),
        );
      },
    );
  }

  FilterCustomFilter _assigneeMatcherFilter() {
    return FilterCustomFilter(
      id: _assigneeField.id,
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 320,
          child: Row(
            children: [
              Expanded(
                child: Select<String>(
                  value: state.matcherIdOf(_assigneeField),
                  itemBuilder: (context, value) {
                    final option = _assigneeField.matchers
                        .where((item) => item.id == value)
                        .first;
                    return Text(option.label);
                  },
                  popup: SelectPopup<String>(
                    items: SelectItemList(
                      children: _assigneeField.matchers
                          .map(
                            (option) => SelectItemButton<String>(
                              value: option.id,
                              child: Text(option.label),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ).call,
                  onChanged: (next) {
                    onStateChanged(state.setMatcherIdOf(_assigneeField, next));
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  placeholder: const Text('Assignee'),
                  initialValue: state.valueOf(_assigneeField),
                  onChanged: (value) {
                    onStateChanged(
                      state.setValue(
                        _assigneeField,
                        value.trim().isEmpty ? null : value,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<_Issue> _filteredIssues() {
    final query = _state.search.trim().toLowerCase();
    final selectedStatus = _state.valueOf(_statusField);
    final range = _state.dateRange;

    var filtered = _issues.where((issue) {
      if (query.isNotEmpty && !issue.title.toLowerCase().contains(query)) {
        return false;
      }
      if (selectedStatus != null && issue.status != selectedStatus) {
        return false;
      }
      if (!_state.matchesValue(_assigneeField, issue.assignee)) {
        return false;
      }
      if (range != null && range.start != null && range.end != null) {
        final date = issue.createdAt;
        if (date.isBefore(range.start!) || date.isAfter(range.end!)) {
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
  final String assignee;

  const _Issue({
    required this.title,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.assignee,
  });
}
