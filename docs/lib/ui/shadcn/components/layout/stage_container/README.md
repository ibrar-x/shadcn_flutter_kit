# Stage Container (`stage_container`)

Responsive container that snaps to breakpoint widths.

---

## When to use

- Use this when:
  - you want a centered, breakpoint-aware layout.
- Avoid when:
  - a simple `Container` or `ConstrainedBox` is enough.

---

## Install

```bash
flutter_shadcn add stage_container
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/stage_container/stage_container.dart';
```

---

## Minimal example

```dart
StageContainer(
  builder: (context, padding) => Padding(
    padding: padding,
    child: const Text('Content'),
  ),
)
```

---

## API

### Constructor

- `StageContainer`
  - `breakpoint` (`StageBreakpoint?`)
  - `padding` (`EdgeInsetsGeometry?`)
  - `builder` (`Widget Function(BuildContext, EdgeInsetsGeometry)`, required)
- `StageBreakpoint` — `constant`, `staged`, `defaultBreakpoints`.
- `StageContainerTheme` — padding/breakpoint defaults.

---

## Theming

- `StageContainerTheme` controls breakpoint strategy and padding.

---

## Accessibility

- Ensure content remains readable at small widths.

---

## Do / Don’t

**Do**
- ✅ Use `defaultBreakpoints` for standard responsive layouts.

**Don’t**
- ❌ Stack multiple stage containers without necessity.

---

## Related components

- `media_query`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
