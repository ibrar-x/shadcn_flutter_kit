# Getting Started

`hover` is a registry component in category `control`.

Hover timing helpers plus lightweight state tracking widgets.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `hover.dart`: Widget/composite source file in this folder.
- `hover.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `hover`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `hover_activity.dart`: Core implementation part of the widget/composite.
- `hover_preview.dart`: Preview wiring for docs/gallery examples.
- `hover_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `hover_activity_state.dart`: State class/controller for interaction and derived UI state.
- `hover_preview_state.dart`: State class/controller for interaction and derived UI state.
- `hover_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `hover_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `hover.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
