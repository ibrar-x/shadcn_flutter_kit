---
title: "Class: ScrollViewInterceptor"
description: "Widget that intercepts scroll events to simulate middle-button drag scrolling."
---

```dart
/// Widget that intercepts scroll events to simulate middle-button drag scrolling.
class ScrollViewInterceptor extends StatefulWidget {
  final Widget child;
  final bool enabled;
  const ScrollViewInterceptor({super.key, required this.child, this.enabled = true});
  State<ScrollViewInterceptor> createState();
}
```
