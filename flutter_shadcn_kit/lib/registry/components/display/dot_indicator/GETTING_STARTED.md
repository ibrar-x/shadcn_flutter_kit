# Getting Started

`dot_indicator` is a registry component in category `display`.

Animated dot indicator for carousels/steppers with optional tap behavior.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `_dot_indicator_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `dot_indicator.dart`: Widget/composite source file in this folder.
- `dot_indicator.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `dot_indicator`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `active_dot_item.dart`: Core implementation part of the widget/composite.
- `dot_items.dart`: Core implementation part of the widget/composite.
- `inactive_dot_item.dart`: Core implementation part of the widget/composite.

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

- `dot_indicator_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `dot_indicator.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
