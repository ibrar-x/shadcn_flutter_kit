# Getting Started

`object_input` is a registry component in category `form`.

Date, time, and duration inputs powered by formatted editors and pickers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `object_input.dart`: Widget/composite source file in this folder.
- `object_input.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `object_input`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `duration_input.dart`: Core implementation part of the widget/composite.
- `nullable_date.dart`: Core implementation part of the widget/composite.
- `nullable_time_of_day.dart`: Core implementation part of the widget/composite.
- `time_input.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_date_input_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_duration_input_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_object_input_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_time_input_state.dart`: Private state class for widget lifecycle and interaction behavior.

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
3. `object_input.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
