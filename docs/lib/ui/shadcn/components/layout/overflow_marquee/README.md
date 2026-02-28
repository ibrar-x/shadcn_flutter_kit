# Overflow Marquee (`overflow_marquee`)

Smooth marquee for overflowing content with fade edges and looped timing controls.

---

## When to use

- Use this when:
  - you need scrolling for overflowing text or content.
- Avoid when:
  - truncation is acceptable.

---

## Install

```bash
flutter_shadcn add overflow_marquee
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/overflow_marquee/overflow_marquee.dart';
```

---

## Minimal example

```dart
OverflowMarquee(
  child: const Text('Very long title that should scroll'),
)
```

---

## API

### Constructor

- `OverflowMarquee`
  - `direction`, `duration`, `delayDuration`
  - `step`, `fadePortion`, `curve`
- `OverflowMarqueeTheme` — theme defaults.

---

## Theming

- `OverflowMarqueeTheme` controls timing and fade configuration.

---

## Accessibility

- Avoid using marquee for critical content that must be read quickly.

---

## Do / Don’t

**Do**
- ✅ Use short durations to keep content readable.

**Don’t**
- ❌ Stack multiple marquees in the same view.

---

## Related components

- `text`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
