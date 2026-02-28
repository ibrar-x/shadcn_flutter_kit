# Getting Started

`color_picker` is a registry component in category `form`.

HSV/HSL/HEX color picker with popovers, eye dropper, and history controls.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `color_picker.dart`: Widget/composite source file in this folder.
- `color_picker.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `color_picker`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_color_value_input.dart`: Core implementation part of the widget/composite.
- `color_controls.dart`: Core implementation part of the widget/composite.
- `color_picker_mode.dart`: Core implementation part of the widget/composite.
- `hsl_color_slider.dart`: Core implementation part of the widget/composite.
- `hsl_color_slider_painter.dart`: Core implementation part of the widget/composite.
- `hsl_color_slider_type.dart`: Core implementation part of the widget/composite.
- `hsv_color_slider.dart`: Core implementation part of the widget/composite.
- `hsv_color_slider_painter.dart`: Core implementation part of the widget/composite.
- `hsv_color_slider_type.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_color_picker_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_color_picker_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_color_value_input_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_hsl_color_slider_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_hsv_color_slider_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `color_picker_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `color_picker.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
