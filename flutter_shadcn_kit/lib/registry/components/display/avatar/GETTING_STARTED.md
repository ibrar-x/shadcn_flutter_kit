# Getting Started

`avatar` is a registry component in category `display`.

Initials/photo avatar with badge and group support.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `avatar.dart`: Widget/composite source file in this folder.
- `avatar.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `avatar`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_avatar_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_avatar_widget.dart`: Core implementation part of the widget/composite.
- `avatar.dart`: Core implementation part of the widget/composite.
- `avatar_badge.dart`: Core implementation part of the widget/composite.
- `avatar_group.dart`: Core implementation part of the widget/composite.
- `avatar_group_clipper.dart`: Core implementation part of the widget/composite.
- `avatar_widget.dart`: Core implementation part of the widget/composite.

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

- `avatar_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `avatar.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
