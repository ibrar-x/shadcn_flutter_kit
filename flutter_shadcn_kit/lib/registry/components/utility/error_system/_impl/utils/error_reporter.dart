// ErrorReporter: hook point for analytics/Crashlytics.
// ErrorHandledRepository calls report(mappedAppError, rawError, stackTrace) on failures.

import '../core/app_error.dart';

abstract class ErrorReporter {
  void report(AppError appError, Object error, StackTrace stackTrace);
}

class ConsoleErrorReporter implements ErrorReporter {
  @override
  void report(AppError appError, Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print('[ErrorReporter] $appError');
    // ignore: avoid_print
    print(error);
  }
}
