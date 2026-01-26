# Switcher

`Switcher` is a gesture-driven viewport that smoothly transitions between multiple children.
It understands all four `AxisDirection`s, snaps to the nearest index after a drag,
and exposes callbacks for programmatic control.

```dart
Switcher(
  index: currentIndex,
  direction: AxisDirection.right,
  duration: const Duration(milliseconds: 250),
  curve: Curves.easeOut,
  onIndexChanged: (value) => setState(() => currentIndex = value),
  children: [
    Container(color: Colors.red, child: const Center(child: Text('First'))),
    Container(color: Colors.blue, child: const Center(child: Text('Second'))),
    Container(color: Colors.green, child: const Center(child: Text('Third'))),
  ],
)
```
