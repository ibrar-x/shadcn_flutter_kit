# Getting Started

`outlined_container` is a registry component in category `layout`.

Animated outlined container with theme-aware borders and blur.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `outlined_container.dart`: Widget/composite source file in this folder.
- `outlined_container.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `outlined_container`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `dashed_container.dart`: Core implementation part of the widget/composite.
- `dashed_container_properties.dart`: Core implementation part of the widget/composite.
- `dashed_line.dart`: Core implementation part of the widget/composite.
- `dashed_line_properties.dart`: Core implementation part of the widget/composite.
- `dashed_painter.dart`: Core implementation part of the widget/composite.
- `dashed_painters.dart`: Core implementation part of the widget/composite.
- `outlined_container_2.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_outlined_container_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `outlined_container_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `outlined_container.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
