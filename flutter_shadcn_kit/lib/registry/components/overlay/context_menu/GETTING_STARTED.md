# Getting Started

`context_menu` is a registry component in category `overlay`.

Desktop-style context menu overlay for editable text and custom actions.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `context_menu.dart`: Widget/composite source file in this folder.
- `context_menu.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `context_menu`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_context_menu_scope.dart`: Core implementation part of the widget/composite.
- `context_menu_popup.dart`: Core implementation part of the widget/composite.
- `context_menu_widget.dart`: Core implementation part of the widget/composite.
- `desktop_editable_text_context_menu.dart`: Core implementation part of the widget/composite.
- `mobile_editable_text_context_menu.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_context_menu_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_context_menu_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `context_menu_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `context_menu.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
