import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/display/text_animate/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/form/slider/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/layout/filter_bar/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/layout/app/app.dart';
import 'package:flutter_shadcn_kit/registry/components/overlay/gooey_toast/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/utility/shadcn_localizations/shadcn_localizations.dart';
import 'package:flutter_shadcn_kit/registry/shared/theme/theme.dart';

void main() {
  runApp(const _RegistryApp());
}

class _RegistryApp extends StatelessWidget {
  const _RegistryApp();

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Filter Bar Preview',
      theme: ThemeData(),
      localizationsDelegates: ShadcnLocalizations.localizationsDelegates,
      supportedLocales: ShadcnLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: const GooeyToastPreview(),
    );
  }
}
