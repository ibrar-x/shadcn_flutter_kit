# Timeline Animation (`timeline_animation`)

Keyframe-based animation timeline utilities.

---

## Install

```bash
flutter_shadcn add timeline_animation
```

## Import

```dart
import 'package:<your_app>/ui/shadcn/components/utility/timeline_animation/timeline_animation.dart';
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:<your_app>/ui/shadcn/components/utility/timeline_animation/timeline_animation.dart';

void main() => runApp(const TimelineAnimationExampleApp());

class TimelineAnimationExampleApp extends StatelessWidget {
  const TimelineAnimationExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TimelineAnimationExamplePage());
  }
}

class TimelineAnimationExamplePage extends StatefulWidget {
  const TimelineAnimationExamplePage({super.key});

  @override
  State<TimelineAnimationExamplePage> createState() =>
      _TimelineAnimationExamplePageState();
}

class _TimelineAnimationExamplePageState
    extends State<TimelineAnimationExamplePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final TimelineAnimation<double> _timeline;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _timeline = TimelineAnimation<double>(
      keyframes: [
        AbsoluteKeyframe(const Duration(milliseconds: 400), 0.6, 1.0),
        RelativeKeyframe(const Duration(milliseconds: 300), 1.2),
        StillKeyframe(const Duration(milliseconds: 150)),
        AbsoluteKeyframe(const Duration(milliseconds: 550), 1.2, 0.6),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = _timeline.transform(_controller.value);
            return Transform.scale(
              scale: value,
              child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
            );
          },
          child: const FlutterLogo(size: 120),
        ),
      ),
    );
  }
}
```
