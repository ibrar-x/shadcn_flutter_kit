import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/avatar/avatar.dart'
    as shadcn_avatar;

const ComponentExample avatarBadgeExample = ComponentExample(
  title: 'Avatar with badge',
  builder: _buildAvatarBadgeExample,
  code: '''
Avatar(
  initials: 'JD',
  badge: AvatarBadge(color: Colors.green),
)
''',
);

Widget _buildAvatarBadgeExample(BuildContext context) {
  return const Wrap(
    spacing: 24,
    runSpacing: 24,
    children: [
      shadcn_avatar.Avatar(
        initials: 'JD',
        badge: shadcn_avatar.AvatarBadge(color: Colors.green),
      ),
      shadcn_avatar.Avatar(
        initials: 'AR',
        backgroundColor: Colors.blueGrey,
        badge: shadcn_avatar.AvatarBadge(color: Colors.orange),
        badgeAlignment: Alignment.bottomLeft,
      ),
    ],
  );
}
