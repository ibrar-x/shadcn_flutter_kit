# Getting Started

`tooltip` is a registry component in category `overlay`.

Hover-triggered tooltip overlays with themed containers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `tooltip.dart`: Widget/composite source file in this folder.
- `tooltip.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `tooltip`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `instant_tooltip.dart`: Core implementation part of the widget/composite.
- `tooltip_container.dart`: Core implementation part of the widget/composite.
- `tooltip_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_instant_tooltip_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_tooltip_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `tooltip_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `fixed_tooltip_overlay_handler.dart`: Utility helpers used by this widget implementation.
- `tooltip_overlay_handlers.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `tooltip.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
