# Getting Started

`stepper` is a registry component in category `navigation`.

Multi-step progress with interactive step indicators.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `stepper.dart`: Widget/composite source file in this folder.
- `stepper.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `stepper`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `step.dart`: Core implementation part of the widget/composite.
- `step_container.dart`: Core implementation part of the widget/composite.
- `step_number.dart`: Core implementation part of the widget/composite.
- `step_number_data.dart`: Core implementation part of the widget/composite.
- `step_properties.dart`: Core implementation part of the widget/composite.
- `step_title.dart`: Core implementation part of the widget/composite.
- `stepper_2.dart`: Core implementation part of the widget/composite.
- `stepper_value.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_step_container_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_stepper_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `stepper_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `stepper_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- `_step_variant_circle.dart`: Variant-specific implementation details.
- `_step_variant_circle_alternative.dart`: Variant-specific implementation details.
- `_step_variant_line.dart`: Variant-specific implementation details.
- `step_variant.dart`: Variant-specific implementation details.

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `stepper.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
