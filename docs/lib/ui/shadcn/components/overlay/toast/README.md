# Toast

Simple overlay toasts with controller-driven stack placement.

## Usage

```dart
final controller = ToastController();

controller.show(
  context: context,
  builder: (context) => Text('Saved'),
);
```

Set `ToastTheme` to adjust paddings, duration, and colors.
