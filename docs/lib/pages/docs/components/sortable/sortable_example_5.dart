import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/sortable/sortable.dart'
    as shadcn_sortable;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample sortableExample5 = ComponentExample(
  title: 'Drag handle',
  builder: _buildSortableExample5,
  code: '''Sortable(
  enabled: false,
  child: Row(
    children: [
      SortableDragHandle(child: Icon(Icons.drag_handle)),
      Text(names[i].data),
    ],
  ),
)''',
);

Widget _buildSortableExample5(BuildContext context) {
  return const _SortableExample5();
}

class _SortableExample5 extends StatefulWidget {
  const _SortableExample5();

  @override
  State<_SortableExample5> createState() => _SortableExample5State();
}

class _SortableExample5State extends State<_SortableExample5> {
  List<shadcn_sortable.SortableData<String>> names = [
    const shadcn_sortable.SortableData('James'),
    const shadcn_sortable.SortableData('John'),
    const shadcn_sortable.SortableData('Robert'),
    const shadcn_sortable.SortableData('Michael'),
    const shadcn_sortable.SortableData('William'),
  ];

  @override
  Widget build(BuildContext context) {
    return shadcn_sortable.SortableLayer(
      lock: true,
      child: shadcn_sortable.SortableDropFallback<int>(
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
      ),
    );
  }
}
