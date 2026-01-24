import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/tracker/tracker.dart'
    as shadcn_tracker;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample trackerCompactExample = ComponentExample(
  title: 'Compact tracker',
  builder: _buildTrackerCompactExample,
  code: '''ComponentTheme<TrackerTheme>(
  data: TrackerTheme(itemHeight: 16, gap: 1),
  child: Tracker(data: data),
)''',
);

Widget _buildTrackerCompactExample(BuildContext context) {
  final data = List<shadcn_tracker.TrackerData>.generate(
    48,
    (index) => shadcn_tracker.TrackerData(
      tooltip: Text('Day ${index + 1}'),
      level: index % 7 == 0
          ? shadcn_tracker.TrackerLevel.warning
          : shadcn_tracker.TrackerLevel.fine,
    ),
  );
  return shadcn_theme.ComponentTheme<shadcn_tracker.TrackerTheme>(
    data: const shadcn_tracker.TrackerTheme(
      itemHeight: 16,
      gap: 1,
      radius: 6,
    ),
    child: shadcn_tracker.Tracker(data: data),
  );
}
