# Getting Started

`autocomplete` is a registry component in category `form`.

Autocomplete overlay for text inputs with keyboard navigation and theming.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `autocomplete.dart`: Widget/composite source file in this folder.
- `autocomplete.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `autocomplete`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `auto_complete.dart`: Core implementation part of the widget/composite.
- `auto_complete_mode.dart`: Core implementation part of the widget/composite.
- `autocomplete_item.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_auto_complete_item_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_autocomplete_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `autocomplete_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `accept_suggestion_intent.dart`: Utility helpers used by this widget implementation.
- `auto_complete_intent.dart`: Utility helpers used by this widget implementation.
- `navigate_suggestion_intent.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `autocomplete.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
