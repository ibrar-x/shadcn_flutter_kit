# Scaffold (`scaffold`)

Layout scaffold with headers, footers, and loading indicators.

---

## When to use

- Use this when:
  - you need a structured page layout with headers and footers.
- Avoid when:
  - a simple `Column` or `Stack` is enough.

---

## Install

```bash
flutter_shadcn add scaffold
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/scaffold/scaffold.dart';
```

---

## Minimal example

```dart
Scaffold(
  headers: const [AppBar(title: Text('Title'))],
  child: const Text('Content'),
)
```

---

## API

### Constructor

- `Scaffold`
  - `headers`, `footers`
  - `child`
  - `loadingProgress`, `showLoadingSparks`
  - `resizeToAvoidBottomInset`
- `AppBar` — header bar widget.
- `ScaffoldTheme` — background and loading styling.

---

## Theming

- `ScaffoldTheme` controls background colors and loading sparks.

---

## Accessibility

- Ensure headers and footers remain reachable on small screens.

---

## Do / Don’t

**Do**
- ✅ Use `loadingProgress` for long-running operations.

**Don’t**
- ❌ Overload headers with too many controls.

---

## Related components

- `drawer`
- `linear_progress_indicator`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
