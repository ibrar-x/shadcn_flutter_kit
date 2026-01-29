import '../core/app_error.dart';

String fingerprintFor(AppError error) {
  final hash = Object.hash(
    error.code,
    error.title,
    error.message,
    error.metadata?.toString(),
  );
  return hash.toRadixString(16);
}
