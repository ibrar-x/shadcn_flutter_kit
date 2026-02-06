# Tooltip (`tooltip`)

Hover-triggered tooltip overlays with themed containers.

---

## When to use

- Use this when:
  - you need brief text hints on hover or focus.
  - you want themed tooltip containers and overlay behavior.
- Avoid when:
  - users need rich content or interactive controls (use `hover_card`).

---

## Install

```bash
flutter_shadcn add tooltip
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/tooltip/tooltip.dart';
```

---

## Minimal example

```dart
Tooltip(
  child: const Icon(Icons.info_outline),
  tooltip: (context) => const Text('More info'),
)
```

---

## Common patterns

### Pattern: Instant tooltip

```dart
InstantTooltip(
  child: const Text('Hover'),
  tooltipBuilder: (context) => const Text('Instant'),
)
```

---

## API

### Widgets and handlers

- `Tooltip`
- `InstantTooltip`
- `TooltipContainer`
- `TooltipTheme`
- `FixedTooltipOverlayHandler`
- `OverlayManagerAsTooltipOverlayHandler`

---

## Theming

- `TooltipTheme` controls surface blur, padding, and typography.

---

## Accessibility

- Pair tooltips with visible labels when possible.

---

## Do / Don’t

**Do**
- ✅ Keep tooltip copy short.

**Don’t**
- ❌ Put actionable controls inside tooltips.

---

## Related components

- `hover_card`
- `popover`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
