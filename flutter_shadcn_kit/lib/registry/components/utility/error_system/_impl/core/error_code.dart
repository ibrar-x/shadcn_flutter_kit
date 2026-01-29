// AppErrorCode: enum categorizing error types (network/auth/validation/etc.).
// Used by rules for mapping and by UI for severity styling (icons/borders/colors).

enum AppErrorCode {
  network,
  timeout,
  noInternet,
  sslError,
  unauthorized,
  forbidden,
  sessionExpired,
  invalidCredentials,
  notFound,
  conflict,
  validation,
  rateLimited,
  server,
  badRequest,
  cancelled,
  invalidInput,
  platformError,
  permissionDenied,
  unknown,
}
