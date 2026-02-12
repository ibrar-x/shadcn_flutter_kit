// ErrorReporter: hook point for analytics/Crashlytics.
// ErrorHandledRepository calls report(mappedAppError, rawError, stackTrace) on failures.

import '../core/app_error.dart';

/// ErrorReporter defines a reusable type for this registry module.
abstract class ErrorReporter {
  void report(AppError appError, Object error, StackTrace stackTrace);
}

/// ConsoleErrorReporter defines a reusable type for this registry module.
class ConsoleErrorReporter implements ErrorReporter {
  @override
/// Executes `report` behavior for this component/composite.
  void report(AppError appError, Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print('[ErrorReporter] $appError');
    // ignore: avoid_print
    print(error);
  }
}
