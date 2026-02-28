# Getting Started

`keyboard_shortcut` is a registry component in category `display`.

Displays keyboard shortcuts as styled keycaps.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `keyboard_shortcut.dart`: Widget/composite source file in this folder.
- `keyboard_shortcut.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `keyboard_shortcut`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `keyboard_display.dart`: Core implementation part of the widget/composite.
- `keyboard_key_display.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- (empty)

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `keyboard_shortcut_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `_keyboard_shortcut_display_mapper_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `keyboard_shortcut_display_mapper.dart`: Utility helpers used by this widget implementation.
- `keyboard_shortcut_mapper.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `keyboard_shortcut.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
