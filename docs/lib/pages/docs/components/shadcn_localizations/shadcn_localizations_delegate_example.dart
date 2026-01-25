import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/shadcn_localizations/shadcn_localizations.dart';

const ComponentExample shadcnLocalizationsDelegateExample = ComponentExample(
  title: 'Delegate lookup',
  builder: _buildShadcnLocalizationsDelegateExample,
  code: '''Directionality(
  textDirection: TextDirection.ltr,
  child: Localizations(
    locale: const Locale('en'),
    delegates: ShadcnLocalizations.localizationsDelegates,
    child: Builder(
      builder: (context) {
        final strings = ShadcnLocalizations.of(context);
        return Text(strings.formNotEmpty);
      },
    ),
  ),
)''',
);

Widget _buildShadcnLocalizationsDelegateExample(BuildContext context) {
  return const Directionality(
    textDirection: TextDirection.ltr,
    child: Localizations(
      locale: Locale('en'),
      delegates: ShadcnLocalizations.localizationsDelegates,
      child: _LocalizedText(),
    ),
  );
}

class _LocalizedText extends StatelessWidget {
  const _LocalizedText();

  @override
  Widget build(BuildContext context) {
    final strings = ShadcnLocalizations.of(context);
    return Text(strings.formNotEmpty);
  }
}
