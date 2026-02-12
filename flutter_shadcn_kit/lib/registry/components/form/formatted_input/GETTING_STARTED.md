# Getting Started

`formatted_input` is a registry component in category `form`.

Low-level formatted-field helpers that sync multiple InputPart segments.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `formatted_input.dart`: Widget/composite source file in this folder.
- `formatted_input.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `formatted_input`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_editable_part_widget.dart`: Core implementation part of the widget/composite.
- `_static_part_widget.dart`: Core implementation part of the widget/composite.
- `editable_part.dart`: Core implementation part of the widget/composite.
- `formatted_input_data.dart`: Core implementation part of the widget/composite.
- `formatted_object_input.dart`: Core implementation part of the widget/composite.
- `formatted_value.dart`: Core implementation part of the widget/composite.
- `formatted_value_part.dart`: Core implementation part of the widget/composite.
- `input_part.dart`: Core implementation part of the widget/composite.
- `static_part.dart`: Core implementation part of the widget/composite.
- `widget_part.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_editable_part_widget_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_formatted_input_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_formatted_object_input_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_static_part_widget_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `formatted_input_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `_editable_part_controller.dart`: Utility helpers used by this widget implementation.
- `_formatted_object_controller.dart`: Utility helpers used by this widget implementation.
- `formatted_input_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `formatted_input.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
