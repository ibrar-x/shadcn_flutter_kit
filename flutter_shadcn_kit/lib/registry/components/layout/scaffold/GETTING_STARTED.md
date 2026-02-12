# Getting Started

`scaffold` is a registry component in category `layout`.

Layout scaffold with headers, footers, and loading indicators.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `scaffold.dart`: Widget/composite source file in this folder.
- `scaffold.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `scaffold`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_render_scaffold_padding.dart`: Core implementation part of the widget/composite.
- `_scaffold_flex.dart`: Core implementation part of the widget/composite.
- `_scaffold_parent_data.dart`: Core implementation part of the widget/composite.
- `_scaffold_render_flex.dart`: Core implementation part of the widget/composite.
- `app_bar.dart`: Core implementation part of the widget/composite.
- `scaffold_2.dart`: Core implementation part of the widget/composite.
- `scaffold_bar_data.dart`: Core implementation part of the widget/composite.
- `scaffold_box_constraints.dart`: Core implementation part of the widget/composite.
- `scaffold_footer_padding.dart`: Core implementation part of the widget/composite.
- `scaffold_header_padding.dart`: Core implementation part of the widget/composite.
- `scaffold_padding_storage.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_app_bar_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `scaffold_state.dart`: State class/controller for interaction and derived UI state.

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
3. `scaffold.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
