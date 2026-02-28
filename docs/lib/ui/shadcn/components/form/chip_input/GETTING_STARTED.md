# Getting Started

`chip_input` is a registry component in category `form`.

Inline text input that converts typed tokens into chip widgets with removable buttons and autocomplete hooks.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `chip_input.dart`: Widget/composite source file in this folder.
- `chip_input.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `chip_input`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- (empty)

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_chip_input_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `chip_input_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `chip_input_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `_chip_provider.dart`: Utility helpers used by this widget implementation.
- `chip_editing_controller.dart`: Utility helpers used by this widget implementation.
- `chip_submit_intent.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `chip_input.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
