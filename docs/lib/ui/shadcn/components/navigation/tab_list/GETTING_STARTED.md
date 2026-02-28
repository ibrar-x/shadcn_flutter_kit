# Getting Started

`tab_list` is a registry component in category `navigation`.

Horizontal tab header row with active indicator.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `tab_list.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `tab_list`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `tab_list.dart`: Core implementation part of the widget/composite.
- `tab_list_2.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_tab_list_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- `_tab_list_text_style.dart`: Style model/helpers for visual variants and overrides.

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
3. `preview.dart`
4. `_impl/core/`
5. `_impl/state/`
6. `_impl/styles/`
7. `_impl/themes/`
8. `_impl/variants/`
9. `_impl/utils/`
10. `_impl/extensions/`
