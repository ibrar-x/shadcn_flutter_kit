# Getting Started

`resizable` is a registry component in category `layout`.

Resizable panels with draggable dividers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `resizable.dart`: Widget/composite source file in this folder.
- `resizable.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `resizable`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_render_resizable_layout.dart`: Core implementation part of the widget/composite.
- `_resizable_item.dart`: Core implementation part of the widget/composite.
- `_resizable_layout.dart`: Core implementation part of the widget/composite.
- `_resizable_layout_child.dart`: Core implementation part of the widget/composite.
- `_resizable_layout_parent_data.dart`: Core implementation part of the widget/composite.
- `_resizable_panel_data.dart`: Core implementation part of the widget/composite.
- `_resizer.dart`: Core implementation part of the widget/composite.
- `horizontal_resizable_dragger.dart`: Core implementation part of the widget/composite.
- `resizable_data.dart`: Core implementation part of the widget/composite.
- `resizable_pane.dart`: Core implementation part of the widget/composite.
- `resizable_panel.dart`: Core implementation part of the widget/composite.
- `vertical_resizable_dragger.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_resizable_pane_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_resizable_panel_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_resizer_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `absolute_resizable_pane_controller.dart`: Utility helpers used by this widget implementation.
- `flexible_resizable_pane_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `resizable.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
