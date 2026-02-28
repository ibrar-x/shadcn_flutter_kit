# Getting Started

`error_system` is a registry component in category `utility`.

Production-ready error handling system with UI components and repository mapping.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `error_system.dart`: Widget/composite source file in this folder.
- `error_system.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `error_system`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `app_error.dart`: Core implementation part of the widget/composite.
- `app_error_banner.dart`: Core implementation part of the widget/composite.
- `app_error_gate.dart`: Core implementation part of the widget/composite.
- `app_error_hub.dart`: Core implementation part of the widget/composite.
- `error_action.dart`: Core implementation part of the widget/composite.
- `error_code.dart`: Core implementation part of the widget/composite.
- `error_dialog.dart`: Core implementation part of the widget/composite.
- `error_exceptions.dart`: Core implementation part of the widget/composite.
- `error_handled_repository.dart`: Core implementation part of the widget/composite.
- `error_mapper.dart`: Core implementation part of the widget/composite.
- `error_registry.dart`: Core implementation part of the widget/composite.
- `error_rule.dart`: Core implementation part of the widget/composite.
- `error_scope.dart`: Core implementation part of the widget/composite.
- `error_scope_type.dart`: Core implementation part of the widget/composite.
- `error_slot.dart`: Core implementation part of the widget/composite.
- `error_snackbar.dart`: Core implementation part of the widget/composite.
- `error_state.dart`: State class/controller for interaction and derived UI state.
- `guard.dart`: Core implementation part of the widget/composite.
- `hub_scopes.dart`: Core implementation part of the widget/composite.
- `inline_error.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- `context_error_extensions.dart`: Extension methods to simplify API usage.
- `future_error_extensions.dart`: Extension methods to simplify API usage.

### `state/`
State objects, controllers, and mutable interaction logic.

- `screen_error_scope.dart`: Widget/composite source file in this folder.

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- `error_system_theme.dart`: Theme model/helpers for styling resolution.

### `utils/`
Small reusable helper functions/models.

- `api_rules.dart`: Utility helpers used by this widget implementation.
- `auth_rules.dart`: Utility helpers used by this widget implementation.
- `env.dart`: Utility helpers used by this widget implementation.
- `error_fingerprint.dart`: Utility helpers used by this widget implementation.
- `error_reporter.dart`: Utility helpers used by this widget implementation.
- `fallback_rule.dart`: Utility helpers used by this widget implementation.
- `network_rules.dart`: Utility helpers used by this widget implementation.
- `network_rules_io.dart`: Utility helpers used by this widget implementation.
- `network_rules_stub.dart`: Utility helpers used by this widget implementation.
- `platform_rules.dart`: Utility helpers used by this widget implementation.
- `retry_strategy.dart`: Utility helpers used by this widget implementation.
- `validation_rules.dart`: Utility helpers used by this widget implementation.

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `error_system.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
