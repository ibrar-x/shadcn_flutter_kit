# Material (`material`)

Composite export for ShadcnUI, cards, buttons, and dialogs.

---

## When to use

- Use this when:
  - you want a single import for common material-style primitives.
  - you need cards, buttons, and alert dialogs together.
- Avoid when:
  - you only need a specific component (import it directly).

---

## Install

```bash
flutter_shadcn add material
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/layout/material/material.dart';
```

---

## Minimal example

```dart
ShadcnUI(
  child: Card(
    child: PrimaryButton(
      onPressed: () {},
      child: const Text('Continue'),
    ),
  ),
)
```

---

## API

### Types

- `ShadcnUI`
- `AlertDialog`
- `PrimaryButton`, `SecondaryButton`, `TextButton`
- `ButtonDensity`
- `Card`

---

## Theming

- Uses theme tokens from the layout/control registries.

---

## Accessibility

- Ensure buttons have clear labels and focus order.

---

## Do / Don’t

**Do**
- ✅ Use `ShadcnUI` to apply typography and icon defaults.

**Don’t**
- ❌ Mix incompatible button styles without intent.

---

## Related components

- `app`
- `card`
- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
