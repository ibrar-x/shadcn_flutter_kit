import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/tracker/tracker.dart'
    as shadcn_tracker;

const ComponentExample trackerHeatmapExample = ComponentExample(
  title: 'Activity heatmap',
  builder: _buildTrackerHeatmapExample,
  code: '''Tracker(data: data)''',
);

Widget _buildTrackerHeatmapExample(BuildContext context) {
  final data = List<shadcn_tracker.TrackerData>.generate(
    80,
    (index) => const shadcn_tracker.TrackerData(
      tooltip: Text('Tracker Fine'),
      level: shadcn_tracker.TrackerLevel.fine,
    ),
  );
  data[40] = data[35] = const shadcn_tracker.TrackerData(
    tooltip: Text('Tracker Warning'),
    level: shadcn_tracker.TrackerLevel.warning,
  );
  data[60] = data[68] = data[72] = const shadcn_tracker.TrackerData(
    tooltip: Text('Tracker Critical'),
    level: shadcn_tracker.TrackerLevel.critical,
  );
  for (int i = 8; i < 16; i++) {
    data[i] = const shadcn_tracker.TrackerData(
      tooltip: Text('Tracker Unknown'),
      level: shadcn_tracker.TrackerLevel.unknown,
    );
  }
  return shadcn_tracker.Tracker(data: data);
}
