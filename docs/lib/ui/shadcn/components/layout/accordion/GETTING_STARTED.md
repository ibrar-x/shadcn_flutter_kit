# Getting Started

`accordion` is a registry component in category `layout`.

Single-expansion accordion with configurable triggers and theming.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `accordion.dart`: Widget/composite source file in this folder.
- `accordion.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `accordion`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `accordion_item.dart`: Core implementation part of the widget/composite.
- `accordion_trigger.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_accordion_item_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_accordion_trigger_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `accordion_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `accordion_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `accordion.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
