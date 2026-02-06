# Multi Select (`multiselect`)

Composite export for MultiSelect built on Select.

---

## When to use

- Use this when:
  - you need a chip-based multi-value select.
  - you want to reuse select popups and item lists.
- Avoid when:
  - a simple checklist is enough.

---

## Install

```bash
flutter_shadcn add multiselect
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/form/multiselect/multiselect.dart';
```

---

## Minimal example

```dart
MultiSelect<String>(
  value: const ['A'],
  onChanged: (values) {},
  popup: SelectPopup(
    items: const SelectItemList(
      children: [
        SelectItemButton(value: 'A', child: Text('Option A')),
        SelectItemButton(value: 'B', child: Text('Option B')),
      ],
    ),
  ),
  multiItemBuilder: (context, item) => Text(item),
)
```

---

## API

### Types

- `MultiSelect<T>`
- `MultiSelectChip`
- `MultiSelectController<T>`
- `SelectPopup`
- `SelectItemList`
- `SelectItemButton`

---

## Theming

- Uses select theming from the form registry.

---

## Accessibility

- Keep chip labels short and readable.

---

## Do / Don’t

**Do**
- ✅ Use `SelectPopup` to keep option lists consistent.

**Don’t**
- ❌ Use multi-select for extremely long lists.

---

## Related components

- `select`
- `chip_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
