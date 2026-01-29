// Auth rules for mapping AuthException to AppError.
// Produces an authentication-required AppError with login/retry/report actions.

import 'package:flutter/widgets.dart';

import '../core/app_error.dart';
import '../core/error_action.dart';
import '../core/error_code.dart';
import '../core/error_exceptions.dart';
import '../core/error_rule.dart';
import 'env.dart';

List<ErrorRule> authRules({
  required VoidCallback onLogin,
  required VoidCallback onRetry,
  required VoidCallback onReport,
}) {
  return [
    rule<AuthException>(
      build: (e, st) => AppError(
        code: AppErrorCode.unauthorized,
        title: 'Authentication required',
        message: e.message ?? 'Please log in to continue.',
        actions: [
          ErrorAction.login(onLogin),
          ErrorAction.retry(onRetry),
          ErrorAction.report(onReport),
        ],
        technicalDetails: Env.showTechnicalDetails ? '$e\n$st' : null,
      ),
      priority: 8,
    ),
  ];
}
