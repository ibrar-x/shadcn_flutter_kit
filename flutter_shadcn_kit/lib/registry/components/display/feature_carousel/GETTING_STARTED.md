# Getting Started

`feature_carousel` is a registry component in category `display`.

Animated feature card carousel with autoplay, swipe, and CTA support. (WIP)

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `feature_carousel.dart`: Widget/composite source file in this folder.
- `feature_carousel.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `feature_carousel`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_carousel_intent.dart`: Core implementation part of the widget/composite.
- `_center_card.dart`: Core implementation part of the widget/composite.
- `_cta_button.dart`: Core implementation part of the widget/composite.
- `_feature_card_carousel_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_ghost_card.dart`: Core implementation part of the widget/composite.
- `_ghost_transform.dart`: Core implementation part of the widget/composite.
- `_nav_arrow.dart`: Core implementation part of the widget/composite.
- `feature_card_carousel.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `feature_carousel_controller.dart`: Controller/state-coordination logic for this widget.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `feature_carousel_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `feature_carousel_animation_style.dart`: Style model/helpers for visual variants and overrides.
- `feature_carousel_models.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `feature_carousel.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
