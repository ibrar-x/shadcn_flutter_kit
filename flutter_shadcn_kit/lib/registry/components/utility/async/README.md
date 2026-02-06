# Async (`async`)

Utility for widgets that work with both synchronous and asynchronous values.

---

## When to use

- Use this when:
  - a value might be immediate or future-based.
  - you want to avoid writing separate sync/async widget paths.
- Avoid when:
  - you always have a `Future` (use `FutureBuilder`).

---

## Install

```bash
flutter_shadcn add async
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/async/async.dart';
```

---

## Minimal example

```dart
FutureOrBuilder<String>(
  future: maybeFutureTitle,
  builder: (context, snapshot) => Text(snapshot.data ?? '...'),
)
```

---

## API

### Types

- `FutureOrBuilder<T>`
- `FutureOrWidgetBuilder<T>`

---

## Theming

- No theme hooks; style within the `builder`.

---

## Accessibility

- Ensure loading states are announced or visually distinct.

---

## Do / Don’t

**Do**
- ✅ Use `initialValue` to avoid layout jumps.

**Don’t**
- ❌ Perform expensive work directly in the builder.

---

## Related components

- `spinner`
- `skeleton`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
