# Tree (`tree`)

Hierarchical tree view with expandable, selectable nodes.

---

## When to use

- Use this when:
  - you need a file-tree or hierarchical browser.
  - you want built-in keyboard navigation and selection modes.
- Avoid when:
  - a flat list is enough.

---

## Install

```bash
flutter_shadcn add tree
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/tree/tree.dart';
```

---

## Minimal example

```dart
TreeView<String>(
  nodes: [
    TreeItem(data: 'Documents', children: [
      TreeItem(data: 'Notes.txt'),
    ]),
  ],
  builder: (context, item) => Text(item.data),
  onSelectionChanged: (selected, multi, isSelected) {},
)
```

---

## API

### Constructor

- `TreeView<T>`
  - `nodes` (`List<TreeNode<T>>`, required)
  - `builder` (`Widget Function(BuildContext, TreeItem<T>)`, required)
  - `controller` (`ScrollController?`)
  - `branchLine`, `padding`, `expandIcon`, `allowMultiSelect`, `recursiveSelection`
  - `onSelectionChanged` (`TreeNodeSelectionChanged<T>?`)
- `TreeItem<T>` — data-bearing node with `children`, `expanded`, `selected`.
- `TreeNode<T>` — base class for tree nodes.

### Callbacks

- `onSelectionChanged`
- `onExpandChanged`

---

## Theming

- `TreeTheme` controls branch line style, padding, expand icons, and selection behavior.

---

## Accessibility

- TreeView supports keyboard navigation; keep node labels concise.

---

## Do / Don’t

**Do**
- ✅ Use `TreeView.defaultSelectionHandler` for immutable updates.

**Don’t**
- ❌ Mutate `TreeNode` lists in place without updating state.

---

## Related components

- `icon`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
