import 'package:flutter/widgets.dart';

import '../core/app_error.dart';
import '../core/error_action.dart';
import '../core/error_code.dart';
import '../core/error_exceptions.dart';
import '../core/error_rule.dart';
import 'env.dart';

List<ErrorRule> validationRules({
  required VoidCallback onRetry,
  required VoidCallback onReport,
}) {
  return [
    rule<ValidationException>(
      build: (e, st) => AppError(
        code: AppErrorCode.validation,
        title: 'Invalid input',
        message: e.message ?? 'Please review the highlighted fields.',
        actions: [
          ErrorAction.retry(onRetry),
          ErrorAction.report(onReport),
        ],
        technicalDetails: Env.showTechnicalDetails ? '$e\n$st' : null,
        metadata: {'fields': e.fieldErrors},
      ),
      priority: 6,
    ),
  ];
}
