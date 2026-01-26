# Click Detector

`ClickDetector` tracks consecutive taps and exposes the evolving click count through `ClickDetails`.
Use it to build double-click handlers, gated accelerators, or contextual menus that open on the nth click.

```dart
ClickDetector(
  threshold: const Duration(milliseconds: 400),
  onClick: (details) {
    if (details.clickCount == 2) {
      print('Double click detected');
    }
  },
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text('Click me repeatedly'),
  ),
)
```
