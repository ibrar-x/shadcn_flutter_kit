# Getting Started

`slider` is a registry component in category `form`.

Single-value and range sliders with keyboard navigation.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `slider.dart`: Widget/composite source file in this folder.
- `slider.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `_impl/`: Private implementation details that support `slider`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `shad_slider_logic.dart`: Geometry, mapping, snapping, and interaction logic.
- `shad_slider_models.dart`: Shared view/state models and builder typedefs.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_slider_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.

### `styles/`
Style classes and style-resolution helpers.

- `shad_slider_defaults.dart`: Token-driven default builders and thumb helpers.
- `shad_slider_presets.dart`: Preset resolver for `brightness/rangeSoft/stepsDots/waveform`.

### `themes/`
Theme data and ThemeExtension integration.

- `slider_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- `base_slider_variant.dart`: Shared base classes for single/range preset wrappers.
- `brightness_slider.dart`: Preset wrapper for `brightness`.
- `range_soft_slider.dart`: Preset wrapper for `rangeSoft`.
- `steps_dots_slider.dart`: Preset wrapper for `stepsDots`.
- `waveform_slider.dart`: Preset wrapper for `waveform`.
- `wave_slider.dart`: Waveform-only slider variant with custom painter + scrub gestures.

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `slider.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/state/`
