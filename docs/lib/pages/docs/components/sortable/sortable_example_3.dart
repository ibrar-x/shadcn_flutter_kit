import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/sortable/sortable.dart'
    as shadcn_sortable;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample sortableExample3 = ComponentExample(
  title: 'Locked horizontal list',
  builder: _buildSortableExample3,
  code: '''SortableLayer(
  lock: true,
  child: SortableDropFallback<int>(
    child: SizedBox(
      height: 50,
      child: Row(
        children: [
          Sortable(
            data: names[i],
            onAcceptLeft: (value) => names.swapItem(value, i),
            onAcceptRight: (value) => names.swapItem(value, i + 1),
            child: OutlinedContainer(...),
          ),
        ],
      ),
    ),
  ),
)''',
);

Widget _buildSortableExample3(BuildContext context) {
  return const _SortableExample3();
}

class _SortableExample3 extends StatefulWidget {
  const _SortableExample3();

  @override
  State<_SortableExample3> createState() => _SortableExample3State();
}

class _SortableExample3State extends State<_SortableExample3> {
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
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < names.length; i++)
                shadcn_sortable.Sortable<String>(
                  key: ValueKey(i),
                  data: names[i],
                  onAcceptLeft: (value) {
                    setState(() {
                      names.swapItem(value, i);
                    });
                  },
                  onAcceptRight: (value) {
                    setState(() {
                      names.swapItem(value, i + 1);
                    });
                  },
                  child: shadcn_outlined.OutlinedContainer(
                    width: 100,
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i].data)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
