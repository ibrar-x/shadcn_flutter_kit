# Swiper (`swiper`)

Swipe-triggered overlays for drawers and sheets.

---

## When to use

- Use this when:
  - you want swipe-to-open drawers or sheets.
  - you need consistent overlay behavior without manual gesture wiring.
- Avoid when:
  - a button trigger is enough and swipe gestures are not desired.

---

## Install

```bash
flutter_shadcn add swiper
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/swiper/swiper.dart';
```

---

## Minimal example

```dart
Swiper(
  position: OverlayPosition.left,
  handler: SwiperHandler.drawer,
  builder: (context) => const SizedBox(width: 260, child: Text('Drawer')),
  child: const Text('Swipe from left'),
)
```

---

## API

### Types

- `Swiper`
- `SwiperHandler`
- `SwiperTheme`
- `OverlayPosition`

---

## Theming

- `SwiperTheme` controls drag behavior, surface effects, and barrier styling.

---

## Accessibility

- Provide a non-swipe trigger for keyboard or assistive tech users.

---

## Do / Don’t

**Do**
- ✅ Disable swipes where they conflict with horizontal scrolling.

**Don’t**
- ❌ Rely on swipes as the only way to open critical navigation.

---

## Related components

- `drawer`
- `popover`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
