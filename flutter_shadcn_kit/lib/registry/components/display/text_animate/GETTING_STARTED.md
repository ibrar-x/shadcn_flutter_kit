# Getting Started

`text_animate` is a registry component in category `display`.

Stream-aware animated text renderer for incremental updates.

## Folder Map

- `GETTING_STARTED.md`: Folder orientation guide (this file).
- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `text_animate.dart`: Widget/composite source file in this folder.
- `text_animate.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `text_animate`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `blur_in_effect.dart`: Core implementation part of the widget/composite.
- `combined_effect.dart`: Core implementation part of the widget/composite.
- `fade_in_effect.dart`: Core implementation part of the widget/composite.
- `scramble_in_effect.dart`: Core implementation part of the widget/composite.
- `slide_in_effect.dart`: Core implementation part of the widget/composite.
- `streaming_cursor.dart`: Core implementation part of the widget/composite.
- `streaming_text_effect_adapter.dart`: Core implementation part of the widget/composite.
- `typewriter_effect.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_text_animate_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `streaming_text_state.dart`: State class/controller for interaction and derived UI state.

### `styles/`
Style classes and style-resolution helpers.

- `character_span_factory.dart`: Style model/helpers for visual variants and overrides.

### `themes/`
Theme data and ThemeExtension integration.

- `text_animate_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `text_diff.dart`: Utility helpers used by this widget implementation.
- `time_math.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `text_animate.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
