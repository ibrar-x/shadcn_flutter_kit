# Getting Started

`date_picker` is a registry component in category `form`.

Popover/dialog calendar for single-date and range selection.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `date_picker.dart`: Widget/composite source file in this folder.
- `date_picker.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `date_picker`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `controlled_date_picker.dart`: Core implementation part of the widget/composite.
- `date_range_picker.dart`: Core implementation part of the widget/composite.
- `date_time_range.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_date_picker_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `date_picker_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `date_picker_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `date_picker.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
