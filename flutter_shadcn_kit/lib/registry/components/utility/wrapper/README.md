# Wrapper

Conditionally wraps a child with a builder while preserving structure.

## Usage
```dart
Wrapper(
  wrap: true,
  builder: (context, child) => Padding(
    padding: const EdgeInsets.all(12),
    child: child,
  ),
  child: const Text('Wrapped'),
)
```
