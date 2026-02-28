# Getting Started

`tree` is a registry component in category `display`.

Hierarchical tree view with expandable, selectable nodes.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `tree.dart`: Widget/composite source file in this folder.
- `tree.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `tree`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_path_painter.dart`: Core implementation part of the widget/composite.
- `_tree_item_view_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_tree_view_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `branch_line.dart`: Core implementation part of the widget/composite.
- `collapse_tree_node_intent.dart`: Core implementation part of the widget/composite.
- `directional_select_tree_node_intent.dart`: Core implementation part of the widget/composite.
- `expand_tree_node_intent.dart`: Core implementation part of the widget/composite.
- `focus_change_reason.dart`: Core implementation part of the widget/composite.
- `indent_guide_line.dart`: Core implementation part of the widget/composite.
- `indent_guide_none.dart`: Core implementation part of the widget/composite.
- `indent_guide_path.dart`: Core implementation part of the widget/composite.
- `select_tree_node_intent.dart`: Core implementation part of the widget/composite.
- `selection_position.dart`: Core implementation part of the widget/composite.
- `tree_item.dart`: Core implementation part of the widget/composite.
- `tree_item_expand_default_handler.dart`: Core implementation part of the widget/composite.
- `tree_item_view.dart`: Core implementation part of the widget/composite.
- `tree_node.dart`: Core implementation part of the widget/composite.
- `tree_node_data.dart`: Core implementation part of the widget/composite.
- `tree_node_depth.dart`: Core implementation part of the widget/composite.
- `tree_root.dart`: Core implementation part of the widget/composite.
- `tree_selection_default_handler.dart`: Core implementation part of the widget/composite.
- `tree_view.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- (empty)

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `tree.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
