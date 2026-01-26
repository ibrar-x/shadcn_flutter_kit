# Skeleton

Wrap widgets with `ShadcnSkeletonizerConfigLayer` and use `.asSkeleton()` helpers for skeleton loading states powered by the `skeletonizer` package.

```dart
ShadcnSkeletonizerConfigLayer(
  theme: Theme.of(context),
  child: Column(children: [Text('Item').asSkeleton()]),
);
````
