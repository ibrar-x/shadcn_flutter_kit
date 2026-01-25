import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/group/group_widget.dart'
    as shadcn_group;
import '../../../../ui/shadcn/components/display/avatar/avatar.dart'
    as shadcn_avatar;
import '../../../../ui/shadcn/components/display/badge/badge.dart'
    as shadcn_badge;

const ComponentExample groupBadgeOverlayExample = ComponentExample(
  title: 'Overlay badge',
  builder: _buildGroupBadgeOverlayExample,
  code: '''SizedBox(
  width: 96,
  height: 96,
  child: GroupWidget(
    children: [
      GroupPositioned.fill(child: Avatar()),
      GroupPositioned(
        right: 0,
        bottom: 0,
        child: PrimaryBadge(child: Text('12')),
      ),
    ],
  ),
)''',
);

Widget _buildGroupBadgeOverlayExample(BuildContext context) {
  return const SizedBox(
    width: 96,
    height: 96,
    child: shadcn_group.GroupWidget(
      children: [
        shadcn_group.GroupPositioned.fill(
          child: shadcn_avatar.Avatar(
            size: 96,
            initials: 'AL',
          ),
        ),
        shadcn_group.GroupPositioned(
          right: 0,
          bottom: 0,
          child: shadcn_badge.PrimaryBadge(
            child: Text('12'),
          ),
        ),
      ],
    ),
  );
}
