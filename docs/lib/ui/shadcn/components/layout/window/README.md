# Window

Desktop-style windows with drag, resize, and snapping behaviors.

## Usage
```dart
WindowNavigator(
  initialWindows: [
    Window(
      title: Text('Notes'),
      bounds: Rect.fromLTWH(80, 80, 320, 240),
      content: Center(child: Text('Window content')),
    ),
  ],
)
```
