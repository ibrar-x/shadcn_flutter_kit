# Error System

Production-ready error handling system with UI components and repository mapping.

## Usage

```dart
final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(
      onRetry: () {},
      onReport: () {},
      onSettings: () {},
    ),
    ...authRules(
      onLogin: () {},
      onRetry: () {},
      onReport: () {},
    ),
  ],
  fallback: fallbackRule,
);

class UserRepository extends ErrorHandledRepository {
  UserRepository() : super(errorMapper: mapper);
}

// UI
ErrorState(
  error: AppError(
    code: AppErrorCode.network,
    title: 'Connection failed',
    message: 'Check your internet connection.',
    actions: [ErrorAction.retry(() {})],
  ),
);
```
