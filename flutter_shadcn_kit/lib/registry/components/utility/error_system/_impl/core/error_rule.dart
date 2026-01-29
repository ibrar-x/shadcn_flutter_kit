import 'app_error.dart';

typedef ErrorMatch = bool Function(Object error, StackTrace? stackTrace);
typedef ErrorBuild = AppError Function(Object error, StackTrace? stackTrace);

class ErrorRule {
  const ErrorRule({
    required this.matches,
    required this.build,
    this.priority = 0,
  });

  final ErrorMatch matches;
  final ErrorBuild build;
  final int priority;
}

ErrorRule rule<T>({
  required AppError Function(T error, StackTrace? stackTrace) build,
  bool Function(T error, StackTrace? stackTrace)? where,
  int priority = 0,
}) {
  return ErrorRule(
    matches: (e, st) => e is T && (where == null || where(e as T, st)),
    build: (e, st) => build(e as T, st),
    priority: priority,
  );
}
