# Getting Started

`border_loading` is a registry component in category `display`.

Animated border wrapper for loading, tracer, static, and determinate progress states.

## Folder Map

- `GETTING_STARTED.md`: Folder orientation guide (this file).
- `README.md`: Primary component docs and usage guidance for contributors/users.
- `border_loading.dart`: Widget/composite source file in this folder.
- `border_loading.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `border_loading`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `border_loading_painter.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `border_loading_controller.dart`: Controller/state-coordination logic for this widget.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `gradient_adapter.dart`: Utility helpers used by this widget implementation.
- `shape_path.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- `border_progress_painter.dart`: Variant-specific implementation details.
- `border_tracer_painter.dart`: Variant-specific implementation details.

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `border_loading.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
