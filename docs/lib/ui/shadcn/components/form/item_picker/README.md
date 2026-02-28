# Item Picker (`item_picker`)

Grid/list picker with selection chips, search, and in-place actions.

---

## When to use

- Use this when:
  - you need a picker for custom items (icons, colors, templates).
  - you want dialog or popover presentation.
- Avoid when:
  - a simple dropdown is enough.

---

## Install

```bash
flutter_shadcn add item_picker
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/item_picker/item_picker.dart';
```

---

## Minimal example

```dart
ItemPicker<String>(
  items: ItemList(const ['A', 'B', 'C']),
  builder: (context, item, selected) => Text(item),
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `ItemPicker<T>`
  - `items` (`ItemChildDelegate<T>`, required)
  - `builder` (`ItemPickerBuilder<T>`, required)
  - `value`, `onChanged`
  - `layout` (`ItemPickerLayout?`)
  - `mode` (`PromptMode?`), `title`, `constraints`, `placeholder`
- `ItemList<T>` / `ItemBuilder<T>` — delegates for item sources.
- `ItemPickerLayout` — `grid` or `list`.

---

## Theming

- Uses shared dialog/card theming for presentation.

---

## Accessibility

- Provide labels for items when icons are used.

---

## Do / Don’t

**Do**
- ✅ Use `constraints` to avoid oversized dialogs.

**Don’t**
- ❌ Present too many items without search or grouping.

---

## Related components

- `form_field`
- `select`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
