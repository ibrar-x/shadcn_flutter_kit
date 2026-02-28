# Getting Started

`window` is a registry component in category `layout`.

Desktop-style window system with drag, resize, and snapping.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `window.dart`: Widget/composite source file in this folder.
- `window.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `window`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_blur_container.dart`: Core implementation part of the widget/composite.
- `_dragging_window.dart`: Core implementation part of the widget/composite.
- `_snap_hover.dart`: Core implementation part of the widget/composite.
- `_window_layer_group.dart`: Core implementation part of the widget/composite.
- `window_2.dart`: Core implementation part of the widget/composite.
- `window_actions.dart`: Core implementation part of the widget/composite.
- `window_navigator.dart`: Core implementation part of the widget/composite.
- `window_snap_strategy.dart`: Core implementation part of the widget/composite.
- `window_viewport.dart`: Core implementation part of the widget/composite.
- `window_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_snap_hover_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_window_navigator_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_window_widget_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `window_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `window_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `window.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
