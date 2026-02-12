# Getting Started

`tabs` is a registry component in category `navigation`.

Tabbed navigation primitives with lists and panes.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `tabs.dart`: Widget/composite source file in this folder.
- `tabs.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `tabs`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `clip_rect_with_adjustment.dart`: Core implementation part of the widget/composite.
- `keyed_tab_child_widget.dart`: Core implementation part of the widget/composite.
- `keyed_tab_item.dart`: Core implementation part of the widget/composite.
- `tab_child_widget.dart`: Core implementation part of the widget/composite.
- `tab_container.dart`: Core implementation part of the widget/composite.
- `tab_container_data.dart`: Core implementation part of the widget/composite.
- `tab_ghost_data.dart`: Core implementation part of the widget/composite.
- `tab_item.dart`: Core implementation part of the widget/composite.
- `tab_item_painter.dart`: Core implementation part of the widget/composite.
- `tab_list.dart`: Core implementation part of the widget/composite.
- `tab_pane_data.dart`: Core implementation part of the widget/composite.
- `tab_pane_typedefs.dart`: Core implementation part of the widget/composite.
- `tab_pane_widget.dart`: Core implementation part of the widget/composite.
- `tabs_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_tabs_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `tab_pane_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- `tabs_text_styles.dart`: Style model/helpers for visual variants and overrides.

### `themes/`
Theme data and ThemeExtension integration.

- `tab_container_theme.dart`: Theme model/helpers for styling resolution.
- `tab_list_theme.dart`: Theme model/helpers for styling resolution.
- `tab_pane_theme.dart`: Theme model/helpers for styling resolution.
- `tabs_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `tab_builder_typedefs.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `tabs.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
