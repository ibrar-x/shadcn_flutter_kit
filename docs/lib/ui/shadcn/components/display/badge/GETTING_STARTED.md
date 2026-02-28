# Getting Started

`badge` is a registry component in category `display`.

Compact label/status components built on button styles.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `badge.dart`: Widget/composite source file in this folder.
- `badge.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `badge`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `badge_widgets.dart`: Core implementation part of the widget/composite.
- `destructive_badge.dart`: Core implementation part of the widget/composite.
- `outline_badge.dart`: Core implementation part of the widget/composite.
- `secondary_badge.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- (empty)

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `badge_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `badge.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
