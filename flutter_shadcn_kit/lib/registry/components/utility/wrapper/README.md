# Wrapper (`wrapper`)

Conditional wrapper for preserving widget structure.

---

## When to use

- Use this when:
  - you need to wrap a child only under certain conditions.
  - you want to preserve widget subtree identity across rebuilds.
- Avoid when:
  - a simple `if` in the build method is enough.

---

## Install

```bash
flutter_shadcn add wrapper
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/wrapper/wrapper.dart';
```

---

## Minimal example

```dart
Wrapper(
  wrap: isEnabled,
  builder: (context, child) => Padding(
    padding: const EdgeInsets.all(8),
    child: child,
  ),
  child: const Text('Wrapped'),
)
```

---

## API

### Types

- `Wrapper`
- `WrapperBuilder`

---

## Theming

- Not applicable; style within the wrapper builder.

---

## Accessibility

- Ensure wrapper changes do not alter semantics unexpectedly.

---

## Do / Don’t

**Do**
- ✅ Use `maintainStructure` when identity must stay stable.

**Don’t**
- ❌ Overuse when a simple layout change is enough.

---

## Related components

- `debug`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
