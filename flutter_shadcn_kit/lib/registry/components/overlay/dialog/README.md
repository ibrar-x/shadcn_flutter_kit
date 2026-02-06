# Dialog (`dialog`)

Modal dialog primitives with alert dialog and overlay handlers.

---

## When to use

- Use this when:
  - you need custom modal shells or dialog routes.
  - you want a consistent modal backdrop and surface container.
- Avoid when:
  - a simple inline card or sheet works.

---

## Install

```bash
flutter_shadcn add dialog
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/dialog/dialog.dart';
```

---

## Minimal example

```dart
await showDialog(
  context: context,
  builder: (context) => const ModalContainer(
    child: Text('Hello dialog'),
  ),
)
```

---

## Common patterns

### Pattern: Custom backdrop

```dart
ModalBackdrop(
  barrierColor: const Color.fromRGBO(0, 0, 0, 0.6),
  child: const ModalContainer(
    child: Text('Blocking modal'),
  ),
)
```

---

## API

### Widgets and helpers

- `ModalBackdrop`
- `ModalContainer`
- `showDialog`
- `DialogRoute`

---

## Theming

- `ModalBackdropTheme` controls padding, barrier color, and surface clipping.

---

## Accessibility

- Use clear focus order and provide an escape/dismiss action.

---

## Do / Don’t

**Do**
- ✅ Use `ModalContainer` for consistent surface styling.

**Don’t**
- ❌ Stack multiple dialog routes on top of each other.

---

## Related components

- `alert_dialog`
- `drawer`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
