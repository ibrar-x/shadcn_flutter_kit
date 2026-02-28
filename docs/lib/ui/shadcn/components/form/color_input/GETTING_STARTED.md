# Getting Started

`color_input` is a registry component in category `form`.

Popover/dialog color selector that integrates the picker, history, and eye-dropper tools.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `color_input.dart`: Widget/composite source file in this folder.
- `color_input.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `color_input`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `controlled_color_input.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_color_input_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_color_input_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `color_input_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `color_input_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `color_input.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
