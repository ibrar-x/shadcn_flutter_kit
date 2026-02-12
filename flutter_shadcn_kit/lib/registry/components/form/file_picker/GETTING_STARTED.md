# Getting Started

`file_picker` is a registry component in category `form`.

UI-only file upload surfaces with pluggable file picking.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `file_picker.dart`: Widget/composite source file in this folder.
- `file_picker.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `file_picker`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `file_item.dart`: Core implementation part of the widget/composite.
- `file_upload_items_view.dart`: Core implementation part of the widget/composite.
- `file_upload_options.dart`: Core implementation part of the widget/composite.
- `file_upload_widget.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- `_file_picker_preview_state.dart`: Private state class for widget lifecycle and interaction behavior.
- `file_upload_state.dart`: State class/controller for interaction and derived UI state.
- `file_upload_state_compact.dart`: Widget/composite source file in this folder.
- `file_upload_state_surfaces.dart`: Widget/composite source file in this folder.
- `file_upload_state_uploads.dart`: Widget/composite source file in this folder.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `file_upload_dropzone_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `file_like.dart`: Utility helpers used by this widget implementation.
- `file_picker_adapter.dart`: Utility helpers used by this widget implementation.
- `file_picker_adapter_io.dart`: Utility helpers used by this widget implementation.
- `file_picker_adapter_stub.dart`: Utility helpers used by this widget implementation.
- `file_picker_adapter_web.dart`: Utility helpers used by this widget implementation.
- `file_upload_controller.dart`: Utility helpers used by this widget implementation.
- `file_upload_formatters.dart`: Utility helpers used by this widget implementation.
- `file_upload_models.dart`: Utility helpers used by this widget implementation.
- `file_validation.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- `file_upload_variant.dart`: Variant-specific implementation details.

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `file_picker.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
