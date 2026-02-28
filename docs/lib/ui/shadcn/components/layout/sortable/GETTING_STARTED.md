# Getting Started

`sortable` is a registry component in category `layout`.

Drag-and-drop sorting primitives with drop zones and scrolling.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `sortable.dart`: Widget/composite source file in this folder.
- `sortable.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `sortable`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `scrollable_sortable_layer.dart`: Core implementation part of the widget/composite.
- `sortable_data.dart`: Core implementation part of the widget/composite.
- `sortable_drag_handle.dart`: Core implementation part of the widget/composite.
- `sortable_dragging_session.dart`: Core implementation part of the widget/composite.
- `sortable_drop_fallback.dart`: Core implementation part of the widget/composite.
- `sortable_drop_location.dart`: Core implementation part of the widget/composite.
- `sortable_drop_transform.dart`: Core implementation part of the widget/composite.
- `sortable_dropping_target.dart`: Core implementation part of the widget/composite.
- `sortable_layer.dart`: Core implementation part of the widget/composite.
- `sortable_pending_drop_transform.dart`: Core implementation part of the widget/composite.
- `sortable_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `scrollable_sortable_layer_state.dart`: State class/controller for interaction and derived UI state.
- `sortable_drag_handle_state.dart`: State class/controller for interaction and derived UI state.
- `sortable_drop_fallback_state.dart`: State class/controller for interaction and derived UI state.
- `sortable_layer_state.dart`: State class/controller for interaction and derived UI state.
- `sortable_state_part1.dart`: Widget/composite source file in this folder.

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
3. `sortable.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
