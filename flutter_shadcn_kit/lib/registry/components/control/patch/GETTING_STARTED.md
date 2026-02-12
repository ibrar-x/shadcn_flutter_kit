# Getting Started

`patch` is a registry component in category `control`.

Tracks consecutive taps and exposes click count details.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `patch.dart`: Widget/composite source file in this folder.
- `patch.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `patch`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `click_detector.dart`: Core implementation part of the widget/composite.
- `patch_preview.dart`: Preview wiring for docs/gallery examples.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `click_detector_state.dart`: State class/controller for interaction and derived UI state.
- `patch_preview_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- `click_details.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `patch.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
