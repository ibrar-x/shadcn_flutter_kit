# Scroll View Interceptor

Intercepts pointer input to emulate middle-click drag scrolling for desktop/web.

## Usage

```dart
ScrollViewInterceptor(
  child: ListView.builder(
    itemCount: 100,
    itemBuilder: (context, index) => Text('Row $index'),
  ),
)
```

## Notes
- Enable only where middle-click drag scrolling is desired.
