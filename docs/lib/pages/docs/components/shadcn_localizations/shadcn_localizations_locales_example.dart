import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations/shadcn_localizations.dart';

const ComponentExample shadcnLocalizationsLocalesExample = ComponentExample(
  title: 'Supported locales',
  builder: _buildShadcnLocalizationsLocalesExample,
  code: '''final locales = ShadcnLocalizations.supportedLocales;

Wrap(
  spacing: 8,
  children: locales.map((locale) => Text(locale.languageCode)).toList(),
)''',
);

Widget _buildShadcnLocalizationsLocalesExample(BuildContext context) {
  final locales = ShadcnLocalizations.supportedLocales;
  return Wrap(
    spacing: 8,
    children: [
      for (final locale in locales) Text(locale.languageCode),
    ],
  );
}
