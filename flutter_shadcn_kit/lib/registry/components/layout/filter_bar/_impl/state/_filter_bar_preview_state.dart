part of '../../preview.dart';

class _FilterBarPreviewState extends State<FilterBarPreview> {
  static const _sortOptions = [
    FilterSortOption(id: 'newest', label: 'Newest'),
    FilterSortOption(id: 'oldest', label: 'Oldest'),
  ];

  static const _statuses = ['open', 'in_progress', 'closed'];
  static const _priorities = ['low', 'medium', 'high'];
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final visibleOrders = _filteredOrders();
    return shadcn_scaffold.Scaffold(
      headers: const [shadcn_scaffold.AppBar(title: Text('FilterBar Preview'))],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16 * scaling),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterBar(
              state: _state,
              sortOptions: _sortOptions,
              enableDateRange: true,
              searchDebounce: const Duration(milliseconds: 250),
              resultsCount: visibleOrders.length,
              customFilters: [
                _buildStatusFilter(scaling),
                _buildPriorityFilter(scaling),
                _buildAssigneeFilter(scaling),
                _buildUrgencyButtons(),
              ],
              onStateChanged: (next) {
                setState(() {
                  _state = next;
                });
              },
            ),
            SizedBox(height: 16 * scaling),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.border),
                borderRadius: theme.borderRadiusMd,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < visibleOrders.length; i++)
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
                          Expanded(child: Text(visibleOrders[i].label)),
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

  List<_PreviewOrder> _filteredOrders() {
    final query = _state.search.trim().toLowerCase();
    final selectedStatus = _state.customValue<String>('status');
    final selectedPriority = _state.customValue<String>('priority');
    final selectedAssignee = _state.customValue<String>('assignee');
    final urgency = _state.customValue<String>('urgency');
    var results = _orders
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

  String _statusLabel(String value) {
    return _titleCase(value);
  }

  String _titleCase(String value) {
    return value
        .split('_')
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }

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

  FilterCustomFilter _buildUrgencyButtons() {
    return FilterCustomFilter(
      id: 'urgency',
      builder: (context, state, onStateChanged) {
        final urgency = state.customValue<String>('urgency');
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _urgencyButton(
              label: 'All',
              isSelected: urgency == null,
              onPressed: () =>
                  onStateChanged(state.setCustomValue('urgency', null)),
            ),
            const SizedBox(width: 6),
            _urgencyButton(
              label: 'Urgent',
              isSelected: urgency == 'urgent_only',
              onPressed: () => onStateChanged(
                state.setCustomValue('urgency', 'urgent_only'),
              ),
            ),
            const SizedBox(width: 6),
            _urgencyButton(
              label: 'Normal',
              isSelected: urgency == 'normal_only',
              onPressed: () => onStateChanged(
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

class _PreviewOrder {
  final String label;
  final String status;
  final String priority;
  final String assignee;
  final bool urgent;

  const _PreviewOrder({
    required this.label,
    required this.status,
    required this.priority,
    required this.assignee,
    required this.urgent,
  });
}
