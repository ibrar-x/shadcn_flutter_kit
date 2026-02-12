# Getting Started

`refresh_trigger` is a registry component in category `overlay`.

Pull-to-refresh wrapper with customizable indicator, extents, and completion animations.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `refresh_trigger.dart`: Widget/composite source file in this folder.
- `refresh_trigger.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `refresh_trigger`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `default_refresh_indicator.dart`: Core implementation part of the widget/composite.
- `refresh_trigger_stage.dart`: Core implementation part of the widget/composite.
- `refresh_trigger_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_default_refresh_indicator_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `refresh_trigger_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `refresh_trigger_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `_refresh_trigger_tween.dart`: Utility helpers used by this widget implementation.
- `refresh_trigger_physics.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `refresh_trigger.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
