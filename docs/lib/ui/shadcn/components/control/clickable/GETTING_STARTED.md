# Getting Started

`clickable` is a registry component in category `control`.

State-aware gesture surface with hover, focus, and press handling.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `clickable.dart`: Widget/composite source file in this folder.
- `clickable.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `clickable`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `builder_stated_widget.dart`: Core implementation part of the widget/composite.
- `clickable_widget.dart`: Core implementation part of the widget/composite.
- `map_stated_widget.dart`: Core implementation part of the widget/composite.
- `param_stated_widget.dart`: Core implementation part of the widget/composite.
- `stated_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- `widget_state_extension.dart`: Extension methods to simplify API usage.

### `state/`
State objects, controllers, and mutable interaction logic.

- `clickable_state.dart`: State class/controller for interaction and derived UI state.
- `widget_states_data.dart`: Widget/composite source file in this folder.
- `widget_states_provider.dart`: Widget/composite source file in this folder.

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
3. `clickable.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
