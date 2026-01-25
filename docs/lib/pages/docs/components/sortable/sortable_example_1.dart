import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/sortable/sortable.dart'
    as shadcn_sortable;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample sortableExample1 = ComponentExample(
  title: 'Two lists',
  builder: _buildSortableExample1,
  code: '''SortableLayer(
  child: Row(
    children: [
      SortableDropFallback(...),
      SortableDropFallback(...),
    ],
  ),
)''',
);

Widget _buildSortableExample1(BuildContext context) {
  return const _SortableExample1();
}

class _SortableExample1 extends StatefulWidget {
  const _SortableExample1();

  @override
  State<_SortableExample1> createState() => _SortableExample1State();
}

class _SortableExample1State extends State<_SortableExample1> {
  List<shadcn_sortable.SortableData<String>> invited = [
    const shadcn_sortable.SortableData('James'),
    const shadcn_sortable.SortableData('John'),
    const shadcn_sortable.SortableData('Robert'),
    const shadcn_sortable.SortableData('Michael'),
    const shadcn_sortable.SortableData('William'),
  ];
  List<shadcn_sortable.SortableData<String>> reserved = [
    const shadcn_sortable.SortableData('David'),
    const shadcn_sortable.SortableData('Richard'),
    const shadcn_sortable.SortableData('Joseph'),
    const shadcn_sortable.SortableData('Thomas'),
    const shadcn_sortable.SortableData('Charles'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: shadcn_sortable.SortableLayer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: shadcn_card.Card(
                child: shadcn_sortable.SortableDropFallback<String>(
                  onAccept: (value) {
                    setState(() {
                      swapItemInLists(
                        [invited, reserved],
                        value,
                        invited,
                        invited.length,
                      );
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < invited.length; i++)
                        shadcn_sortable.Sortable<String>(
                          data: invited[i],
                          onAcceptTop: (value) {
                            setState(() {
                              swapItemInLists(
                                [invited, reserved],
                                value,
                                invited,
                                i,
                              );
                            });
                          },
                          onAcceptBottom: (value) {
                            setState(() {
                              swapItemInLists(
                                [invited, reserved],
                                value,
                                invited,
                                i + 1,
                              );
                            });
                          },
                          child: shadcn_outlined.OutlinedContainer(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(invited[i].data)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            gap(12),
            Expanded(
              child: shadcn_card.Card(
                child: shadcn_sortable.SortableDropFallback<String>(
                  onAccept: (value) {
                    setState(() {
                      swapItemInLists(
                        [invited, reserved],
                        value,
                        reserved,
                        reserved.length,
                      );
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < reserved.length; i++)
                        shadcn_sortable.Sortable<String>(
                          data: reserved[i],
                          onAcceptTop: (value) {
                            setState(() {
                              swapItemInLists(
                                [invited, reserved],
                                value,
                                reserved,
                                i,
                              );
                            });
                          },
                          onAcceptBottom: (value) {
                            setState(() {
                              swapItemInLists(
                                [invited, reserved],
                                value,
                                reserved,
                                i + 1,
                              );
                            });
                          },
                          child: shadcn_outlined.OutlinedContainer(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(reserved[i].data)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
