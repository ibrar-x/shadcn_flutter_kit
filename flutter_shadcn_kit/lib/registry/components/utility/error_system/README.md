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

## Dual Scope (App + Screen)

Use `AppErrorHub` channels to keep error UI reactive:

- App-level: persistent across navigation (use `AppErrorBanner`)
- Screen-level: dispose when a screen unmounts (use `ScreenErrorMixin` + `ErrorSlot`)

```dart
// App-level (global) error: show above all screens.
AppErrorHub.I.app(AppErrorHub.networkUnavailable).value = AppError(
  code: AppErrorCode.noInternet,
  title: 'No internet',
  message: 'Check your connection and try again.',
);

// Screen-level: publish via guard() and render with ErrorSlot.screen().
await guard(() => repo.execute(() async => await apiCall()), screenScope: 'UserScreen');

ErrorSlot.screen(scope: 'UserScreen');
```
