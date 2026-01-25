import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/sortable/sortable.dart'
    as shadcn_sortable;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample sortableExample6 = ComponentExample(
  title: 'Drop failure handling',
  builder: _buildSortableExample6,
  code: '''Sortable(
  enabled: false,
  onDropFailed: () {
    final removed = names.removeAt(i);
    SortableLayer.ensureAndDismissDrop(context, removed);
  },
  child: ...,
)''',
);

Widget _buildSortableExample6(BuildContext context) {
  return const _SortableExample6();
}

class _SortableExample6 extends StatefulWidget {
  const _SortableExample6();

  @override
  State<_SortableExample6> createState() => _SortableExample6State();
}

class _SortableExample6State extends State<_SortableExample6> {
  late List<shadcn_sortable.SortableData<String>> names;

  @override
  void initState() {
    super.initState();
    _reset();
  }

  void _reset() {
    names = [
      const shadcn_sortable.SortableData('James'),
      const shadcn_sortable.SortableData('John'),
      const shadcn_sortable.SortableData('Robert'),
      const shadcn_sortable.SortableData('Michael'),
      const shadcn_sortable.SortableData('William'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_sortable.SortableLayer(
      child: Builder(
        builder: (context) {
          return shadcn_sortable.SortableDropFallback<int>(
            onAccept: (value) {
              setState(() {
                names.add(names.removeAt(value.data));
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                shadcn_buttons.PrimaryButton(
                  onPressed: () {
                    setState(_reset);
                  },
                  child: const Text('Reset'),
                ),
                for (int i = 0; i < names.length; i++)
                  shadcn_sortable.Sortable<String>(
                    key: ValueKey(i),
                    data: names[i],
                    enabled: false,
                    onAcceptTop: (value) {
                      setState(() {
                        names.swapItem(value, i);
                      });
                    },
                    onAcceptBottom: (value) {
                      setState(() {
                        names.swapItem(value, i + 1);
                      });
                    },
                    onDropFailed: () {
                      setState(() {
                        final removed = names.removeAt(i);
                        shadcn_sortable.SortableLayer.ensureAndDismissDrop(
                          context,
                          removed,
                        );
                      });
                    },
                    child: shadcn_outlined.OutlinedContainer(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const shadcn_sortable.SortableDragHandle(
                            child: Icon(Icons.drag_handle),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(names[i].data)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
