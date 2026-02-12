# Getting Started

`text_field` is a registry component in category `form`.

Text input with rich features, autocomplete, and actions.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `input.dart`: Widget/composite source file in this folder.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `text_field.dart`: Widget/composite source file in this folder.
- `text_field.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `text_field`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_always_visible_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_attached_input_feature.dart`: Core implementation part of the widget/composite.
- `_auto_complete_item.dart`: Core implementation part of the widget/composite.
- `_focused_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_has_selection_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_hovered_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_logic_and_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_logic_or_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_negate_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_never_visible_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_text_empty_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `_text_not_empty_input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `auto_complete.dart`: Core implementation part of the widget/composite.
- `auto_complete_mode.dart`: Core implementation part of the widget/composite.
- `auto_complete_widget.dart`: Core implementation part of the widget/composite.
- `input_auto_complete_feature.dart`: Core implementation part of the widget/composite.
- `input_clear_feature.dart`: Core implementation part of the widget/composite.
- `input_copy_feature.dart`: Core implementation part of the widget/composite.
- `input_feature_base.dart`: Core implementation part of the widget/composite.
- `input_feature_visibility.dart`: Core implementation part of the widget/composite.
- `input_features_autocomplete.dart`: Core implementation part of the widget/composite.
- `input_features_basic.dart`: Core implementation part of the widget/composite.
- `input_features_copy_paste.dart`: Core implementation part of the widget/composite.
- `input_features_spinner.dart`: Core implementation part of the widget/composite.
- `input_hint_feature.dart`: Core implementation part of the widget/composite.
- `input_leading_feature.dart`: Core implementation part of the widget/composite.
- `input_password_toggle_feature.dart`: Core implementation part of the widget/composite.
- `input_paste_feature.dart`: Core implementation part of the widget/composite.
- `input_revalidate_feature.dart`: Core implementation part of the widget/composite.
- `input_spinner_feature.dart`: Core implementation part of the widget/composite.
- `input_trailing_feature.dart`: Core implementation part of the widget/composite.
- `password_peek_mode.dart`: Core implementation part of the widget/composite.
- `text_field_gestures.dart`: Core implementation part of the widget/composite.
- `text_field_widget.dart`: Core implementation part of the widget/composite.
- `text_input_mixin.dart`: Core implementation part of the widget/composite.
- `text_input_stateful_widget.dart`: Core implementation part of the widget/composite.
- `text_input_stateful_widget_cont.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_auto_complete_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_auto_complete_item_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_auto_complete_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_clear_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_copy_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_hint_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_leading_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_password_toggle_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_paste_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_revalidate_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_spinner_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `_input_trailing_feature_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `input_feature_state.dart`: State class/controller for interaction and derived UI state.
- `text_field_state_part1.dart`: Widget/composite source file in this folder.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `auto_complete_theme.dart`: Theme model/helpers for styling resolution.
- `text_field_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `accept_suggestion_intent.dart`: Utility helpers used by this widget implementation.
- `auto_complete_intent.dart`: Utility helpers used by this widget implementation.
- `input_show_hint_intent.dart`: Utility helpers used by this widget implementation.
- `navigate_suggestion_intent.dart`: Utility helpers used by this widget implementation.
- `text_field_clear_intent.dart`: Utility helpers used by this widget implementation.
- `text_field_intents.dart`: Utility helpers used by this widget implementation.
- `text_field_replace_current_word_intent.dart`: Utility helpers used by this widget implementation.
- `text_field_select_all_and_copy_intent.dart`: Utility helpers used by this widget implementation.
- `text_field_set_selection_intent.dart`: Utility helpers used by this widget implementation.
- `text_field_set_text_intent.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `text_field.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
