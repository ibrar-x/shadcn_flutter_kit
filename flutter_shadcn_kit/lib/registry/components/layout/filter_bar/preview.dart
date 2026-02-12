import 'package:flutter/widgets.dart';

import '../../control/button/button.dart';
import '../../form/select/select.dart';
import '../scaffold/scaffold.dart' as shadcn_scaffold;
import 'filter_bar.dart';
import '../../../shared/theme/theme.dart';

/// FilterBarPreview defines a reusable type for this registry module.
class FilterBarPreview extends StatefulWidget {
  const FilterBarPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<FilterBarPreview> createState() => _FilterBarPreviewState();
}

/// _FilterBarPreviewState defines a reusable type for this registry module.
class _FilterBarPreviewState extends State<FilterBarPreview> {
  static const _sortOptions = [
/// Creates a `FilterSortOption` instance.
    FilterSortOption(id: 'newest', label: 'Newest'),
/// Creates a `FilterSortOption` instance.
    FilterSortOption(id: 'oldest', label: 'Oldest'),
  ];

/// Stores `_statuses` state/configuration for this implementation.
  static const _statuses = ['open', 'in_progress', 'closed'];
/// Stores `_priorities` state/configuration for this implementation.
  static const _priorities = ['low', 'medium', 'high'];
/// Stores `_assignees` state/configuration for this implementation.
  static const _assignees = ['alex', 'sam', 'morgan', 'riley'];

  final List<_PreviewOrder> _orders = List.generate(
    42,
    (index) => _PreviewOrder(
      label: 'Order #${1000 + index}',
      status: _statuses[index % _statuses.length],
      priority: _priorities[index % _priorities.length],
      assignee: _assignees[index % _assignees.length],
      urgent: index % 3 == 0,
    ),
  );

  FilterState _state = const FilterState(
    sortId: 'newest',
    chips: [FilterChipData(key: 'tag:vip', label: 'Tag: VIP')],
    customFilters: {'status': 'open', 'urgency': 'urgent_only'},
  );

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
/// Stores `scaling` state/configuration for this implementation.
    final scaling = theme.scaling;
    final visibleOrders = _filteredOrders();
    return shadcn_scaffold.Scaffold(
      headers: const [shadcn_scaffold.AppBar(title: Text('FilterBar Preview'))],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16 * scaling),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
/// Creates a `FilterBar` instance.
            FilterBar(
              state: _state,
              sortOptions: _sortOptions,
              enableDateRange: true,
              searchDebounce: const Duration(milliseconds: 250),
              resultsCount: visibleOrders.length,
              customFilters: [
/// Creates a `_buildStatusFilter` instance.
                _buildStatusFilter(scaling),
/// Creates a `_buildPriorityFilter` instance.
                _buildPriorityFilter(scaling),
/// Creates a `_buildAssigneeFilter` instance.
                _buildAssigneeFilter(scaling),
/// Creates a `_buildUrgencyButtons` instance.
                _buildUrgencyButtons(),
              ],
              onStateChanged: (next) {
/// Creates a `setState` instance.
                setState(() {
                  _state = next;
                });
              },
            ),
/// Creates a `SizedBox` instance.
            SizedBox(height: 16 * scaling),
/// Creates a `Container` instance.
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.border),
                borderRadius: theme.borderRadiusMd,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < visibleOrders.length; i++)
