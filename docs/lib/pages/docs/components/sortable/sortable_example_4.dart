import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/sortable/sortable.dart'
    as shadcn_sortable;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample sortableExample4 = ComponentExample(
  title: 'Scrollable list',
  builder: _buildSortableExample4,
  code: '''ScrollableSortableLayer(
  controller: controller,
  child: ListView.builder(
    controller: controller,
    itemBuilder: (context, i) => Sortable(...),
    itemCount: names.length,
  ),
)''',
);

Widget _buildSortableExample4(BuildContext context) {
  return const _SortableExample4();
}

class _SortableExample4 extends StatefulWidget {
  const _SortableExample4();

  @override
  State<_SortableExample4> createState() => _SortableExample4State();
}

class _SortableExample4State extends State<_SortableExample4> {
  List<shadcn_sortable.SortableData<String>> names = [
    const shadcn_sortable.SortableData('James'),
    const shadcn_sortable.SortableData('John'),
    const shadcn_sortable.SortableData('Robert'),
    const shadcn_sortable.SortableData('Michael'),
    const shadcn_sortable.SortableData('William'),
    const shadcn_sortable.SortableData('David'),
    const shadcn_sortable.SortableData('Richard'),
    const shadcn_sortable.SortableData('Joseph'),
    const shadcn_sortable.SortableData('Thomas'),
    const shadcn_sortable.SortableData('Charles'),
    const shadcn_sortable.SortableData('Daniel'),
    const shadcn_sortable.SortableData('Matthew'),
    const shadcn_sortable.SortableData('Anthony'),
    const shadcn_sortable.SortableData('Donald'),
    const shadcn_sortable.SortableData('Mark'),
    const shadcn_sortable.SortableData('Paul'),
    const shadcn_sortable.SortableData('Steven'),
    const shadcn_sortable.SortableData('Andrew'),
    const shadcn_sortable.SortableData('Kenneth'),
  ];

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: shadcn_sortable.SortableLayer(
        lock: true,
        child: shadcn_sortable.SortableDropFallback<int>(
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          child: shadcn_sortable.ScrollableSortableLayer(
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, i) {
                return shadcn_sortable.Sortable<String>(
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
                );
              },
              itemCount: names.length,
            ),
          ),
        ),
      ),
    );
  }
}
