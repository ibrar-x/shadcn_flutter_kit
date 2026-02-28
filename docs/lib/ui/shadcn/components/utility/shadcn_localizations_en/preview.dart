import 'package:flutter/material.dart';
import '../shadcn_localizations_en/shadcn_localizations_en.dart';

/// ShadcnLocalizationsEnPreview defines a reusable type for this registry module.
class ShadcnLocalizationsEnPreview extends StatelessWidget {
  const ShadcnLocalizationsEnPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizationsEn();
    return Scaffold(
      body: Center(child: Text(localizations.placeholderDatePicker)),
    );
  }
}
