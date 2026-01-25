import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/overflow_marquee/overflow_marquee.dart'
    as shadcn_overflow;

const ComponentExample overflowMarqueeBasicExample = ComponentExample(
  title: 'Example',
  builder: _buildOverflowMarqueeBasicExample,
  code: '''SizedBox(
  width: 200,
  child: OverflowMarquee(
    child: Text('Lorem ipsum dolor sit amet...'),
  ),
)''',
);

Widget _buildOverflowMarqueeBasicExample(BuildContext context) {
  return const SizedBox(
    width: 200,
    child: shadcn_overflow.OverflowMarquee(
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
    ),
  );
}
