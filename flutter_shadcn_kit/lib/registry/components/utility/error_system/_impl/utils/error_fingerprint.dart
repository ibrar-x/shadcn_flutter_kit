// Fingerprinting utility for deduplicating errors.
// Produces a stable identifier from AppError fields for logging/aggregation.

import '../core/app_error.dart';

/// Executes `fingerprintFor` behavior for this component/composite.
String fingerprintFor(AppError error) {
  final hash = Object.hash(
    error.code,
    error.title,
    error.message,
    error.metadata?.toString(),
  );
  return hash.toRadixString(16);
}
