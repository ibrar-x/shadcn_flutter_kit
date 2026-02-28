# Getting Started

`carousel` is a registry component in category `display`.

Interactive carousel with sliding/fading transitions and autoplay controls.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `_carousel_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `carousel.dart`: Widget/composite source file in this folder.
- `carousel.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `carousel`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_placed_carousel_item.dart`: Core implementation part of the widget/composite.
- `carousel_alignment.dart`: Core implementation part of the widget/composite.
- `carousel_dot_indicator.dart`: Core implementation part of the widget/composite.
- `carousel_fixed_constraint.dart`: Core implementation part of the widget/composite.
- `carousel_fractional_constraint.dart`: Core implementation part of the widget/composite.
- `carousel_layout.dart`: Core implementation part of the widget/composite.
- `carousel_transition.dart`: Core implementation part of the widget/composite.
- `fading_carousel_transition.dart`: Core implementation part of the widget/composite.
- `sliding_carousel_transition.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_carousel_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `carousel_controller.dart`: Controller/state-coordination logic for this widget.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `carousel_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `carousel.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
