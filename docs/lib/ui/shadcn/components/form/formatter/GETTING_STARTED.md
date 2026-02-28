# Getting Started

`formatter` is a registry component in category `form`.

Reusable text input formatters (uppercase/lowercase, numeric, math, HEX, etc.) and helpers for selection clipping.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `formatter.dart`: Widget/composite source file in this folder.
- `formatter.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `formatter`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- (empty)

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

- `_double_only_formatter.dart`: Utility helpers used by this widget implementation.
- `_hex_text_formatter.dart`: Utility helpers used by this widget implementation.
- `_integer_only_formatter.dart`: Utility helpers used by this widget implementation.
- `_math_expression_formatter.dart`: Utility helpers used by this widget implementation.
- `_time_formatter.dart`: Utility helpers used by this widget implementation.
- `_to_lower_case_text_formatter.dart`: Utility helpers used by this widget implementation.
- `_to_upper_case_text_formatter.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `formatter.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
