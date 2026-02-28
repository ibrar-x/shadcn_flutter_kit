# Media Query Visibility (`media_query`)

Responsive helper that shows primary or alternate content based on width constraints.

---

## When to use

- Use this when:
  - you need conditional layout for breakpoints.
- Avoid when:
  - a single layout can adapt with `LayoutBuilder`.

---

## Install

```bash
flutter_shadcn add media_query
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/media_query/media_query.dart';
```

---

## Minimal example

```dart
MediaQueryVisibility(
  minWidth: 600,
  child: Text('Desktop layout'),
  alternate: Text('Mobile layout'),
)
```

---

## API

### Constructor

- `MediaQueryVisibility`
  - `minWidth`, `maxWidth`
  - `child` (`Widget`, required)
  - `alternate` (`Widget?`)
- `MediaQueryVisibilityTheme` — theme defaults.

---

## Theming

- `MediaQueryVisibilityTheme` controls min/max width defaults.

---

## Accessibility

- Ensure alternate content is equivalent in meaning.

---

## Do / Don’t

**Do**
- ✅ Keep breakpoints consistent across the app.

**Don’t**
- ❌ Hide critical actions in alternate layouts.

---

## Related components

- `stage_container`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
