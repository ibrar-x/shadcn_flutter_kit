# Checkbox

`Checkbox` ships with tri-state support, customizable sizes, colors, and spacing plus an animated checkmark. Use `CheckboxTheme` via `ComponentTheme` to configure defaults (background/active colors, border, radius). `CheckboxController` exposes helper methods (check/uncheck/indeterminate) plus `ComponentController` integration. The widget auto-styles leading/trailing content with `small()`/`medium()` text modifiers and uses shared `Clickable` for the interactive square.

```dart
Checkbox(
  state: checkboxState,
  onChanged: (newState) => setState(() => checkboxState = newState),
  leading: Icon(Icons.person),
  trailing: Text('Accept terms'),
);
```
