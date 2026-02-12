# Getting Started

`timeline_animation` is a registry composite in category `animation`.

Composite export for timeline keyframes and helpers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `timeline_animation.dart`: Widget/composite source file in this folder.
- `timeline_animation.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `timeline_animation`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `absolute_keyframe.dart`: Core implementation part of the widget/composite.
- `keyframe.dart`: Core implementation part of the widget/composite.
- `relative_keyframe.dart`: Core implementation part of the widget/composite.
- `still_keyframe.dart`: Core implementation part of the widget/composite.
- `timeline_animation_widget.dart`: Core implementation part of the widget/composite.

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

- (empty)

### `utils/`
Small reusable helper functions/models.

- `timeline_animatable.dart`: Utility helpers used by this widget implementation.
- `transformers.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `timeline_animation.dart`
4. `_impl/core/`
5. `_impl/state/`
6. `_impl/styles/`
7. `_impl/themes/`
8. `_impl/variants/`
9. `_impl/utils/`
10. `_impl/extensions/`
