# Getting Started

`form` is a registry component in category `form`.

Composable form state, validation, and submit helpers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `form.dart`: Widget/composite source file in this folder.
- `form.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `form`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_form_entry_cached_value.dart`: Core implementation part of the widget/composite.
- `_form_entry_handle_interceptor.dart`: Core implementation part of the widget/composite.
- `_validator_result_stash.dart`: Core implementation part of the widget/composite.
- `compare_to.dart`: Core implementation part of the widget/composite.
- `compare_type.dart`: Core implementation part of the widget/composite.
- `compare_with.dart`: Core implementation part of the widget/composite.
- `composite_validator.dart`: Core implementation part of the widget/composite.
- `conditional_validator.dart`: Core implementation part of the widget/composite.
- `email_validator.dart`: Core implementation part of the widget/composite.
- `form_entry.dart`: Core implementation part of the widget/composite.
- `form_entry_interceptor.dart`: Core implementation part of the widget/composite.
- `form_field.dart`: Core implementation part of the widget/composite.
- `form_field_handle.dart`: Core implementation part of the widget/composite.
- `form_inline.dart`: Core implementation part of the widget/composite.
- `form_key.dart`: Core implementation part of the widget/composite.
- `form_table_layout.dart`: Core implementation part of the widget/composite.
- `form_validation_mode.dart`: Core implementation part of the widget/composite.
- `form_validity_notification.dart`: Core implementation part of the widget/composite.
- `form_value_supplier.dart`: Core implementation part of the widget/composite.
- `ignore_form.dart`: Core implementation part of the widget/composite.
- `invalid_result.dart`: Core implementation part of the widget/composite.
- `length_validator.dart`: Core implementation part of the widget/composite.
- `max_validator.dart`: Core implementation part of the widget/composite.
- `min_validator.dart`: Core implementation part of the widget/composite.
- `non_null_validator.dart`: Core implementation part of the widget/composite.
- `not_empty_validator.dart`: Core implementation part of the widget/composite.
- `not_validator.dart`: Core implementation part of the widget/composite.
- `or_validator.dart`: Core implementation part of the widget/composite.
- `range_validator.dart`: Core implementation part of the widget/composite.
- `regex_validator.dart`: Core implementation part of the widget/composite.
- `replace_result.dart`: Core implementation part of the widget/composite.
- `safe_password_validator.dart`: Core implementation part of the widget/composite.
- `submission_result.dart`: Core implementation part of the widget/composite.
- `submit_button.dart`: Core implementation part of the widget/composite.
- `url_validator.dart`: Core implementation part of the widget/composite.
- `validation_mode.dart`: Core implementation part of the widget/composite.
- `validation_result.dart`: Core implementation part of the widget/composite.
- `validator.dart`: Core implementation part of the widget/composite.
- `waiting_result.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_form_entry_interceptor_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `form_entry_state.dart`: State class/controller for interaction and derived UI state.
- `form_state.dart`: State class/controller for interaction and derived UI state.
- `form_value_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `form_controller.dart`: Utility helpers used by this widget implementation.
- `form_entry_error_builder.dart`: Utility helpers used by this widget implementation.
- `form_error_builder.dart`: Utility helpers used by this widget implementation.
- `form_pending_builder.dart`: Utility helpers used by this widget implementation.
- `validator_builder.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `form.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
