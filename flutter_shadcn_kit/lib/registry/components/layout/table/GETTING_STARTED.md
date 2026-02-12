# Getting Started

`table` is a registry component in category `layout`.

Resizable table layout with headers, footers, and frozen cells.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `table.dart`: Widget/composite source file in this folder.
- `table.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `table`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `cell_predicate.dart`: Core implementation part of the widget/composite.
- `cell_resizer.dart`: Core implementation part of the widget/composite.
- `constrained_table_size.dart`: Core implementation part of the widget/composite.
- `flattened_table_cell.dart`: Core implementation part of the widget/composite.
- `frozen_table_data.dart`: Core implementation part of the widget/composite.
- `hover_callback.dart`: Core implementation part of the widget/composite.
- `hovered_cell.dart`: Core implementation part of the widget/composite.
- `hovered_line.dart`: Core implementation part of the widget/composite.
- `intrinsic_computer.dart`: Core implementation part of the widget/composite.
- `raw_cell.dart`: Core implementation part of the widget/composite.
- `raw_table_layout.dart`: Core implementation part of the widget/composite.
- `render_table_layout_part1.dart`: Core implementation part of the widget/composite.
- `resizable_table.dart`: Core implementation part of the widget/composite.
- `resizable_table_data.dart`: Core implementation part of the widget/composite.
- `table_cell.dart`: Core implementation part of the widget/composite.
- `table_cell_data.dart`: Core implementation part of the widget/composite.
- `table_cell_resize_mode.dart`: Core implementation part of the widget/composite.
- `table_footer.dart`: Core implementation part of the widget/composite.
- `table_header.dart`: Core implementation part of the widget/composite.
- `table_layout_result.dart`: Core implementation part of the widget/composite.
- `table_parent_data.dart`: Core implementation part of the widget/composite.
- `table_ref.dart`: Core implementation part of the widget/composite.
- `table_row.dart`: Core implementation part of the widget/composite.
- `table_size_supplier.dart`: Core implementation part of the widget/composite.
- `table_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `cell_resizer_state_part1.dart`: Widget/composite source file in this folder.
- `resizable_table_state.dart`: State class/controller for interaction and derived UI state.
- `table_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `resizable_table_theme.dart`: Theme model/helpers for styling resolution.
- `table_cell_theme.dart`: Theme model/helpers for styling resolution.
- `table_cell_theme_builder.dart`: Theme model/helpers for styling resolution.
- `table_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `resizable_table_controller.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `table.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
