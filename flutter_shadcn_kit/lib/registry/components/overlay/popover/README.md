# Popover (`popover`)

Anchored overlay surfaces for floating content.

---

## When to use

- Use this when:
  - you need anchored floating content (menus, previews, tooltips).
  - you want a popover controller to manage multiple overlays.
- Avoid when:
  - a full-screen sheet or dialog is required.

---

## Install

```bash
flutter_shadcn add popover
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/popover/popover.dart';
```

---

## Minimal example

```dart
IconButton(
  onPressed: () {
    showPopover(
      context: context,
      alignment: Alignment.bottomCenter,
      builder: (context) => const Text('Popover content'),
    );
  },
  icon: const Icon(Icons.more_horiz),
)
```

---

## Common patterns

### Pattern: Managed popovers

```dart
final controller = PopoverController();
await controller.show(
  context: context,
  alignment: Alignment.bottomStart,
  builder: (context) => const Text('Managed popover'),
);
```

---

## API

### Core types

- `showPopover`
- `Popover`
- `PopoverController`
- `PopoverConstraint`
- `OverlayHandlerStateMixin`

---

## Theming

- Uses theme surface tokens from `Theme.of(context)` for popover styling.

---

## Accessibility

- Provide a way to dismiss popovers via keyboard and tap outside.

---

## Do / Don’t

**Do**
- ✅ Close existing popovers when opening a new one.

**Don’t**
- ❌ Use popovers for long-form content that needs scrolling.

---

## Related components

- `overlay`
- `tooltip`
- `hover_card`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
