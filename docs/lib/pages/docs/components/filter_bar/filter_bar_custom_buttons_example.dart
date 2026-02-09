import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/control/button/button.dart';
import 'package:docs/ui/shadcn/components/form/select/select.dart';
import 'package:docs/ui/shadcn/components/layout/filter_bar/filter_bar.dart';

class FilterBarCustomButtonsExample extends StatefulWidget {
  const FilterBarCustomButtonsExample({super.key});

  @override
  State<FilterBarCustomButtonsExample> createState() =>
      _FilterBarCustomButtonsExampleState();
}

class _FilterBarCustomButtonsExampleState
    extends State<FilterBarCustomButtonsExample> {
  static const _assignees = ['alex', 'sam', 'morgan', 'riley'];

  final List<_Task> _tasks = List.generate(
    24,
    (index) => _Task(
      title: 'Task #${index + 1}',
      urgent: index.isEven,
      assignee: _assignees[index % _assignees.length],
    ),
  );

  FilterState _state = const FilterState(
    customFilters: {
      'urgency': 'urgent_only',
    },
  );

  @override
  Widget build(BuildContext context) {
    final visible = _filteredTasks();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterBar(
          state: _state,
          resultsCount: visible.length,
          customFilters: [
            _urgencyButtons(),
            _assigneeFilter(),
          ],
          onStateChanged: (next) {
            setState(() {
              _state = next;
            });
          },
        ),
        const SizedBox(height: 12),
        Text(
            'Visible tasks: ${visible.take(6).map((task) => task.title).join(', ')}'),
      ],
    );
  }

  FilterCustomFilter _urgencyButtons() {
    return FilterCustomFilter(
      id: 'urgency',
      builder: (context, state, onStateChanged) {
        final urgency = state.customValue<String>('urgency');

        Widget buildButton({
          required String label,
          required bool selected,
          required VoidCallback onPressed,
        }) {
          if (selected) {
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

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildButton(
              label: 'All',
              selected: urgency == null,
              onPressed: () {
                onStateChanged(state.setCustomValue('urgency', null));
              },
            ),
            const SizedBox(width: 6),
            buildButton(
              label: 'Urgent',
              selected: urgency == 'urgent_only',
              onPressed: () {
                onStateChanged(
                  state.setCustomValue('urgency', 'urgent_only'),
                );
              },
            ),
            const SizedBox(width: 6),
            buildButton(
              label: 'Normal',
              selected: urgency == 'normal_only',
              onPressed: () {
                onStateChanged(
                  state.setCustomValue('urgency', 'normal_only'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  FilterCustomFilter _assigneeFilter() {
    return FilterCustomFilter(
      id: 'assignee',
      builder: (context, state, onStateChanged) {
        return SizedBox(
          width: 190,
          child: Select<String>(
            value: state.customValue<String>('assignee'),
            canUnselect: true,
            placeholder: const Text('Assignee'),
            itemBuilder: (context, value) => Text(_label(value)),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _assignees
                    .map(
                      (assignee) => SelectItemButton<String>(
                        value: assignee,
                        child: Text(_label(assignee)),
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

  List<_Task> _filteredTasks() {
    final query = _state.search.trim().toLowerCase();
    final urgency = _state.customValue<String>('urgency');
    final assignee = _state.customValue<String>('assignee');

    return _tasks.where((task) {
      if (query.isNotEmpty && !task.title.toLowerCase().contains(query)) {
        return false;
      }
      if (urgency == 'urgent_only' && !task.urgent) {
        return false;
      }
      if (urgency == 'normal_only' && task.urgent) {
        return false;
      }
      if (assignee != null && task.assignee != assignee) {
        return false;
      }
      return true;
    }).toList(growable: false);
  }

  String _label(String value) {
    return value
        .split('_')
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }
}

class _Task {
  final String title;
  final bool urgent;
  final String assignee;

  const _Task({
    required this.title,
    required this.urgent,
    required this.assignee,
  });
}
