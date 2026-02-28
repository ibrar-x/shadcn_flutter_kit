# Getting Started

`calendar` is a registry component in category `display`.

Date picker and calendar widgets for single, range, and multi selection.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `_calendar_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `calendar.dart`: Widget/composite source file in this folder.
- `calendar.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `calendar`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_calendar_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_date_picker_dialog_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `calendar_grid.dart`: Core implementation part of the widget/composite.
- `calendar_grid_data.dart`: Core implementation part of the widget/composite.
- `calendar_grid_item.dart`: Core implementation part of the widget/composite.
- `calendar_item.dart`: Core implementation part of the widget/composite.
- `calendar_item_type.dart`: Core implementation part of the widget/composite.
- `calendar_month_year.dart`: Core implementation part of the widget/composite.
- `calendar_widget.dart`: Core implementation part of the widget/composite.
- `date_picker_dialog.dart`: Core implementation part of the widget/composite.
- `year_calendar.dart`: Core implementation part of the widget/composite.

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

- `calendar_selection_mode.dart`: Theme model/helpers for styling resolution.
- `calendar_theme.dart`: Theme model/helpers for styling resolution.
- `calendar_view_type.dart`: Theme model/helpers for styling resolution.
- `date_state.dart`: State class/controller for interaction and derived UI state.

### `utils/`
Small reusable helper functions/models.

- `calendar_value.dart`: Utility helpers used by this widget implementation.
- `calendar_value_lookup.dart`: Utility helpers used by this widget implementation.
- `calendar_view.dart`: Utility helpers used by this widget implementation.
- `multi_calendar_value.dart`: Utility helpers used by this widget implementation.
- `range_calendar_value.dart`: Utility helpers used by this widget implementation.
- `single_calendar_value.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `calendar.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
