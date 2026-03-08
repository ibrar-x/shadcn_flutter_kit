import 'package:flutter/widgets.dart';

/// Minimal typography tokens for the CLI verification example.
class AppTypography {
  const AppTypography();

  TextStyle get body => const TextStyle(fontSize: 14);

  TextStyle get title =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
}
