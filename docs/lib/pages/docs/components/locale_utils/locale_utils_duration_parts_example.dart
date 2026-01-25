import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/locale_utils/locale_utils.dart';
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample localeUtilsDurationPartsExample = ComponentExample(
  title: 'Duration + time parts',
  builder: _buildLocaleUtilsDurationPartsExample,
  code: r'''final duration = Duration(hours: 27, minutes: 15, seconds: 8);
final durationLabel = DurationPart.values
    .map((part) => '${part.name}: ${part.getter(duration)}')
    .join(' | ');

final time = TimeOfDay(hour: 9, minute: 41, second: 30);
final timeLabel = TimePart.values
    .map((part) => '${part.name}: ${part.getter(time)}')
    .join(' | ');

Text('Duration: $durationLabel\nTime: $timeLabel');''',
);

Widget _buildLocaleUtilsDurationPartsExample(BuildContext context) {
  const duration = Duration(hours: 27, minutes: 15, seconds: 8);
  final durationLabel = DurationPart.values
      .map((part) => '${part.name}: ${part.getter(duration)}')
      .join(' | ');
  const time = TimeOfDay(hour: 9, minute: 41, second: 30);
  final timeLabel = TimePart.values
      .map((part) => '${part.name}: ${part.getter(time)}')
      .join(' | ');
  return Text('Duration: $durationLabel\nTime: $timeLabel');
}
