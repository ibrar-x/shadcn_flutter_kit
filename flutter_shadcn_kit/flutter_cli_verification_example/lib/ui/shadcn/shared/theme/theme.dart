import 'package:flutter/material.dart';

/// Minimal theme helper for the CLI verification example.
ThemeData buildExampleTheme({Color seedColor = Colors.deepPurple}) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  );
}
