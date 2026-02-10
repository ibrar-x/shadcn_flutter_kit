import 'package:flutter/material.dart' hide TimeOfDay;

import '../../../shared/utils/util.dart';
import '../shadcn_localizations_en/shadcn_localizations_en.dart';
import '../shadcn_localizations_extensions/shadcn_localizations_extensions.dart';

class ShadcnLocalizationsExtensionsPreview extends StatelessWidget {
  const ShadcnLocalizationsExtensionsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizationsEn();
    final formattedTime = localizations.formatTimeOfDay(
      const TimeOfDay(hour: 18, minute: 45, second: 12),
      use24HourFormat: true,
      showSeconds: true,
    );
    final formattedDuration = localizations.formatDuration(
      const Duration(hours: 2, minutes: 30),
    );
    return Scaffold(
      body: Center(child: Text('$formattedTime • $formattedDuration')),
    );
  }
}
