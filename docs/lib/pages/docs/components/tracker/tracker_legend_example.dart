import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/tracker/tracker.dart'
    as shadcn_tracker;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample trackerLegendExample = ComponentExample(
  title: 'Legend + labels',
  builder: _buildTrackerLegendExample,
  code: '''Tracker(data: data)''',
);

Widget _buildTrackerLegendExample(BuildContext context) {
  final data = List<shadcn_tracker.TrackerData>.generate(
    36,
    (index) => shadcn_tracker.TrackerData(
      tooltip: Text('Index ${index + 1}'),
      level: index % 5 == 0
          ? shadcn_tracker.TrackerLevel.critical
          : shadcn_tracker.TrackerLevel.fine,
    ),
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      shadcn_tracker.Tracker(data: data),
      const SizedBox(height: 12),
      const Wrap(
        spacing: 12,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          _LegendDot(
            label: 'Fine',
            color: Color(0xff22c55e),
          ),
          _LegendDot(
            label: 'Warning',
            color: Color(0xfff59e0b),
          ),
          _LegendDot(
            label: 'Critical',
            color: Color(0xffef4444),
          ),
        ],
      ),
    ],
  );
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendDot({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 6),
        Text(label).xSmall().muted(),
      ],
    );
  }
}
