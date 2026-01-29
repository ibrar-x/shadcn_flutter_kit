# Error System

Production-ready error handling for Flutter that keeps business logic clean and
UI consistent. This system maps any exception to `AppError` once (in your
repositories), then renders it with shadcn-compatible UI. It also provides a
dual-scope error bus (app-level + screen-level) so errors can be displayed
reactively without boilerplate.

## Contents

- Overview
- Architecture
- Installation
- Quick start
- Core models
- Error mapping (rules + repositories)
- Dual scopes (AppErrorHub)
- ScreenErrorScope (recommended)
- guard() (optional)
- UI components
- Theming
- Analytics and reporting
- Localization
- Testing
- Best practices

## Overview

This system solves repetitive error handling by:

- Mapping any exception to a user-facing `AppError`
- Centralizing rules for network/auth/api/validation errors
- Rendering consistent error UI across your app
- Providing app-level and screen-level error channels

It is state-management agnostic (Bloc, Riverpod, Provider, custom).

## Architecture

```
Business Logic
  └─ Repository (ErrorHandledRepository)
       └─ ErrorMapper (RuleBasedErrorMapper)
            └─ AppError (UI model)
                 └─ UI (ErrorState / InlineError / Snackbar / Dialog / Banner)
```

Dual scope channels (AppErrorHub):

```
App scope (global): session expired, maintenance, network down
Screen scope: form errors, request failed, not found
```

## Installation

### Via CLI
```
flutter_shadcn add error-system
```

### Manual
Copy the component folder and add required deps:
```yaml
dependencies:
  gap: ^3.0.1
  crypto: ^3.0.0 # optional, for fingerprinting
```

## Quick Start

### 1) Create an ErrorMapper (once)
```dart
final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
    ...apiRules(onRetry: () {}, onReport: () {}, onBack: () {}),
    ...validationRules(onRetry: () {}),
  ],
  fallback: fallbackRule,
);
```

### 2) Base repository
```dart
abstract class BaseRepository extends ErrorHandledRepository {
  BaseRepository() : super(errorMapper: mapper);
}
```

### 3) Use in repositories
```dart
class UserRepository extends BaseRepository {
  final ApiClient _api;
  UserRepository(this._api);

  Future<User> getUser(String id) {
    return execute(() => _api.getUser(id));
  }
}
```

### 4) Render in UI
```dart
ErrorState(
  error: AppError(
    code: AppErrorCode.network,
    title: 'Connection failed',
    message: 'Check your internet connection.',
    actions: [ErrorAction.retry(() {})],
  ),
);
```

## Core Models

- `AppError`: user-facing error model (title/message/actions/code)
- `AppErrorCode`: enum for severity and UI styling
- `ErrorAction`: action metadata (retry/login/back/etc.)

## Error Mapping (Rules + Repositories)

### Rule-based mapping
```dart
final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
  ],
  fallback: fallbackRule,
);
```

### Repository base class
```dart
abstract class ErrorHandledRepository {
  Future<T> execute<T>(Future<T> Function() operation);
  T executeSync<T>(T Function() operation);
}
```

Use `execute()` and all thrown errors are mapped to `AppError`.

## Dual Scopes (AppErrorHub)

Use app-level for global errors and screen-level for per-screen issues.

```dart
// App-level (global)
AppErrorHub.I.app(AppErrorHub.networkUnavailable).value = AppError(...);

// Screen-level (if you manage it manually)
AppErrorHub.I.screen('UserScreen').value = AppError(...);
```

## ScreenErrorScope (Recommended)

`ScreenErrorScope` owns a screen channel and disposes it automatically.
It exposes a typed `HubScreenScope` plus run/runSync helpers.

```dart
ScreenErrorScope(
  child: Builder(
    builder: (context) {
      final s = ScreenErrorScope.of(context);
      return Column(
        children: [
          ErrorSlot.scope(scope: s.scope),
          PrimaryButton(
            onPressed: () => s.run(() => repo.execute(() async => apiCall())),
            child: const Text('Load'),
          ),
        ],
      );
    },
  ),
);
```

## guard() (Optional)

If you want to keep call sites small without a ScreenErrorScope, use `guard()`
with a typed `ErrorScope`:

```dart
final scope = HubScreenScope('UserScreen');
await guard(() => repo.execute(() async => apiCall()), scope: scope);
```

## UI Components

- `ErrorState`: full-page/section error UI
- `InlineError`: compact inline message
- `ErrorDialog.show(...)`: dialog for blocking errors
- `ErrorSnackbar.show(...)`: toast-style error
- `AppErrorBanner`: global banner for app-level errors
- `ErrorSlot.scope(...)`: reactive slot that renders an error from a scope

## Theming

Use `ComponentTheme<ErrorSystemTheme>` to theme the system:

```dart
ComponentTheme(
  data: const ErrorSystemTheme(
    bannerBackgroundColor: Color(0xFF1F1F1F),
  ),
  child: ...
);
```

Theme hooks include icon styles, card padding/radius, dialog surface, snackbar
styling, and banner colors.

## Analytics and Reporting

Use `ErrorReporter` to integrate Crashlytics or custom analytics.
Errors can include fingerprints for deduplication via `ErrorFingerprint`.

## Localization

`AppError` is UI-ready; for localization, map errors using localized strings
in your rules or inject localized copy from the UI layer.

## Testing

- Replace `ErrorScope` with a fake implementation to assert UI behavior.
- Use `ErrorHandledRepository` with a mock `ErrorMapper` to verify mapping.

## Best Practices

- Use `ScreenErrorScope` for new screens.
- Use `AppErrorBanner` only for app-level issues.
- Keep error messages short and user-facing.
- Use `ErrorAction` factories to standardize labels and icons.
