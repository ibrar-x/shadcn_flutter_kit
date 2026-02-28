# Getting Started

`control` is a registry component in category `form`.

Controller mixins and helpers for form components.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `control.dart`: Widget/composite source file in this folder.
- `control.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `control`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `controlled_component.dart`: Core implementation part of the widget/composite.
- `controlled_component_data.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_controlled_component_adapter_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `component_value_controller.dart`: Utility helpers used by this widget implementation.
- `controlled_component_adapter.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `control.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
