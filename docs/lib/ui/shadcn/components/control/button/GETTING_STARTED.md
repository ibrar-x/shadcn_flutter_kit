# Getting Started

`button` is a registry component in category `control`.

Shadcn-style button system with variants, toggles, and groups.

## Folder Map

- `.DS_Store`: Supporting file used by this widget folder.
- `README.md`: Primary component docs and usage guidance for contributors/users.
- `button.dart`: Widget/composite source file in this folder.
- `button.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `button`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `button_core.dart`: Core implementation part of the widget/composite.
- `button_group.dart`: Core implementation part of the widget/composite.
- `button_group_data.dart`: Core implementation part of the widget/composite.
- `button_group_widget.dart`: Core implementation part of the widget/composite.
- `button_icon.dart`: Core implementation part of the widget/composite.
- `button_widget.dart`: Core implementation part of the widget/composite.
- `controlled_toggle.dart`: Core implementation part of the widget/composite.
- `toggle.dart`: Core implementation part of the widget/composite.
- `toggle_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- `button_style_extension.dart`: Style model/helpers for visual variants and overrides.

### `state/`
State objects, controllers, and mutable interaction logic.

- `button_state.dart`: State class/controller for interaction and derived UI state.
- `selected_button_state.dart`: State class/controller for interaction and derived UI state.
- `toggle_controller.dart`: Controller/state-coordination logic for this widget.
- `toggle_controller_class.dart`: Controller/state-coordination logic for this widget.
- `toggle_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- `abstract_button_style.dart`: Style model/helpers for visual variants and overrides.
- `button_density.dart`: Style model/helpers for visual variants and overrides.
- `button_overrides.dart`: Style model/helpers for visual variants and overrides.
- `button_shape.dart`: Style model/helpers for visual variants and overrides.
- `button_size.dart`: Style model/helpers for visual variants and overrides.
- `button_state_property.dart`: Style model/helpers for visual variants and overrides.
- `button_state_property_delegate.dart`: Style model/helpers for visual variants and overrides.
- `button_style.dart`: Style model/helpers for visual variants and overrides.
- `button_style_class.dart`: Style model/helpers for visual variants and overrides.
- `button_style_override.dart`: Style model/helpers for visual variants and overrides.
- `button_style_override_data.dart`: Style model/helpers for visual variants and overrides.
- `button_style_property_all.dart`: Style model/helpers for visual variants and overrides.
- `component_theme_button_style.dart`: Theme model/helpers for styling resolution.
- `copy_with_button_style.dart`: Style model/helpers for visual variants and overrides.

### `themes/`
Theme data and ThemeExtension integration.

- `button_theme.dart`: Theme model/helpers for styling resolution.
- `button_theme_base.dart`: Theme model/helpers for styling resolution.
- `card_button_theme.dart`: Theme model/helpers for styling resolution.
- `destructive_button_theme.dart`: Theme model/helpers for styling resolution.
- `fixed_button_theme.dart`: Theme model/helpers for styling resolution.
- `ghost_button_theme.dart`: Theme model/helpers for styling resolution.
- `link_button_theme.dart`: Theme model/helpers for styling resolution.
- `menu_button_theme.dart`: Theme model/helpers for styling resolution.
- `menubar_button_theme.dart`: Theme model/helpers for styling resolution.
- `muted_button_theme.dart`: Theme model/helpers for styling resolution.
- `outline_button_theme.dart`: Theme model/helpers for styling resolution.
- `primary_button_theme.dart`: Theme model/helpers for styling resolution.
- `secondary_button_theme.dart`: Theme model/helpers for styling resolution.
- `text_button_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `button_helpers.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- `button_variance.dart`: Variant-specific implementation details.
- `button_variance_class.dart`: Variant-specific implementation details.
- `button_variants.dart`: Variant-specific implementation details.
- `card_button.dart`: Variant-specific implementation details.
- `destructive_button.dart`: Variant-specific implementation details.
- `ghost_button.dart`: Variant-specific implementation details.
- `link_button.dart`: Variant-specific implementation details.
- `outline_button.dart`: Variant-specific implementation details.
- `primary_button.dart`: Variant-specific implementation details.
- `secondary_button.dart`: Variant-specific implementation details.
- `selected_button.dart`: Variant-specific implementation details.
- `selected_button_widget.dart`: Variant-specific implementation details.
- `tab_button.dart`: Variant-specific implementation details.
- `text_button.dart`: Variant-specific implementation details.

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `button.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
