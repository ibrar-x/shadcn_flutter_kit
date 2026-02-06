import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'tracker_example_1.dart';

const ComponentExample trackerExample1 = ComponentExample(
  title: "Example",
  builder: _buildTrackerExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n// Demonstrates a Tracker strip with varying levels (fine/warning/critical)\n// and per-cell tooltips, similar to a heatmap timeline.\n\nclass TrackerExample1 extends StatefulWidget {\n  const TrackerExample1({super.key});\n\n  @override\n  State<TrackerExample1> createState() => _TrackerExample1State();\n}\n\nclass _TrackerExample1State extends State<TrackerExample1> {\n  @override\n  Widget build(BuildContext context) {\n    // Build a simple sequence of tracker cells with different severity levels.\n    List<TrackerData> data = [];\n    for (int i = 0; i < 80; i++) {\n      data.add(const TrackerData(\n        tooltip: Text('Tracker Fine'),\n        level: TrackerLevel.fine,\n      ));\n    }\n    // Mark some indices as warnings.\n    data[40] = data[35] = const TrackerData(\n      tooltip: Text('Tracker Warning'),\n      level: TrackerLevel.warning,\n    );\n    // And a few as critical.\n    data[60] = data[68] = data[72] = const TrackerData(\n      tooltip: Text('Tracker Critical'),\n      level: TrackerLevel.critical,\n    );\n    // Unknown levels to show a broader legend.\n    for (int i = 8; i < 16; i++) {\n      data[i] = const TrackerData(\n        tooltip: Text('Tracker Unknown'),\n        level: TrackerLevel.unknown,\n      );\n    }\n    // Tracker renders a compact heatmap-like strip with tooltips per cell.\n    return Tracker(data: data);\n  }\n}\n",
);

Widget _buildTrackerExample1(BuildContext context) {
  return const TrackerExample1();
}

const List<ComponentExample> trackerExamples = [
  trackerExample1,
];
