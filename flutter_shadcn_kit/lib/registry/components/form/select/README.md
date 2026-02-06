# Select (`select`)

Dropdown/select control with popup menus, grouped items, and keyboard navigation.

---

## When to use

- Use this when:
  - you need a flexible dropdown with custom items.
  - you want single or multi-select support.
- Avoid when:
  - options are very long lists without search.

---

## Install

```bash
flutter_shadcn add select
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/select/select.dart';
```

---

## Minimal example

```dart
Select<String>(
  value: selected,
  onChanged: (value) {},
  popup: SelectPopup.menu(
    children: const [
      SelectItem(value: 'a', child: Text('Option A')),
      SelectItem(value: 'b', child: Text('Option B')),
    ],
  ),
)
```

---

## API

### Constructor

- `Select<T>` — single-value select.
- `MultiSelect<T>` — multi-value select.
- `SelectItem<T>` — item row.
- `SelectGroup` — grouped items.
- `SelectPopup` — menu/popup builders.
- `SelectController<T>` / `MultiSelectController<T>` — controllers.
- Builder types: `SelectPopupBuilder`, `SelectValueBuilder`.

### Callbacks

- `onChanged`

---

## Theming

- `SelectTheme` controls padding, typography, and popup styling.

---

## Accessibility

- Provide readable labels and keyboard navigation.

---

## Do / Don’t

**Do**
- ✅ Use `SelectGroup` to organize large option sets.

**Don’t**
- ❌ Allow multi-select without clear selected state UI.

---

## Related components

- `command`
- `chip`
- `menu`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
