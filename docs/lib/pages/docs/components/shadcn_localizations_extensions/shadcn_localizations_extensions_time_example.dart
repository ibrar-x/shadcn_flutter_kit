import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_en/shadcn_localizations_en.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_extensions/shadcn_localizations_extensions.dart';
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample shadcnLocalizationsExtensionsTimeExample =
    ComponentExample(
  title: 'Format time',
  builder: _buildShadcnLocalizationsExtensionsTimeExample,
  code: '''final strings = ShadcnLocalizationsEn();
final time = TimeOfDay(hour: 9, minute: 41, second: 12);

Text(strings.formatTimeOfDay(time, use24HourFormat: false));''',
);

Widget _buildShadcnLocalizationsExtensionsTimeExample(BuildContext context) {
  final strings = ShadcnLocalizationsEn();
  final time = const TimeOfDay(hour: 9, minute: 41, second: 12);
  return Text(strings.formatTimeOfDay(time, use24HourFormat: false));
}
