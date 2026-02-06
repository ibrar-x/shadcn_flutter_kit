# Chip (`chip`)

Compact tag-style button with optional leading/trailing widgets.

---

## When to use

- Use this when:
  - you need compact tag-like controls.
  - you want a small clickable label with optional icons.
- Avoid when:
  - the label needs full button prominence.

---

## Install

```bash
flutter_shadcn add chip
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/chip/chip.dart';
```

---

## Minimal example

```dart
Chip(
  child: const Text('Tag'),
  onPressed: () {},
)
```

---

## Common patterns

### Pattern: Leading and trailing

```dart
Chip(
  leading: const Icon(Icons.label),
  trailing: const Icon(Icons.close),
  child: const Text('Editable'),
  onPressed: () {},
)
```

---

## API

### Constructor

- `Chip`
  - `child` (`Widget`, required)
  - `leading` / `trailing` (`Widget?`)
  - `onPressed` (`VoidCallback?`)
  - `style` (`AbstractButtonStyle?`)

### Callbacks

- `onPressed`

---

## Theming

- `ChipTheme` controls default padding and style.
- Uses `Button` styles for consistency with other controls.

---

## Accessibility

- Ensure the chip is large enough for touch targets when interactive.

---

## Do / Don’t

**Do**
- ✅ Use `style` to match chip variants to context.

**Don’t**
- ❌ Use chips for long text content.

---

## Related components

- `badge`
- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
