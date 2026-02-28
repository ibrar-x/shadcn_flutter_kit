# Getting Started

`progress` is a registry component in category `display`.

Normalized linear progress bar with theme overrides.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `_progress_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `progress.dart`: Widget/composite source file in this folder.
- `progress.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `progress`.

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

- `progress_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `progress.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
