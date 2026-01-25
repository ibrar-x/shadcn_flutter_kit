import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/timeline/timeline.dart'
    as shadcn_timeline;

const ComponentExample timelineExample1 = ComponentExample(
  title: 'Basic',
  builder: _buildTimelineExample1,
  code: '''Timeline(
  data: [
    TimelineData(time: Text('2022-01-01'), title: Text('First event'), content: Text('...')),
    TimelineData(time: Text('2022-01-02'), title: Text('Second event'), content: Text('...')),
    TimelineData(time: Text('2022-01-03'), title: Text('Third event'), content: Text('...')),
  ],
)''',
);

Widget _buildTimelineExample1(BuildContext context) {
  return shadcn_timeline.Timeline(
    data: [
      shadcn_timeline.TimelineData(
        time: const Text('2022-01-01'),
        title: const Text('First event'),
        content: const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Odio euismod lacinia at quis risus sed vulputate odio ut. Quam viverra orci sagittis eu volutpat odio facilisis mauris.',
        ),
      ),
      shadcn_timeline.TimelineData(
        time: const Text('2022-01-02'),
        title: const Text('Second event'),
        content: const Text(
          'Aut eius excepturi ex recusandae eius est minima molestiae. Nam dolores iusto ad fugit reprehenderit hic dolorem quisquam et quia omnis non suscipit nihil sit libero distinctio. Ad dolorem tempora sit nostrum voluptatem qui tempora unde? Sit rerum magnam nam ipsam nesciunt aut rerum necessitatibus est quia esse non magni quae.',
        ),
      ),
      shadcn_timeline.TimelineData(
        time: const Text('2022-01-03'),
        title: const Text('Third event'),
        content: const Text(
          'Sit culpa quas ex nulla animi qui deleniti minus rem placeat mollitia. Et enim doloremque et quia sequi ea dolores voluptatem ea rerum vitae. Aut itaque incidunt est aperiam vero sit explicabo fuga id optio quis et molestiae nulla ex quae quam. Ab eius dolores ab tempora dolorum eos beatae soluta At ullam placeat est incidunt cumque.',
        ),
      ),
    ],
  );
}
