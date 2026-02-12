# Getting Started

`filter_bar` is a registry component in category `layout`.

Controlled filter header with search, sort, chips, date range, and clear-all actions.

## Folder Map

- `GETTING_STARTED.md`: Folder orientation guide (this file).
- `README.md`: Primary component docs and usage guidance for contributors/users.
- `filter_bar.dart`: Widget/composite source file in this folder.
- `filter_bar.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `filter_bar`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `filter_bar_content.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- `filter_state_extensions.dart`: Extension methods to simplify API usage.

### `state/`
State objects, controllers, and mutable interaction logic.

- `filter_bar_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- `filter_bar_style.dart`: Style model/helpers for visual variants and overrides.

### `themes/`
Theme data and ThemeExtension integration.

- `filter_bar_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `filter_bar_utils.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- `filter_bar_layout.dart`: Variant-specific implementation details.

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `filter_bar.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
