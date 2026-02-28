# Getting Started

`drawer` is a registry component in category `overlay`.

Sliding drawer and sheet overlays with drag support.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `drawer.dart`: Widget/composite source file in this folder.
- `drawer.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `drawer`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `backdrop_transform_data.dart`: Core implementation part of the widget/composite.
- `drawer_close_drawer.dart`: Core implementation part of the widget/composite.
- `drawer_close_sheet.dart`: Core implementation part of the widget/composite.
- `drawer_entry_widget.dart`: Core implementation part of the widget/composite.
- `drawer_layer_data.dart`: Core implementation part of the widget/composite.
- `drawer_overlay.dart`: Core implementation part of the widget/composite.
- `drawer_overlay_entry.dart`: Core implementation part of the widget/composite.
- `drawer_overlay_wrapper.dart`: Core implementation part of the widget/composite.
- `drawer_wrapper.dart`: Core implementation part of the widget/composite.
- `mounted_overlay_entry_data.dart`: Core implementation part of the widget/composite.
- `overlay_position.dart`: Core implementation part of the widget/composite.
- `sheet_wrapper.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_drawer_overlay_wrapper_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_drawer_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_sheet_wrapper_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `drawer_entry_widget_state.dart`: State class/controller for interaction and derived UI state.
- `drawer_overlay_state.dart`: State class/controller for interaction and derived UI state.
- `drawer_wrapper_state_part1.dart`: Widget/composite source file in this folder.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `drawer_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `drawer_api.dart`: Utility helpers used by this widget implementation.
- `drawer_overlay_completer.dart`: Utility helpers used by this widget implementation.
- `drawer_raw_api.dart`: Utility helpers used by this widget implementation.
- `drawer_typedefs.dart`: Utility helpers used by this widget implementation.
- `drawer_types.dart`: Utility helpers used by this widget implementation.
- `sheet_overlay_handler.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `drawer.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
