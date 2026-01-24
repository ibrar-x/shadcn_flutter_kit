import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/avatar/avatar.dart'
    as shadcn_avatar;

const ComponentExample avatarGroupExample = ComponentExample(
  title: 'Avatar group',
  builder: _buildAvatarGroupExample,
  code: '''
AvatarGroup.toLeft(
  children: [
    Avatar(initials: 'AL'),
    Avatar(initials: 'BM'),
    Avatar(initials: 'CT'),
  ],
)
''',
);

Widget _buildAvatarGroupExample(BuildContext context) {
  return shadcn_avatar.AvatarGroup.toLeft(
    children: const [
      shadcn_avatar.Avatar(initials: 'AL'),
      shadcn_avatar.Avatar(initials: 'BM'),
      shadcn_avatar.Avatar(initials: 'CT'),
      shadcn_avatar.Avatar(initials: 'DS'),
    ],
  );
}
