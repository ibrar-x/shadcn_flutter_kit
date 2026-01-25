import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/sortable/sortable.dart'
    as shadcn_sortable;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample sortableExample2 = ComponentExample(
  title: 'Locked vertical list',
  builder: _buildSortableExample2,
  code: '''SortableLayer(
  lock: true,
  child: SortableDropFallback<int>(
    onAccept: (value) {
      names.add(names.removeAt(value.data));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Sortable(
          data: names[i],
          onAcceptTop: (value) => names.swapItem(value, i),
          onAcceptBottom: (value) => names.swapItem(value, i + 1),
          child: OutlinedContainer(...),
        ),
      ],
    ),
  ),
)''',
);

Widget _buildSortableExample2(BuildContext context) {
  return const _SortableExample2();
}

class _SortableExample2 extends StatefulWidget {
  const _SortableExample2();

  @override
  State<_SortableExample2> createState() => _SortableExample2State();
}

class _SortableExample2State extends State<_SortableExample2> {
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
                  child: Center(child: Text(names[i].data)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
