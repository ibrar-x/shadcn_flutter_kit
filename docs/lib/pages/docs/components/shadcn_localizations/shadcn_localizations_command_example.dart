import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations/shadcn_localizations.dart';

const ComponentExample shadcnLocalizationsCommandExample = ComponentExample(
  title: 'Command strings',
  builder: _buildShadcnLocalizationsCommandExample,
  code: '''Directionality(
  textDirection: TextDirection.ltr,
  child: Localizations(
    locale: const Locale('en'),
    delegates: ShadcnLocalizations.localizationsDelegates,
    child: Builder(
      builder: (context) {
        final strings = ShadcnLocalizations.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.commandSearch),
            Text(strings.commandEmpty),
          ],
        );
      },
    ),
  ),
)''',
);

Widget _buildShadcnLocalizationsCommandExample(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Localizations(
      locale: const Locale('en'),
      delegates: ShadcnLocalizations.localizationsDelegates,
      child: const _CommandStrings(),
    ),
  );
}

class _CommandStrings extends StatelessWidget {
  const _CommandStrings();

  @override
  Widget build(BuildContext context) {
    final strings = ShadcnLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.commandSearch),
        Text(strings.commandEmpty),
      ],
    );
  }
}
