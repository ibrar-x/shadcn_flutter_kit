# Tab Pane (`tab_pane`)

Sortable tab strip with integrated content card.

---

## When to use

- Use this when:
  - you need sortable tabs with a content panel.
- Avoid when:
  - a basic tab list is sufficient.

---

## Install

```bash
flutter_shadcn add tab_pane
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/tab_pane/tab_pane.dart';
```

---

## Minimal example

```dart
TabPane<String>(
  items: const [TabPaneData('A'), TabPaneData('B')],
  focused: 0,
  onFocused: (index) {},
  itemBuilder: (context, item, index) => TabChild(child: Text(item.data)),
  child: const Text('Content'),
)
```

---

## API

### Constructor

- `TabPane<T>`
  - `items` (`List<TabPaneData<T>>`, required)
  - `focused` (`int?`)
  - `onFocused` (`ValueChanged<int>?`)
  - `onSort` (`ValueChanged<List<TabPaneData<T>>>?`)
  - `itemBuilder` (`TabPaneItemBuilder<T>`, required)
- `TabPaneData<T>` — sortable tab data.
- `TabPaneTheme` — container styling.

---

## Theming

- `TabPaneTheme` controls background, border, and bar height.

---

## Accessibility

- Ensure drag handles have keyboard alternatives.

---

## Do / Don’t

**Do**
- ✅ Use `onSort` to persist tab order.

**Don’t**
- ❌ Enable sorting without visual affordances.

---

## Related components

- `tabs`
- `sortable`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
