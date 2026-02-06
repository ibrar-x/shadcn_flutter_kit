# Badge (`badge`)

Compact label/status components built on button styles.

---

## When to use

- Use this when:
  - you need small status labels or counters.
  - you want badge styling consistent with buttons.
- Avoid when:
  - you need full-size buttons or interactive controls.

---

## Install

```bash
flutter_shadcn add badge
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/badge/badge.dart';
```

---

## Minimal example

```dart
PrimaryBadge(
  child: const Text('New'),
)
```

---

## Common patterns

### Pattern: Variants

```dart
Row(
  children: const [
    PrimaryBadge(child: Text('Primary')),
    SecondaryBadge(child: Text('Secondary')),
    OutlineBadge(child: Text('Outline')),
    DestructiveBadge(child: Text('Danger')),
  ],
)
```

---

## API

### Constructor

- `PrimaryBadge`, `SecondaryBadge`, `OutlineBadge`, `DestructiveBadge`
  - `child` (`Widget`, required)
  - `leading` / `trailing` (`Widget?`)
  - `onPressed` (`VoidCallback?`)
  - `style` (`AbstractButtonStyle?`)

### Callbacks

- `onPressed`

---

## Theming

- `BadgeTheme` provides default styles for each variant.
- Variants are based on `ButtonStyle` sizing/density defaults.

---

## Accessibility

- Keep label text short and readable.

---

## Do / Don’t

**Do**
- ✅ Use badges for short labels and counts.

**Don’t**
- ❌ Use badges as primary call-to-action controls.

---

## Related components

- `button`
- `chip`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
