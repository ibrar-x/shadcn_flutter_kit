# Overflow Marquee

Horizontal or vertical marquee that scrolls overflowing content with optional fades, delays, and custom timing curves.

```dart
import 'ui/shadcn/components/overflow_marquee/overflow_marquee.dart';

OverflowMarquee(
  child: Text('This text scrolls when it overflows its parent.'),
  duration: Duration(seconds: 8),
  direction: Axis.horizontal,
  fadePortion: 0.1,
  delayDuration: Duration(milliseconds: 600),
);
```

Wrap your app with `ComponentTheme<OverflowMarqueeTheme>` from `registry/shared/theme/theme.dart` to override default durations, fade portions, or animation curves before installing the component.
