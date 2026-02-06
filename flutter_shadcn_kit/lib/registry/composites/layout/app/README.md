# App (`app`)

Composite app wrapper with shadcn theme and overlay handling.

---

## When to use

- Use this when:
  - you want a minimal WidgetsApp wrapper with shadcn theme and overlay manager.
  - you need a clean entry for typography and icon styling via `ShadcnUI`.
- Avoid when:
  - you require a full MaterialApp without customization.

---

## Install

```bash
flutter_shadcn add app
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/layout/app/app.dart';
```

---

## Minimal example

```dart
ShadcnApp(
  home: Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: const Center(child: Text('Hello')),
  ),
)
```

---

## API

### Widgets

- `ShadcnApp`
- `ShadcnUI`
- `Scaffold`
- `AppBar`
- `Divider`

---

## Theming

- Uses `ThemeData` from `Theme.of(context)` and supports adaptive scaling.

---

## Accessibility

- Ensure the app provides semantic labels for navigation and actions.

---

## Do / Don’t

**Do**
- ✅ Wrap your app once with `ShadcnApp`.

**Don’t**
- ❌ Nest multiple overlay managers.

---

## Related components

- `overlay`
- `scaffold`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
