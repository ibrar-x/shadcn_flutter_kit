# Getting Started

`linear_progress_indicator` is a registry component in category `display`.

Determinate/indeterminate progress bar with optional spark effects and theming.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `_linear_progress_indicator_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `linear_progress_indicator.dart`: Widget/composite source file in this folder.
- `linear_progress_indicator.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `linear_progress_indicator`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- (empty)

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

- `linear_progress_indicator_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `_linear_progress_indicator_painter.dart`: Utility helpers used by this widget implementation.
- `linear_progress_indicator_painter.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `linear_progress_indicator.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
