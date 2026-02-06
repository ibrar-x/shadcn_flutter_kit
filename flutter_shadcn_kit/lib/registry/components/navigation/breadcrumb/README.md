# Breadcrumb (`breadcrumb`)

Horizontal breadcrumb trail with arrow/slash separators and overflow handling.

---

## When to use

- Use this when:
  - you need a path indicator for hierarchical navigation.
- Avoid when:
  - users don’t need to navigate back to parent levels.

---

## Install

```bash
flutter_shadcn add breadcrumb
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/breadcrumb/breadcrumb.dart';
```

---

## Minimal example

```dart
Breadcrumb(
  children: const [
    Text('Home'),
    Text('Library'),
    Text('Data'),
  ],
)
```

---

## API

### Constructor

- `Breadcrumb`
  - `children` (`List<Widget>`, required)
  - `separator` (`Widget?`)
  - `padding` (`EdgeInsetsGeometry?`)
- `BreadcrumbTheme` — separator/padding defaults.

---

## Theming

- `BreadcrumbTheme` controls separator and padding.

---

## Accessibility

- Ensure each segment has a clear label.

---

## Do / Don’t

**Do**
- ✅ Keep segment count short.

**Don’t**
- ❌ Use breadcrumbs as the only navigation on mobile.

---

## Related components

- `navigation_bar`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
