import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations_en/shadcn_localizations_en.dart';

const ComponentExample shadcnLocalizationsEnCommandExample = ComponentExample(
  title: 'Command labels',
  builder: _buildShadcnLocalizationsEnCommandExample,
  code: '''final strings = ShadcnLocalizationsEn();

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(strings.commandSearch),
    Text(strings.commandEmpty),
  ],
)''',
);

Widget _buildShadcnLocalizationsEnCommandExample(BuildContext context) {
  final strings = ShadcnLocalizationsEn();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(strings.commandSearch),
      Text(strings.commandEmpty),
    ],
  );
}
