import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../carousel/carousel_shared.dart';
import '../../../../ui/shadcn/components/navigation/tab_container/tab_container.dart'
    as shadcn_tab_container;
import '../../../../ui/shadcn/components/navigation/tab_list/tab_list.dart'
    as shadcn_tab_list;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample tabListExample1 = ComponentExample(
  title: 'Basic',
  builder: _buildTabListExample1,
  code: '''TabList(
  index: index,
  onChanged: (value) => setState(() => index = value),
  children: [TabItem(child: Text('Tab 1')), ...],
)''',
);

Widget _buildTabListExample1(BuildContext context) {
  return const _TabListExample1();
}

class _TabListExample1 extends StatefulWidget {
  const _TabListExample1();

  @override
  State<_TabListExample1> createState() => _TabListExample1State();
}

class _TabListExample1State extends State<_TabListExample1> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        shadcn_tab_list.TabList(
          index: index,
          onChanged: (value) {
            setState(() {
              index = value;
            });
          },
          children: const [
            shadcn_tab_container.TabItem(child: Text('Tab 1')),
            shadcn_tab_container.TabItem(child: Text('Tab 2')),
            shadcn_tab_container.TabItem(child: Text('Tab 3')),
          ],
        ),
        gap(16),
        IndexedStack(
          index: index,
          children: const [
            NumberedContainer(index: 1),
            NumberedContainer(index: 2),
            NumberedContainer(index: 3),
          ],
        ).sized(height: 300),
      ],
    );
  }
}
