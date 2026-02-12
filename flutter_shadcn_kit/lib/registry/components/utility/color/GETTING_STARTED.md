# Getting Started

`color` is a registry component in category `utility`.

Helper utilities for converting and transforming colors across RGB/HSV/HSL spaces.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `color.dart`: Widget/composite source file in this folder.
- `color.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `color`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `color_derivative.dart`: Core implementation part of the widget/composite.
- `color_gradient.dart`: Core implementation part of the widget/composite.
- `hsl_color_derivative.dart`: Core implementation part of the widget/composite.
- `hsv_color_derivative.dart`: Core implementation part of the widget/composite.
- `linear_color_gradient.dart`: Core implementation part of the widget/composite.
- `radial_color_gradient.dart`: Core implementation part of the widget/composite.
- `sweep_color_gradient.dart`: Core implementation part of the widget/composite.

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

- `color_stop.dart`: Utility helpers used by this widget implementation.
- `directional_gradient_angle.dart`: Utility helpers used by this widget implementation.
- `gradient_angle.dart`: Utility helpers used by this widget implementation.
- `gradient_angle_geometry.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `color.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
