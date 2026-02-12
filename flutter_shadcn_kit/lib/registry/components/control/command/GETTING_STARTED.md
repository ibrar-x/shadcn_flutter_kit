# Getting Started

`command` is a registry component in category `control`.

Command palette with search, keyboard navigation, and customizable result builders.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `command.dart`: Widget/composite source file in this folder.
- `command.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `command`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `command_category.dart`: Core implementation part of the widget/composite.
- `command_dialog.dart`: Core implementation part of the widget/composite.
- `command_empty.dart`: Core implementation part of the widget/composite.
- `command_item_widget.dart`: Core implementation part of the widget/composite.
- `command_keyboard_display.dart`: Core implementation part of the widget/composite.
- `command_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `command_item_state.dart`: State class/controller for interaction and derived UI state.
- `command_query.dart`: Widget/composite source file in this folder.
- `command_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `next_item_intent.dart`: Utility helpers used by this widget implementation.
- `previous_item_intent.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `command.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
