# Getting Started

`scrollable_client` is a registry component in category `layout`.

Two-dimensional scroll surface with builder callbacks for viewport-aware layouts.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `scrollable_client.dart`: Widget/composite source file in this folder.
- `scrollable_client.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `scrollable_client`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_scrollable_client_child_vicinity.dart`: Core implementation part of the widget/composite.
- `render_scrollable_client_viewport.dart`: Core implementation part of the widget/composite.
- `scrollable_client_2.dart`: Core implementation part of the widget/composite.
- `scrollable_client_viewport.dart`: Core implementation part of the widget/composite.

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
3. `scrollable_client.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
