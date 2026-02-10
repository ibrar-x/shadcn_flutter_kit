import 'package:flutter/material.dart';
import '../locale_utils/locale_utils.dart';

class LocaleUtilsPreview extends StatelessWidget {
  const LocaleUtilsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final formatted = formatFileSize(42000, SizeUnitLocale.fileBytes);
    return Scaffold(body: Center(child: Text('Formatted size: $formatted')));
  }
}
