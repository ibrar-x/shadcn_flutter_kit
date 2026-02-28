# Getting Started

`input` is a registry component in category `form`.

Input feature extensions for `TextField`: hint, clear/copy/paste, password toggle, autocomplete, spinner, stepper buttons, and above/below helpers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `input.dart`: Widget/composite source file in this folder.
- `input.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `input`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `input_above_below_feature.dart`: Core implementation part of the widget/composite.
- `input_auto_complete_feature.dart`: Core implementation part of the widget/composite.
- `input_clear_feature.dart`: Core implementation part of the widget/composite.
- `input_copy_feature.dart`: Core implementation part of the widget/composite.
- `input_hint_feature.dart`: Core implementation part of the widget/composite.
- `input_leading_feature.dart`: Core implementation part of the widget/composite.
- `input_password_toggle_feature.dart`: Core implementation part of the widget/composite.
- `input_paste_feature.dart`: Core implementation part of the widget/composite.
- `input_revalidate_feature.dart`: Core implementation part of the widget/composite.
- `input_spinner_feature.dart`: Core implementation part of the widget/composite.
- `input_stepper_button_feature.dart`: Core implementation part of the widget/composite.
- `input_trailing_feature.dart`: Core implementation part of the widget/composite.
- `password_peek_mode.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_auto_complete_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_above_below_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_clear_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_copy_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_hint_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_leading_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_password_toggle_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_paste_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_revalidate_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_spinner_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_stepper_button_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_trailing_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `input_show_hint_intent.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `input.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
