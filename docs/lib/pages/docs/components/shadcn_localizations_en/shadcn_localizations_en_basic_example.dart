import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_en/shadcn_localizations_en.dart';

const ComponentExample shadcnLocalizationsEnBasicExample = ComponentExample(
  title: 'English strings',
  builder: _buildShadcnLocalizationsEnBasicExample,
  code: '''final strings = ShadcnLocalizationsEn();

Text(strings.formNotEmpty);''',
);

Widget _buildShadcnLocalizationsEnBasicExample(BuildContext context) {
  final strings = ShadcnLocalizationsEn();
  return Text(strings.formNotEmpty);
}
