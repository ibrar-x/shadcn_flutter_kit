import 'package:flutter/material.dart';
import '../shadcn_localizations_en/shadcn_localizations_en.dart';

class ShadcnLocalizationsEnPreview extends StatelessWidget {
  const ShadcnLocalizationsEnPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizationsEn();
    return Scaffold(
      body: Center(
        child: Text(localizations.placeholderDatePicker),
      ),
    );
  }
}
