# Error System

Production-ready error handling system with UI components, repository mapping,
and dual-scope error channels (app-level + screen-level).

## Contents

- Quick start
- Core models
- Scope system (typed scopes)
- ScreenErrorScope (widget-based lifecycle)
- guard() vs run()
- UI components (ErrorState, InlineError, Dialog, Snackbar, Banner)
- Theming
- Error mapping (rules + repositories)
- Best practices

## Quick Start

```dart
final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
  ],
  fallback: fallbackRule,
);

class UserRepository extends ErrorHandledRepository {
  UserRepository() : super(errorMapper: mapper);
}

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

### AppError
UI-safe error model with title, message, code, and actions.

### AppErrorCode
Enum used for severity and UI styling.

### ErrorAction
Action button metadata with convenience factories: `retry`, `login`, `back`, etc.

## Scope System (Typed Scopes)

### Why typed scopes?
Avoid string scope keys in your UI and business logic:

- No typos
- Refactor-friendly
- Easy to stub in tests

### Types

```dart
abstract interface class ErrorScope {
  ValueNotifier<AppError?> get notifier;
  void clear();
}

abstract interface class DisposableErrorScope extends ErrorScope {
  void dispose();
}
```

### Hub scopes

```dart
final appScope = HubAppScope(AppErrorHub.networkUnavailable);
final screenScope = HubScreenScope('UserScreen');
```

## AppErrorHub (App + Screen Channels)

Use the hub directly if you need manual control:

```dart
// App-level (persistent across navigation)
AppErrorHub.I.app(AppErrorHub.networkUnavailable).value = AppError(...);

// Screen-level (disposed when screen unmounts)
AppErrorHub.I.screen('UserScreen').value = AppError(...);
```

## ScreenErrorScope (Widget-Based)

The recommended, lowest-boilerplate API for new screens.

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

What it does:

- Creates a screen scope once per screen instance
- Exposes a typed `HubScreenScope`
- Auto-disposes scope on widget dispose
- Provides `run()` / `runSync()` helpers (no guard required)

## guard() vs run()

### guard()
Use anywhere. Works with app or screen scope via string key or notifier.

```dart
await guard(
  () => repo.execute(() async => apiCall()),
  screenScope: 'UserScreen',
);
```

### run() / runSync()
Use inside `ScreenErrorScope` for the lowest boilerplate.

```dart
final s = ScreenErrorScope.of(context);
await s.run(() => repo.execute(() async => apiCall()));
```

## UI Components

### ErrorSlot (reactive display)
Listen to any scope and render error UI.

```dart
ErrorSlot.scope(scope: s.scope);
// or legacy:
ErrorSlot.screen(scope: 'UserScreen');
```

### ErrorState
Full-card error UI (illustration, title, message, actions).

### InlineError
Lightweight inline error text.

### ErrorDialog / ErrorSnackbar
Shadcn-compatible overlay UI for urgent errors.

### AppErrorBanner
Sticky banner for app-level errors.

```dart
AppErrorBanner(
  watchScopes: const [
    AppErrorHub.sessionExpired,
    AppErrorHub.networkUnavailable,
  ],
);
```

## Theming

Wrap a subtree with `ComponentTheme<ErrorSystemTheme>` to override:

- Icons, typography
- Card padding, border radius
- Dialog background, surface blur, padding
- Snackbar text and border styling
- Banner colors and icon

```dart
ComponentTheme(
  data: const ErrorSystemTheme(
    bannerBackgroundColor: Color(0xFF1F1F1F),
  ),
  child: ...
);
```

## Error Mapping (Rules + Repositories)

Use `ErrorHandledRepository` to map errors into `AppError` once.

```dart
class UserRepository extends ErrorHandledRepository {
  UserRepository() : super(errorMapper: mapper);
}

final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
  ],
  fallback: fallbackRule,
);
```

## Best Practices

- Use `ScreenErrorScope` for new screens.
- Use `AppErrorBanner` only for global issues.
- Keep errors UI-friendly; reserve `technicalDetails` for logs.
- Prefer typed `ErrorScope` for refactor safety.
- Keep action labels concise and user-facing.

## Backward Compatibility

All previous APIs still work:

- `guard(... screenScope: '...')`
- `ErrorSlot.screen(scope: '...')`
- `ScreenErrorMixin` (deprecated, still supported)
