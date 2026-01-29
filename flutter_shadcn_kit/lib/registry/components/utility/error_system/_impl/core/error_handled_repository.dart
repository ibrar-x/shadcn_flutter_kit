// ErrorHandledRepository: base class for repositories with automatic AppError mapping.
// execute()/executeSync() wrap operations, map errors via ErrorMapper, and forward to ErrorReporter.

import 'app_error.dart';
import 'error_mapper.dart';
import '../utils/error_reporter.dart';

abstract class ErrorHandledRepository {
  ErrorHandledRepository({required this.errorMapper, this.errorReporter});

  final ErrorMapper errorMapper;
  final ErrorReporter? errorReporter;

  Future<T> execute<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      final mapped = errorMapper.map(error, stackTrace);
      errorReporter?.report(mapped, error, stackTrace);
      throw mapped;
    }
  }

  T executeSync<T>(T Function() operation) {
    try {
      return operation();
    } catch (error, stackTrace) {
      final mapped = errorMapper.map(error, stackTrace);
      errorReporter?.report(mapped, error, stackTrace);
      throw mapped;
    }
  }

  Future<T> executeWithHandler<T>({
    required Future<T> Function() operation,
    required T? Function(Object error) onError,
  }) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      final handled = onError(error);
      if (handled != null) return handled;
      final mapped = errorMapper.map(error, stackTrace);
      errorReporter?.report(mapped, error, stackTrace);
      throw mapped;
    }
  }
}
