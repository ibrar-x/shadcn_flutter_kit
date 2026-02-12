# Getting Started

`checkbox` is a registry component in category `form`.

Animated checkbox with tri-state support and controllers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `checkbox.dart`: Widget/composite source file in this folder.
- `checkbox.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `checkbox`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `animated_check_painter.dart`: Core implementation part of the widget/composite.
- `controlled_checkbox.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_checkbox_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_checkbox_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `checkbox_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `checkbox_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `checkbox_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `checkbox.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
