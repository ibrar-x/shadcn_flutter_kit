# Hover Card (`hover_card`)

Hover or long-press triggered popovers for rich previews.

---

## When to use

- Use this when:
  - you want hover previews with richer content than tooltips.
  - you need delayed or debounced hover behavior.
- Avoid when:
  - a simple tooltip is enough.

---

## Install

```bash
flutter_shadcn add hover_card
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/hover_card/hover_card.dart';
```

---

## Minimal example

```dart
HoverCard(
  child: const Text('Hover me'),
  hoverBuilder: (context) => const Text('Preview content'),
)
```

---

## API

### Constructor

- `HoverCard`
  - `hoverBuilder`, `child`
  - `debounce`, `wait`
  - `popoverAlignment`, `anchorAlignment`, `popoverOffset`
  - `controller`, `handler`, `behavior`

---

## Theming

- `HoverCardTheme` controls surface blur and opacity.

---

## Accessibility

- Provide keyboard-accessible triggers when possible.

---

## Do / Don’t

**Do**
- ✅ Use a small debounce to avoid flicker.

**Don’t**
- ❌ Put required form actions inside a hover card.

---

## Related components

- `tooltip`
- `popover`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
