# Streaming Text (`text_animate`)

Stream-aware animated text renderer for incremental updates.

---

## When to use

- Use this when:
  - text arrives chunk-by-chunk (AI/chat/terminal-like output).
  - you want newly appended characters to animate while older text stays stable.
  - you need pluggable character effects (blur, custom adapters).
- Avoid when:
  - text is static and animation is unnecessary.
  - you need full rich text editing behavior.

---

## Install

```bash
flutter_shadcn add text_animate
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/text_animate/text_animate.dart';
```

---

## Minimal example

```dart
StreamingText(
  text: streamedText,
  style: const TextStyle(fontSize: 16),
)
```

---

## Common patterns

### Pattern: Typewriter reveal speed

```dart
StreamingText(
  text: streamedText,
  typewriter: const TypewriterEffect(charsPerSecond: 50),
)
```

### Pattern: Blur-in for newly revealed chars

```dart
StreamingText(
  text: streamedText,
  effect: const BlurInEffect(
    duration: Duration(milliseconds: 260),
    maxBlurSigma: 6,
    fadeIn: true,
    slideUpPx: 2,
  ),
)
```

### Pattern: Blinking cursor while streaming

```dart
StreamingText(
  text: streamedText,
  cursor: const StreamingCursor.blink(showWhenSettled: false),
)
```

### Pattern: Custom effect adapter

```dart
class JitterEffect extends StreamingTextEffectAdapter {
  const JitterEffect({this.duration = const Duration(milliseconds: 200)});

  final Duration duration;

  @override
  Duration get settleDuration => duration;

  @override
  InlineSpan buildSpan({
    required String char,
    required int index,
    required Duration age,
    required TextStyle baseStyle,
  }) {
    final t = (age.inMicroseconds / duration.inMicroseconds).clamp(0.0, 1.0);
    final offset = (1 - t) * 2;

    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: Transform.translate(
        offset: Offset(offset, 0),
        child: Text(char, style: baseStyle),
      ),
    );
  }
}
```

---

## API

### Constructor

- `StreamingText`
  - `text` (`String`, required)
  - `style` (`TextStyle?`)
  - `typewriter` (`TypewriterEffect?`)
  - `effect` (`StreamingTextEffectAdapter?`)
  - `cursor` (`StreamingCursor?`)
  - `textAlign` (`TextAlign?`)
  - `textDirection` (`TextDirection?`)
  - `softWrap` (`bool?`)
  - `overflow` (`TextOverflow?`)
  - `maxLines` (`int?`)
  - `textWidthBasis` (`TextWidthBasis?`)
  - `textHeightBehavior` (`TextHeightBehavior?`)
  - `locale` (`Locale?`)
  - `onSettled` (`StreamingTextSettled?`)

### Callbacks

- `onSettled` (`void Function(String text)?`): invoked once when the latest revision fully settles.

### Types and helpers

- `TypewriterEffect`
- `StreamingTextEffectAdapter`
- `NoEffect`
- `BlurInEffect`
- `CombinedEffect`
- `StreamingCursor`
- `TextAnimateTheme`

---

## Theming

- `TextAnimateTheme` provides defaults for style, typewriter, effect, and cursor.
- Per-widget values override theme values.

---

## Accessibility

- Pair animated output with semantic context when content meaning changes.
- Avoid very fast reveal speeds for long-form content.
- Use sufficient contrast for cursor and text colors.

---

## Do / Don’t

**Do**
- ✅ Pass the latest full text value on each stream tick.
- ✅ Use `CombinedEffect` when layering built-in effect adapters.

**Don’t**
- ❌ Mutate text in-place without sending the latest full string.
- ❌ Rely on animation alone for critical status messaging.

---

## Related components

- `text`
- `selectable`
- `number_ticker`

---

## Registry rules

- One public entry widget per component file.
- Keep private implementation details under `_impl/`.
