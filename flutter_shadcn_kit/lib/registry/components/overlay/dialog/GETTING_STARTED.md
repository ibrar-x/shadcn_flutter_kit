# Getting Started

`dialog` is a registry component in category `overlay`.

Modal dialog primitives with alert dialog and overlay handlers.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `dialog.dart`: Widget/composite source file in this folder.
- `dialog.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `dialog`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_dialog_overlay_wrapper.dart`: Core implementation part of the widget/composite.
- `dialog_route.dart`: Core implementation part of the widget/composite.
- `modal_backdrop.dart`: Core implementation part of the widget/composite.
- `modal_container.dart`: Core implementation part of the widget/composite.
- `surface_barrier_painter.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_dialog_overlay_wrapper_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `modal_backdrop_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `dialog_api.dart`: Utility helpers used by this widget implementation.
- `dialog_overlay_completer.dart`: Utility helpers used by this widget implementation.
- `dialog_overlay_full_screen_handler.dart`: Utility helpers used by this widget implementation.
- `dialog_overlay_handler.dart`: Utility helpers used by this widget implementation.
- `dialog_transitions.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `dialog.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
