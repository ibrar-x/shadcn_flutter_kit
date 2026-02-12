# Getting Started

`navigation_menu` is a registry component in category `navigation`.

Dropdown-style navigation menu with popovers, groups, and keyboard navigation.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `navigation_menu.dart`: Widget/composite source file in this folder.
- `navigation_menu.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `navigation_menu`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `navigation_menu_2.dart`: Core implementation part of the widget/composite.
- `navigation_menu_content.dart`: Core implementation part of the widget/composite.
- `navigation_menu_content_list.dart`: Core implementation part of the widget/composite.
- `navigation_menu_item.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `navigation_menu_item_state.dart`: State class/controller for interaction and derived UI state.
- `navigation_menu_state.dart`: State class/controller for interaction and derived UI state.

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
3. `navigation_menu.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
