import 'package:flutter/material.dart';
import '../locale_utils/locale_utils.dart';

/// LocaleUtilsPreview defines a reusable type for this registry module.
class LocaleUtilsPreview extends StatelessWidget {
  const LocaleUtilsPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final formatted = formatFileSize(42000, SizeUnitLocale.fileBytes);
    return Scaffold(body: Center(child: Text('Formatted size: $formatted')));
  }
}
