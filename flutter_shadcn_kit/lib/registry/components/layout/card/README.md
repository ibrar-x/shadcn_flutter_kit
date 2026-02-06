# Card (`card`)

Card container with optional surface blur variant.

---

## When to use

- Use this when:
  - you need consistent container styling.
- Avoid when:
  - a plain `Container` is enough.

---

## Install

```bash
flutter_shadcn add card
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/card/card.dart';
```

---

## Minimal example

```dart
Card(
  child: const Text('Card content'),
)
```

---

## API

### Constructor

- `Card` — standard container.
- `SurfaceCard` — card with optional surface blur.
- `CardTheme` — padding, radius, and background defaults.

---

## Theming

- `CardTheme` controls radius, padding, and background colors.

---

## Accessibility

- Ensure content has adequate padding and contrast.

---

## Do / Don’t

**Do**
- ✅ Use `SurfaceCard` for translucent overlays.

**Don’t**
- ❌ Nest too many cards without spacing.

---

## Related components

- `outlined_container`
- `card_image`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
