# Color Input

A compound form field that launches the color picker, history, and eye-dropper tools inside a popover or dialog.

```dart
ColorInput(
  value: ColorDerivative.fromColor(Colors.blue),
  onChanged: (next) => print('picked ${next.toColor()}'),
  enableEyeDropper: true,
  showLabel: true,
  placeholder: const Text('Pick a color'),
)
```

Wrap the trigger with `RecentColorsScope` before showing `ColorInput` so the history panel and eye-dropper additions stay in sync. Use `ControlledColorInput` when you need to wire the selector into a `Form` and reuse a `ColorInputController`.
