// Typed exceptions (ApiException/AuthException/ValidationException) used by rules.
// Throw these from adapters/repositories to ensure consistent mapping and UI messages.

class ApiException implements Exception {
  ApiException({required this.statusCode, this.message, this.details});

  final int statusCode;
  final String? message;
  final Object? details;

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message, details: $details)';
}

class AuthException implements Exception {
  AuthException({this.message, this.reason});

  final String? message;
  final String? reason;

  @override
  String toString() => 'AuthException(message: $message, reason: $reason)';
}

class ValidationException implements Exception {
  ValidationException({this.message, this.fieldErrors = const {}});

  final String? message;
  final Map<String, String> fieldErrors;

  @override
  String toString() =>
      'ValidationException(message: $message, fieldErrors: $fieldErrors)';
}
