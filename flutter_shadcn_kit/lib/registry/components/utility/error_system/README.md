# Error System (`error_system`)

Production-ready error handling system with UI components and repository mapping.

---

## When to use

- Use this when:
  - you want structured error models with consistent UI.
  - you need app-level and screen-level error channels.
- Avoid when:
  - you only need a simple inline `Text` error.

---

## Install

```bash
flutter_shadcn add error_system
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/error_system/error_system.dart';
```

---

## Minimal example

```dart
final scope = HubAppScope(AppErrorHub.sessionExpired);

AppErrorGate.scope(
  scope: scope,
  child: const MyApp(),
)
```

---

## Common patterns

### Pattern: Emit an error

```dart
AppErrorHub.I.app(AppErrorHub.sessionExpired).value = AppError(
  code: AppErrorCode.sessionExpired,
  title: 'Session expired',
  message: 'Please sign in again.',
);
```

---

## API

### Models and rules

- `AppError`, `AppErrorCode`, `ErrorAction`
- `ErrorRule`, `ErrorRegistry`, `ErrorMapper`
- `Guard`

### Scopes and hubs

- `AppErrorHub`
- `ErrorScope`, `DisposableErrorScope`
- `HubAppScope`, `HubScreenScope`

### UI helpers

- `AppErrorGate`
- `ErrorState`, `InlineError`
- `ErrorDialog`, `ErrorSnackbar`, `AppErrorBanner`

### Utils

- `ErrorReporter`, `RetryStrategy`

---

## Theming

- `ErrorSystemTheme` controls typography, colors, and spacing for error UI.

---

## Accessibility

- Make sure error text is announced and actionable controls are reachable.

---

## Do / Don’t

**Do**
- ✅ Use `AppError` for user-facing errors.

**Don’t**
- ❌ Leak raw exception messages directly to users.

---

## Related components

- `toast`
- `dialog`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
