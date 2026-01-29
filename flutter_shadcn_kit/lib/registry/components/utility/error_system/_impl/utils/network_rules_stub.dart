// Network rules stub for non-IO platforms.
// Returns no rules because dart:io exception types are unavailable on web.

import 'package:flutter/widgets.dart';

import '../core/error_rule.dart';

List<ErrorRule> networkRules({
  required VoidCallback onRetry,
  required VoidCallback onReport,
  required VoidCallback onSettings,
}) {
  return const [];
}
