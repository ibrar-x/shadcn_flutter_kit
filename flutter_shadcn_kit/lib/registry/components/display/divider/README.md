# Divider (`divider`)

Horizontal and vertical separators with optional label support.

---

## When to use

- Use this when:
  - you need visual separation between sections.
  - you want labeled separators.
- Avoid when:
  - spacing alone provides sufficient separation.

---

## Install

```bash
flutter_shadcn add divider
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/divider/divider.dart';
```

---

## Minimal example

```dart
const Divider()
```

---

## Common patterns

### Pattern: Labeled divider

```dart
Divider(
  child: const Text('Section'),
)
```

### Pattern: Vertical divider

```dart
const VerticalDivider()
```

---

## API

### Constructor

- `Divider`
  - `color`, `height`, `thickness`, `indent`, `endIndent`, `padding`
  - `child` (`Widget?`) — optional label
- `VerticalDivider`
  - `color`, `width`, `thickness`, `indent`, `endIndent`, `padding`
  - `child` (`Widget?`) — optional label

---

## Theming

- `DividerTheme` provides defaults for color, thickness, and padding.

---

## Accessibility

- Ensure labeled dividers use readable text sizes.

---

## Do / Don’t

**Do**
- ✅ Use `indent`/`endIndent` to align with content edges.

**Don’t**
- ❌ Overuse dividers where spacing is clearer.

---

## Related components

- `layout/card`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
