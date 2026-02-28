# Sortable (`sortable`)

Drag-and-drop sorting primitives with drop zones and scrolling.

---

## When to use

- Use this when:
  - you need draggable reordering of items.
- Avoid when:
  - a static list is enough.

---

## Install

```bash
flutter_shadcn add sortable
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/sortable/sortable.dart';
```

---

## Minimal example

```dart
Sortable<String>(
  items: const ['A', 'B', 'C'],
  itemBuilder: (context, item) => Text(item),
  onReorder: (items) {},
)
```

---

## API

### Constructor

- `Sortable<T>` — main sortable list/grid.
- `SortableLayer` — overlay layer for dragging.
- `SortableDragHandle` — drag handle widget.
- `SortableDropFallback<T>` — fallback drop handling.
- `SortableData<T>` — shared sorting data.

---

## Theming

- Uses shared animation and layout defaults.

---

## Accessibility

- Provide non-drag reorder alternatives when required.

---

## Do / Don’t

**Do**
- ✅ Keep drag handles visible.

**Don’t**
- ❌ Disable scrolling during drag when lists are long.

---

## Related components

- `group`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
