# Getting Started

`input_otp` is a registry component in category `form`.

Fixed-length OTP input field with clipboard integration, paste handling, and focus management.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `input_otp.dart`: Widget/composite source file in this folder.
- `input_otp.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `input_otp`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_input_otp_child.dart`: Core implementation part of the widget/composite.
- `_input_otp_spacing.dart`: Core implementation part of the widget/composite.
- `_otp_character_input.dart`: Core implementation part of the widget/composite.
- `character_input_otp_child.dart`: Core implementation part of the widget/composite.
- `input_otp_child.dart`: Core implementation part of the widget/composite.
- `input_otp_child_data.dart`: Core implementation part of the widget/composite.
- `otp_separator.dart`: Core implementation part of the widget/composite.
- `widget_input_otp_child.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_input_otp_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_otp_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_otp_character_input_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `input_otp_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `input_otp.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
