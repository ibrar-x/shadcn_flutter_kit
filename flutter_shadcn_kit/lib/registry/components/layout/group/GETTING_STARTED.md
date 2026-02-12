# Getting Started

`group` is a registry component in category `layout`.

Absolute-position layout surface with explicit offsets and sizes.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `group.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `group_widget.dart`: Widget/composite source file in this folder.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `group`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `group_parent_data.dart`: Core implementation part of the widget/composite.
- `group_positioned.dart`: Core implementation part of the widget/composite.
- `render_group.dart`: Core implementation part of the widget/composite.

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

- (empty)

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `preview.dart`
4. `_impl/core/`
5. `_impl/state/`
6. `_impl/styles/`
7. `_impl/themes/`
8. `_impl/variants/`
9. `_impl/utils/`
10. `_impl/extensions/`
