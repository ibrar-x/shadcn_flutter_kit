import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/avatar/avatar.dart'
    as shadcn_avatar;

const ComponentExample avatarBasicExample = ComponentExample(
  title: 'Basic avatars',
  builder: _buildAvatarBasicExample,
  code: '''
Row(
  children: [
    Avatar(initials: 'AL'),
    Avatar(initials: 'BM', backgroundColor: Colors.deepPurple),
    Avatar(initials: 'CT', size: 48),
  ],
)
''',
);

Widget _buildAvatarBasicExample(BuildContext context) {
  return const Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      shadcn_avatar.Avatar(initials: 'AL'),
      shadcn_avatar.Avatar(
        initials: 'BM',
        backgroundColor: Colors.deepPurple,
      ),
      shadcn_avatar.Avatar(
        initials: 'CT',
        size: 48,
      ),
    ],
  );
}
