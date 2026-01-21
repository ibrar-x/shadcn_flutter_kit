# Timeline Animation

Composite export for timeline keyframes and helpers.

## Usage

```dart
import 'ui/shadcn/composites/timeline_animation/timeline_animation.dart';

final timeline = TimelineAnimation<double>(
  keyframes: const [
    AbsoluteKeyframe(Duration(milliseconds: 200), 0, 1),
    StillKeyframe(Duration(milliseconds: 100)),
    RelativeKeyframe(Duration(milliseconds: 200), 0),
  ],
  lerp: Transformers.typeDouble,
);
```
