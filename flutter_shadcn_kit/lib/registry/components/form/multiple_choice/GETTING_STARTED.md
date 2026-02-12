# Getting Started

`multiple_choice` is a registry component in category `form`.

Choice widgets with single or multiple selection and form integration.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `multiple_choice.dart`: Widget/composite source file in this folder.
- `multiple_choice.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `multiple_choice`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `choice.dart`: Core implementation part of the widget/composite.
- `controlled_multiple_answer.dart`: Core implementation part of the widget/composite.
- `controlled_multiple_choice.dart`: Core implementation part of the widget/composite.
- `multiple_answer.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_multiple_answer_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_multiple_choice_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_multiple_choice_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `multiple_choice_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `multiple_answer_controller.dart`: Utility helpers used by this widget implementation.
- `multiple_choice_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `multiple_choice.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
