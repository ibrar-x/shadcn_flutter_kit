# Getting Started

`app` is a registry composite in category `layout`.

Composite app wrapper with shadcn theme and overlay handling.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `app.dart`: Widget/composite source file in this folder.
- `app.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `_impl/`: Private implementation details that support `app`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `shadcn_ui.dart`: Core implementation part of the widget/composite.

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
3. `app.dart`
4. `_impl/core/`
5. `_impl/state/`
6. `_impl/styles/`
7. `_impl/themes/`
8. `_impl/variants/`
9. `_impl/utils/`
10. `_impl/extensions/`
