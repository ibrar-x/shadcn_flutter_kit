# Overlay (`overlay`)

Shared overlay handler/manager utilities and helpers.

---

## When to use

- Use this when:
  - you need a centralized overlay manager for popovers, tooltips, and menus.
  - you want access to overlay handlers and popover primitives.
- Avoid when:
  - the widget already provides its own overlay behavior.

---

## Install

```bash
flutter_shadcn add overlay
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/overlay/overlay.dart';
```

---

## Minimal example

```dart
ShadcnLayer(
  child: const MyApp(),
)
```

---

## API

### Core types

- `OverlayHandler`
- `OverlayCompleter`
- `OverlayManager`
- `OverlayManagerLayer`
- `OverlayBarrier`
- `OverlayHandlerStateMixin`
- `Popover`
- `PopoverController`
- `PopoverConstraint`

### Helpers

- `closeOverlay`
- `showPopover`

---

## Theming

- Uses `Theme.of(context)` for surface tokens in popover widgets.

---

## Accessibility

- Ensure overlays can be dismissed via keyboard and tap outside.

---

## Do / Don’t

**Do**
- ✅ Wrap your app with `ShadcnLayer` or `OverlayManagerLayer` once.

**Don’t**
- ❌ Stack multiple overlay managers for the same subtree.

---

## Related components

- `popover`
- `tooltip`
- `menu`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
