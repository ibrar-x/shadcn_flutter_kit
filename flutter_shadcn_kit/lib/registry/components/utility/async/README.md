# Async

`FutureOrBuilder` renders widgets for values that may already be available or are delivered as a `Future`. It wraps `FutureBuilder` internally and exposes the same snapshot-driven builder callback, so you can reuse the same UI for sync or async sources with a single widget.

```dart
FutureOrBuilder<String>(
  future: fetchName(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!);
    }
    return const CircularProgressIndicator();
  },
);
```
