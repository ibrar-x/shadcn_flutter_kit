# Getting Started

`flex` is a registry component in category `layout`.

Patched `Flex/Row/Column` and `Stack` widgets with custom `paintOrder` support for layered painting and top-first hit testing.

## Folder Map

- `GETTING_STARTED.md`: Folder orientation guide (this file).
- `README.md`: Primary component docs and usage guidance for contributors/users.
- `flex.dart`: Widget/composite source file in this folder.
- `flex.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `flex`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `flex_parent_data.dart`: Core implementation part of the widget/composite.
- `flex_widget.dart`: Core implementation part of the widget/composite.
- `flexible_widgets.dart`: Core implementation part of the widget/composite.
- `paint_order_mixin.dart`: Core implementation part of the widget/composite.
- `paint_order_parent_data_mixin.dart`: Core implementation part of the widget/composite.
- `positioned_widget.dart`: Core implementation part of the widget/composite.
- `render_flex.dart`: Core implementation part of the widget/composite.
- `render_stack.dart`: Core implementation part of the widget/composite.
- `stack_parent_data.dart`: Core implementation part of the widget/composite.
- `stack_widget.dart`: Core implementation part of the widget/composite.

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
3. `flex.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
