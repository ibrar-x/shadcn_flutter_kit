# Repeated Animation Builder (`repeated_animation_builder`)

A looping animation builder that emits an interpolated value between `start` and `end`.

---

## Install

```bash
flutter_shadcn add repeated_animation_builder
```

## Import

```dart
import 'package:<your_app>/ui/shadcn/components/utility/repeated_animation_builder/repeated_animation_builder.dart';
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:<your_app>/ui/shadcn/components/utility/repeated_animation_builder/repeated_animation_builder.dart';

void main() => runApp(const RepeatedAnimationExampleApp());

class RepeatedAnimationExampleApp extends StatelessWidget {
  const RepeatedAnimationExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RepeatedAnimationExamplePage());
  }
}

class RepeatedAnimationExamplePage extends StatelessWidget {
  const RepeatedAnimationExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RepeatedAnimationBuilder(
          start: 0.7,
          end: 1.0,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(scale: value, child: child),
            );
          },
          child: const FlutterLogo(size: 120),
        ),
      ),
    );
  }
}
```
