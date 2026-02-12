import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/layout/filter_bar/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/utility/shadcn_localizations/shadcn_localizations.dart';
import 'package:flutter_shadcn_kit/registry/shared/theme/theme.dart' as shadcn;

void main() {
  runApp(const _RegistryApp());
}

class _RegistryApp extends StatelessWidget {
  const _RegistryApp();

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFF111827),
      localizationsDelegates: ShadcnLocalizations.localizationsDelegates,
      supportedLocales: ShadcnLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: shadcn.Theme(
        data: const shadcn.ThemeData(),
        child: const FilterBarPreview(),
      ),
    );
  }
}
