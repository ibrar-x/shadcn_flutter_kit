# Getting Started

`basic` is a registry component in category `layout`.

Flexible row layout for leading/title/content/trailing sections.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `basic.dart`: Widget/composite source file in this folder.
- `basic.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `basic`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `basic_2.dart`: Core implementation part of the widget/composite.
- `basic_layout.dart`: Core implementation part of the widget/composite.
- `label.dart`: Core implementation part of the widget/composite.

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
3. `basic.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
