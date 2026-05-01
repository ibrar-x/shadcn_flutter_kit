// Platform rules for mapping PlatformException to AppError.
// Captures platform code/message and provides retry/report actions.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../core/app_error.dart';
import '../core/error_action.dart';
import '../core/error_code.dart';
import '../core/error_rule.dart';
import 'env.dart';

List<ErrorRule> platformRules({
  required VoidCallback onRetry,
  required VoidCallback onReport,
}) {
  return [
    rule<PlatformException>(
      build: (e, st) => AppError(
        code: AppErrorCode.platformError,
        title: 'Platform error',
        message: e.message ?? 'Something went wrong on this device.',
        actions: [ErrorAction.retry(onRetry), ErrorAction.report(onReport)],
        technicalDetails: Env.showTechnicalDetails ? '$e\n$st' : null,
        metadata: {'code': e.code},
      ),
      priority: 3,
    ),
  ];
}
