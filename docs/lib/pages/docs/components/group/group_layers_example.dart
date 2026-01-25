import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/group/group_widget.dart'
    as shadcn_group;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;

const ComponentExample groupLayersExample = ComponentExample(
  title: 'Layered cards',
  builder: _buildGroupLayersExample,
  code: '''SizedBox(
  width: 220,
  height: 140,
  child: GroupWidget(
    children: [
      GroupPositioned.fill(child: OutlinedContainer(child: Text('Base'))),
      GroupPositioned(left: 16, top: 16, child: OutlinedContainer(...)),
    ],
  ),
)''',
);

Widget _buildGroupLayersExample(BuildContext context) {
  return const SizedBox(
    width: 220,
    height: 140,
    child: shadcn_group.GroupWidget(
      children: [
        shadcn_group.GroupPositioned.fill(
          child: shadcn_outlined.OutlinedContainer(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Base layer'),
            ),
          ),
        ),
        shadcn_group.GroupPositioned(
          left: 16,
          top: 16,
          width: 140,
          height: 80,
          child: shadcn_outlined.OutlinedContainer(
            padding: EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text('Top layer'),
            ),
          ),
        ),
      ],
    ),
  );
}
