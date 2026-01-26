# Switch

Toggle control for boolean values with optional leading/trailing widgets.

## Usage

```dart
Switch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

```dart
ControlledSwitch(
  initialValue: true,
  onChanged: (value) => print(value),
  leading: Icon(Icons.wifi),
)
```

## Notes
- Uses `SwitchTheme` for colors, spacing, and radius overrides.
- `ControlledSwitch` integrates with `ControlledComponent` helpers.