/// Creates a `Container` instance.
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12 * scaling,
                        vertical: 10 * scaling,
                      ),
                      decoration: i == visibleOrders.length - 1
                          ? null
                          : BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.colorScheme.border,
                                ),
                              ),
                            ),
                      child: Row(
                        children: [
/// Creates a `Expanded` instance.
                          Expanded(child: Text(visibleOrders[i].label)),
/// Creates a `Text` instance.
                          Text(
                            '${_statusLabel(visibleOrders[i].status)} • ${_titleCase(visibleOrders[i].priority)} • ${_titleCase(visibleOrders[i].assignee)}${visibleOrders[i].urgent ? ' • Urgent' : ''}',
                            style: theme.typography.textMuted,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/// Executes `_filteredOrders` behavior for this component/composite.
  List<_PreviewOrder> _filteredOrders() {
    final query = _state.search.trim().toLowerCase();
    final selectedStatus = _state.customValue<String>('status');
    final selectedPriority = _state.customValue<String>('priority');
    final selectedAssignee = _state.customValue<String>('assignee');
    final urgency = _state.customValue<String>('urgency');
    final results = _orders
        .where((order) {
          if (query.isNotEmpty && !order.label.toLowerCase().contains(query)) {
            return false;
          }
          if (selectedStatus != null && order.status != selectedStatus) {
            return false;
          }
          if (selectedPriority != null && order.priority != selectedPriority) {
            return false;
          }
          if (selectedAssignee != null && order.assignee != selectedAssignee) {
            return false;
          }
          if (urgency == 'urgent_only' && !order.urgent) {
            return false;
          }
          if (urgency == 'normal_only' && order.urgent) {
            return false;
          }
          return true;
        })
        .toList(growable: false);

    if (_state.sortId == 'oldest') {
      return results;
    }
    return results.reversed.toList(growable: false);
  }

/// Executes `_statusLabel` behavior for this component/composite.
  String _statusLabel(String value) {
    return _titleCase(value);
  }

/// Executes `_titleCase` behavior for this component/composite.
  String _titleCase(String value) {
    return value
        .split('_')
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }

/// Executes `_buildStatusFilter` behavior for this component/composite.
  FilterCustomFilter _buildStatusFilter(double scaling) {
    return FilterCustomFilter(
      id: 'status',
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 180 * scaling,
          child: Select<String>(
            value: state.customValue<String>('status'),
            canUnselect: true,
            placeholder: const Text('Status'),
            itemBuilder: (context, value) => Text(_statusLabel(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _statuses
                    .map(
                      (status) => SelectItemButton<String>(
                        value: status,
                        child: Text(_statusLabel(status)),
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

/// Executes `_buildPriorityFilter` behavior for this component/composite.
  FilterCustomFilter _buildPriorityFilter(double scaling) {
    return FilterCustomFilter(
      id: 'priority',
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 180 * scaling,
          child: Select<String>(
            value: state.customValue<String>('priority'),
            canUnselect: true,
            placeholder: const Text('Priority'),
            itemBuilder: (context, value) => Text(_titleCase(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _priorities
                    .map(
                      (priority) => SelectItemButton<String>(
                        value: priority,
                        child: Text(_titleCase(priority)),
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

/// Executes `_buildAssigneeFilter` behavior for this component/composite.
  FilterCustomFilter _buildAssigneeFilter(double scaling) {
    return FilterCustomFilter(
      id: 'assignee',
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 180 * scaling,
          child: Select<String>(
            value: state.customValue<String>('assignee'),
            canUnselect: true,
            placeholder: const Text('Assignee'),
            itemBuilder: (context, value) => Text(_titleCase(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _assignees
                    .map(
                      (assignee) => SelectItemButton<String>(
                        value: assignee,
                        child: Text(_titleCase(assignee)),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              onStateChanged(state.setCustomValue('assignee', next));
            },
          ),
        );
      },
    );
  }

/// Executes `_buildUrgencyButtons` behavior for this component/composite.
  FilterCustomFilter _buildUrgencyButtons() {
    return FilterCustomFilter(
      id: 'urgency',
      builder: (context, state, onStateChanged) {
        final urgency = state.customValue<String>('urgency');
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
/// Creates a `_urgencyButton` instance.
            _urgencyButton(
              label: 'All',
              isSelected: urgency == null,
              onPressed: () =>
/// Creates a `onStateChanged` instance.
                  onStateChanged(state.setCustomValue('urgency', null)),
            ),
/// Creates a `SizedBox` instance.
            const SizedBox(width: 6),
/// Creates a `_urgencyButton` instance.
            _urgencyButton(
              label: 'Urgent',
              isSelected: urgency == 'urgent_only',
              onPressed: () => onStateChanged(
/// Creates a `state.setCustomValue` instance.
                state.setCustomValue('urgency', 'urgent_only'),
              ),
            ),
/// Creates a `SizedBox` instance.
            const SizedBox(width: 6),
/// Creates a `_urgencyButton` instance.
            _urgencyButton(
              label: 'Normal',
              isSelected: urgency == 'normal_only',
              onPressed: () => onStateChanged(
/// Creates a `state.setCustomValue` instance.
                state.setCustomValue('urgency', 'normal_only'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _urgencyButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    if (isSelected) {
      return SecondaryButton(
        size: ButtonSize.small,
        onPressed: onPressed,
        child: Text(label),
      );
    }
    return GhostButton(
      size: ButtonSize.small,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

/// _PreviewOrder defines a reusable type for this registry module.
class _PreviewOrder {
/// Stores `label` state/configuration for this implementation.
  final String label;
/// Stores `status` state/configuration for this implementation.
  final String status;
/// Stores `priority` state/configuration for this implementation.
  final String priority;
/// Stores `assignee` state/configuration for this implementation.
  final String assignee;
/// Stores `urgent` state/configuration for this implementation.
  final bool urgent;

/// Creates a `_PreviewOrder` instance.
  const _PreviewOrder({
    required this.label,
    required this.status,
    required this.priority,
    required this.assignee,
    required this.urgent,
  });
}
