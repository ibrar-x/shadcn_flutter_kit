# Getting Started

`radio_group` is a registry component in category `form`.

Exclusive selection group with radio items and cards.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `radio_group.dart`: Widget/composite source file in this folder.
- `radio_group.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `radio_group`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `controlled_radio_group.dart`: Core implementation part of the widget/composite.
- `radio.dart`: Core implementation part of the widget/composite.
- `radio_card.dart`: Core implementation part of the widget/composite.
- `radio_group_data.dart`: Core implementation part of the widget/composite.
- `radio_item.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_radio_card_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_radio_group_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_radio_item_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `radio_group_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `radio_card_theme.dart`: Theme model/helpers for styling resolution.
- `radio_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `next_item_intent.dart`: Utility helpers used by this widget implementation.
- `previous_item_intent.dart`: Utility helpers used by this widget implementation.
- `radio_group_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `radio_group.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
