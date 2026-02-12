# Getting Started

`empty_state` is a registry component in category `display`.

Standardized empty state block for empty, no-results, or error.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `empty_state.dart`: State class/controller for interaction and derived UI state.
- `empty_state.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `empty_state`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `empty_state.dart`: State class/controller for interaction and derived UI state.
- `empty_state_action.dart`: Core implementation part of the widget/composite.

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

- `empty_state_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `empty_state_defaults.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- `empty_state_action_style.dart`: Style model/helpers for visual variants and overrides.
- `empty_state_size.dart`: Variant-specific implementation details.
- `empty_state_variant.dart`: Variant-specific implementation details.

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `empty_state.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
