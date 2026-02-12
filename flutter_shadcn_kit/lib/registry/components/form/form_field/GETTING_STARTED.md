# Getting Started

`form_field` is a registry component in category `form`.

Modal or popover editor field for complex objects.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `form_field.dart`: Widget/composite source file in this folder.
- `form_field.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `form_field`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_object_form_field_dialog.dart`: Core implementation part of the widget/composite.
- `_object_form_field_popup.dart`: Core implementation part of the widget/composite.
- `object_form_field.dart`: Core implementation part of the widget/composite.
- `object_form_field_dialog_result.dart`: Core implementation part of the widget/composite.
- `object_form_handler.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_form_field_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_object_form_field_dialog_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_object_form_field_popup_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `object_form_field_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `form_field.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
