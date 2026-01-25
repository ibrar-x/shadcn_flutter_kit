import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/group/group_widget.dart'
    as shadcn_group;

const ComponentExample groupExample = ComponentExample(
  title: 'Group',
  builder: _buildGroupExample,
  code: '''SizedBox(
  width: 200,
  height: 140,
  child: GroupWidget(
    children: [
      GroupPositioned(...),
      GroupPositioned(...),
    ],
  ),
)''',
);

Widget _buildGroupExample(BuildContext context) {
  return SizedBox(
    width: 200,
    height: 140,
    child: shadcn_group.GroupWidget(
      children: [
        shadcn_group.GroupPositioned(
          left: 0,
          top: 0,
          width: 120,
          height: 80,
          child: Container(color: const Color(0xFFEF4444)),
        ),
        shadcn_group.GroupPositioned(
          right: 0,
          bottom: 0,
          width: 120,
          height: 80,
          child: Container(color: const Color(0xFF3B82F6)),
        ),
        const shadcn_group.GroupPositioned(
          left: 60,
          top: 40,
          width: 80,
          height: 60,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xFF22C55E)),
          ),
        ),
      ],
    ),
  );
}
