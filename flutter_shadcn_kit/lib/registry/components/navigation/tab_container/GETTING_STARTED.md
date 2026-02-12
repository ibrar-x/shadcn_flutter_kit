# Getting Started

`tab_container` is a registry component in category `navigation`.

Coordinated tab state manager with customizable builders.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `tab_container.dart`: Widget/composite source file in this folder.
- `tab_container.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `tab_container`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `keyed_tab_child_widget.dart`: Core implementation part of the widget/composite.
- `keyed_tab_item.dart`: Core implementation part of the widget/composite.
- `tab_child_widget.dart`: Core implementation part of the widget/composite.
- `tab_container_2.dart`: Core implementation part of the widget/composite.
- `tab_container_data.dart`: Core implementation part of the widget/composite.
- `tab_item.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_tab_container_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.

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
3. `tab_container.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
