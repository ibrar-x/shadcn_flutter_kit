import 'package:flutter/material.dart';
import '../shadcn_localizations_en/shadcn_localizations_en.dart';

/// ShadcnLocalizationsPreview defines a reusable type for this registry module.
class ShadcnLocalizationsPreview extends StatelessWidget {
  const ShadcnLocalizationsPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
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
