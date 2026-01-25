import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_en/shadcn_localizations_en.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_extensions/shadcn_localizations_extensions.dart';

const ComponentExample shadcnLocalizationsExtensionsDateExample =
    ComponentExample(
  title: 'Format date/time',
  builder: _buildShadcnLocalizationsExtensionsDateExample,
  code: '''final strings = ShadcnLocalizationsEn();

Text(strings.formatDateTime(DateTime(2024, 7, 7, 14, 30)));''',
);

Widget _buildShadcnLocalizationsExtensionsDateExample(BuildContext context) {
  final strings = ShadcnLocalizationsEn();
  return Text(strings.formatDateTime(DateTime(2024, 7, 7, 14, 30)));
}
