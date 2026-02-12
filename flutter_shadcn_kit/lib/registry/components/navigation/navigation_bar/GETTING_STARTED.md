# Getting Started

`navigation_bar` is a registry component in category `navigation`.

Themed navigation bar supporting destinations, overflow, and responsive layout.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `navigation_bar.dart`: Widget/composite source file in this folder.
- `navigation_bar.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `navigation_bar`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_navigation_child_overflow_handle.dart`: Core implementation part of the widget/composite.
- `_navigation_label_background_painter.dart`: Core implementation part of the widget/composite.
- `_navigation_labeled.dart`: Core implementation part of the widget/composite.
- `abstract_navigation_button.dart`: Core implementation part of the widget/composite.
- `navigation_bar_2.dart`: Core implementation part of the widget/composite.
- `navigation_bar_item.dart`: Core implementation part of the widget/composite.
- `navigation_button.dart`: Core implementation part of the widget/composite.
- `navigation_child_control_data.dart`: Core implementation part of the widget/composite.
- `navigation_control_data.dart`: Core implementation part of the widget/composite.
- `navigation_divider.dart`: Core implementation part of the widget/composite.
- `navigation_gap.dart`: Core implementation part of the widget/composite.
- `navigation_item.dart`: Core implementation part of the widget/composite.
- `navigation_label.dart`: Core implementation part of the widget/composite.
- `navigation_padding.dart`: Core implementation part of the widget/composite.
- `navigation_rail.dart`: Core implementation part of the widget/composite.
- `navigation_sidebar.dart`: Core implementation part of the widget/composite.
- `navigation_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_abstract_navigation_button_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_navigation_bar_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_navigation_bar_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_navigation_button_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_navigation_item_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_navigation_rail_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_navigation_sidebar_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `navigation_bar_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `_navigation_label_delegate.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `navigation_bar.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
