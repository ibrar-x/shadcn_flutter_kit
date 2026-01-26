---
title: "Extension: SkeletonExtension"
description: "Convenient skeleton extension helpers."
---

```dart
/// Convenient skeleton extension helpers.
extension SkeletonExtension on Widget {
  Widget asSkeletonSliver({bool enabled = true});
  Widget asSkeleton({bool enabled = true, bool leaf = false, Widget? replacement, bool unite = false, AsyncSnapshot? snapshot});
  Widget ignoreSkeleton();
  Widget excludeSkeleton({bool exclude = true});
}
```
