# Control Utilities

Shared controller and mixin helpers that standardize component value control.

- `ComponentController<T>`: mixin for widgets exposing a `ValueNotifier`-based controller interface.
- `ComponentValueController<T>`: simple `ValueNotifier` that implements `ComponentController<T>`.
- `ControlledComponent<T>`: mixin to describe widgets that accept either an external controller or declarative value parameters.

Use these helpers inside form components to share external control semantics (e.g., input widgets, toggles, sliders).
