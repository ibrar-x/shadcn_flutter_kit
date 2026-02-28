# Getting Started

`menu` is a registry component in category `overlay`.

Menu primitives, items, and popup container.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `menu.dart`: Widget/composite source file in this folder.
- `menu.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `menu`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `menu_button.dart`: Core implementation part of the widget/composite.
- `menu_checkbox.dart`: Core implementation part of the widget/composite.
- `menu_data.dart`: Core implementation part of the widget/composite.
- `menu_divider.dart`: Core implementation part of the widget/composite.
- `menu_gap.dart`: Core implementation part of the widget/composite.
- `menu_group.dart`: Core implementation part of the widget/composite.
- `menu_group_data.dart`: Core implementation part of the widget/composite.
- `menu_item.dart`: Core implementation part of the widget/composite.
- `menu_label.dart`: Core implementation part of the widget/composite.
- `menu_popup.dart`: Core implementation part of the widget/composite.
- `menu_radio.dart`: Core implementation part of the widget/composite.
- `menu_radio_group.dart`: Core implementation part of the widget/composite.
- `menu_shortcut.dart`: Core implementation part of the widget/composite.
- `menubar.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_menu_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `menu_button_state.dart`: State class/controller for interaction and derived UI state.
- `menu_group_state.dart`: State class/controller for interaction and derived UI state.
- `menubar_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- `menu_text_styles.dart`: Style model/helpers for visual variants and overrides.

### `themes/`
Theme data and ThemeExtension integration.

- `menu_popup_theme.dart`: Theme model/helpers for styling resolution.
- `menu_theme.dart`: Theme model/helpers for styling resolution.
- `menubar_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `menu_directional_intent.dart`: Utility helpers used by this widget implementation.
- `menu_intents.dart`: Utility helpers used by this widget implementation.
- `menu_overlay_handler.dart`: Utility helpers used by this widget implementation.
- `next_menu_focus_intent.dart`: Utility helpers used by this widget implementation.
- `open_sub_menu_intent.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `menu.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
