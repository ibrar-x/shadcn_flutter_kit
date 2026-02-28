# Drawer (`drawer`)

Sliding drawer and sheet overlays with drag support.

---

## When to use

- Use this when:
  - you need side or bottom drawers with overlay behavior.
  - you want sheet-style overlays with drag-to-dismiss.
- Avoid when:
  - a persistent side panel is enough.

---

## Install

```bash
flutter_shadcn add drawer
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/drawer/drawer.dart';
```

---

## Minimal example

```dart
await openDrawer(
  context: context,
  position: OverlayPosition.left,
  builder: (context) => const SizedBox(
    width: 280,
    child: Text('Drawer content'),
  ),
)
```

---

## Common patterns

### Pattern: Bottom sheet

```dart
openSheetOverlay(
  context: context,
  position: OverlayPosition.bottom,
  builder: (context) => const SizedBox(
    height: 240,
    child: Text('Sheet content'),
  ),
  draggable: true,
)
```

---

## API

### Functions

- `openDrawerOverlay`
- `openDrawer`
- `openSheetOverlay`

### Types

- `OverlayPosition`
- `DrawerOverlayCompleter`
- `DrawerTheme`

---

## Theming

- `DrawerTheme` controls surface blur/opacity, barrier color, and drag handle size.

---

## Accessibility

- Provide clear escape or close actions when the overlay is open.

---

## Do / Don’t

**Do**
- ✅ Use `OverlayPosition` to keep drawer direction explicit.

**Don’t**
- ❌ Put critical primary navigation behind a transient drawer only.

---

## Related components

- `dialog`
- `swiper`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
