# Getting Started

`item_picker` is a registry component in category `form`.

Grid/list picker with selection chips, search, and in-place actions.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `item_picker.dart`: Widget/composite source file in this folder.
- `item_picker.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `item_picker`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_internal_item_picker.dart`: Core implementation part of the widget/composite.
- `grid_item_picker_layout.dart`: Core implementation part of the widget/composite.
- `item_list.dart`: Core implementation part of the widget/composite.
- `item_picker_data.dart`: Core implementation part of the widget/composite.
- `item_picker_dialog.dart`: Core implementation part of the widget/composite.
- `item_picker_layout.dart`: Core implementation part of the widget/composite.
- `item_picker_option.dart`: Core implementation part of the widget/composite.
- `list_item_picker_layout.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_item_picker_dialog_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_item_picker_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `item_builder.dart`: Utility helpers used by this widget implementation.
- `item_child_delegate.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `item_picker.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
