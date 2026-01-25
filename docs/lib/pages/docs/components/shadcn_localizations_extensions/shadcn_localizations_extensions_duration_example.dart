import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_en/shadcn_localizations_en.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_extensions/shadcn_localizations_extensions.dart';

const ComponentExample shadcnLocalizationsExtensionsDurationExample =
    ComponentExample(
  title: 'Format duration',
  builder: _buildShadcnLocalizationsExtensionsDurationExample,
  code: '''final strings = ShadcnLocalizationsEn();

Text(strings.formatDuration(const Duration(days: 1, hours: 2, minutes: 15)));''',
);

Widget _buildShadcnLocalizationsExtensionsDurationExample(
  BuildContext context,
) {
  final strings = ShadcnLocalizationsEn();
  return Text(
    strings.formatDuration(const Duration(days: 1, hours: 2, minutes: 15)),
  );
}
