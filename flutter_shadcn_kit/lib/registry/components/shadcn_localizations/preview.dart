import 'package:flutter/material.dart';
import '../shadcn_localizations_en/shadcn_localizations_en.dart';

class ShadcnLocalizationsPreview extends StatelessWidget {
  const ShadcnLocalizationsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizationsEn();
    return Scaffold(
      body: Center(
        child: Text(
          '${localizations.placeholderTimePicker} • ${localizations.buttonSave}',
        ),
      ),
    );
  }
}
