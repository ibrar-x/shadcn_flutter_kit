import 'package:flutter/widgets.dart';
import 'package:docs/ui/shadcn/components/control/button/button.dart';
import 'package:docs/ui/shadcn/components/display/chip/chip.dart';
import 'package:docs/ui/shadcn/components/form/checkbox/checkbox.dart';
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
      channel: ['email', 'chat', 'call'][index % 3],
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
          presentation: FilterBarPresentation.inline,
          sheetTitle: 'Advanced filters',
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
          resultsCount: visible.length,
          customFilters: [
            _urgencyButtons(),
            _assigneeFilter(),
            _channelsFilter(),
          ],
          trailingFilters: [
            PrimaryButton(onPressed: () {}, child: Text('Show ${visible.length}')),
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
              .take(8)
              .map((task) => Chip(child: Text(task.title)))
              .toList(growable: false),
        ),
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

        return Wrap(
          spacing: 6,
          runSpacing: 6,
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

  FilterCustomFilter _channelsFilter() {
    return FilterCustomFilter(
      id: 'channels',
      builder: (context, state, onStateChanged) {
        final selected = (state.customValue<List<String>>('channels') ?? const <String>[])
            .toSet();

        Widget channel(String id, String label) {
          final checked = selected.contains(id);
          return GhostButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              final next = <String>{...selected};
              if (next.contains(id)) {
                next.remove(id);
              } else {
                next.add(id);
              }
              onStateChanged(
                state.setCustomValue('channels', next.isEmpty ? null : next.toList()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  state: checked ? CheckboxState.checked : CheckboxState.unchecked,
                  onChanged: (_) {},
                ),
                const SizedBox(width: 6),
                Text(label),
              ],
            ),
          );
        }

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            channel('email', 'Email'),
            channel('chat', 'Chat'),
            channel('call', 'Call'),
          ],
        );
      },
    );
  }

  List<_Task> _filteredTasks() {
    final query = _state.search.trim().toLowerCase();
    final urgency = _state.customValue<String>('urgency');
    final assignee = _state.customValue<String>('assignee');
    final channels = (_state.customValue<List<String>>('channels') ?? const <String>[])
        .toSet();

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
      if (channels.isNotEmpty && !channels.contains(task.channel)) {
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
  final String channel;

  const _Task({
    required this.title,
    required this.urgent,
    required this.assignee,
    required this.channel,
  });
}
