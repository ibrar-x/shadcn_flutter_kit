# Group (`group`)

Absolute-position layout surface with explicit offsets and sizes.

---

## When to use

- Use this when:
  - you need manual, absolute positioning of children.
- Avoid when:
  - standard layout widgets can solve it.

---

## Install

```bash
flutter_shadcn add group
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/group/group_widget.dart';
```

---

## Minimal example

```dart
GroupWidget(
  children: const [
    GroupPositioned(left: 0, top: 0, child: Text('Top-left')),
  ],
)
```

---

## API

### Constructor

- `GroupWidget` — parent for absolute positioning.
- `GroupPositioned` — child with explicit `left`, `top`, `right`, `bottom`, `width`, `height`.

---

## Theming

- No theme dependencies.

---

## Accessibility

- Ensure positioned elements remain reachable and readable.

---

## Do / Don’t

**Do**
- ✅ Use for overlays or fine-tuned layouts.

**Don’t**
- ❌ Use for general responsive layout.

---

## Related components

- `stack`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
