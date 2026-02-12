# Getting Started

`select` is a registry component in category `form`.

Dropdown/select control with popup menus, grouped items, and keyboard navigation.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `select.dart`: Widget/composite source file in this folder.
- `select.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `select`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `controlled_multi_select.dart`: Core implementation part of the widget/composite.
- `controlled_select.dart`: Core implementation part of the widget/composite.
- `empty_select_item.dart`: Core implementation part of the widget/composite.
- `multi_select.dart`: Core implementation part of the widget/composite.
- `multi_select_chip.dart`: Core implementation part of the widget/composite.
- `select_base.dart`: Core implementation part of the widget/composite.
- `select_data.dart`: Core implementation part of the widget/composite.
- `select_group.dart`: Core implementation part of the widget/composite.
- `select_item.dart`: Core implementation part of the widget/composite.
- `select_item_button.dart`: Core implementation part of the widget/composite.
- `select_item_list.dart`: Core implementation part of the widget/composite.
- `select_label.dart`: Core implementation part of the widget/composite.
- `select_popup.dart`: Core implementation part of the widget/composite.
- `select_popup_handle.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_select_popup_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_select_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `select_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `select_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `multi_select_controller.dart`: Utility helpers used by this widget implementation.
- `select_controller.dart`: Utility helpers used by this widget implementation.
- `select_item_builder.dart`: Utility helpers used by this widget implementation.
- `select_item_delegate.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `select.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
