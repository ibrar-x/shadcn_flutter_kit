import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_en/shadcn_localizations_en.dart';

const ComponentExample shadcnLocalizationsEnNumericExample = ComponentExample(
  title: 'Numeric ranges',
  builder: _buildShadcnLocalizationsEnNumericExample,
  code: '''final strings = ShadcnLocalizationsEn();

Text(strings.formBetweenInclusively(2, 8));''',
);

Widget _buildShadcnLocalizationsEnNumericExample(BuildContext context) {
  final strings = ShadcnLocalizationsEn();
  return Text(strings.formBetweenInclusively(2, 8));
}
