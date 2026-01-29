import '../core/app_error.dart';
import '../core/error_code.dart';
import 'env.dart';
import 'error_fingerprint.dart';

AppError fallbackRule(Object error, [StackTrace? stackTrace]) {
  final details = Env.showTechnicalDetails ? '$error\n$stackTrace' : null;
  final appError = AppError(
    code: AppErrorCode.unknown,
    title: 'Something went wrong',
    message: 'Please try again or contact support if the issue persists.',
    technicalDetails: details,
    metadata: const {},
  );
  final fingerprint = fingerprintFor(appError);
  return AppError(
    code: appError.code,
    title: appError.title,
    message: appError.message,
    actions: appError.actions,
    technicalDetails: appError.technicalDetails,
    metadata: {'fingerprint': fingerprint},
    fingerprint: fingerprint,
  );
}
