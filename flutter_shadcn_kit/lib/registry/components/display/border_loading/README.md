# Border Loading (`border_loading`)

Animated border wrapper for loading, tracer, static, and determinate progress states.

---

## When to use

- Use this when:
  - you want a loading/progress indicator around an existing widget.
  - you need either looping animation (`sweepGradient`/`tracer`) or upload-style determinate progress (`progress`).
  - you need one extensible shader spec (`BorderLoadingSpec`) instead of multiple gradient APIs.
- Avoid when:
  - a regular linear or circular progress indicator is sufficient.
  - you need a full-screen blocking loading state.

---

## Install

```bash
flutter_shadcn add border_loading
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/border_loading/border_loading.dart';
```

---

## Minimal example

```dart
BorderLoading(
  mode: BorderLoadingMode.sweepGradient,
  spec: const BorderGradientSpec(
    type: BorderGradientType.sweep,
    colors: [
      Color(0x00000000),
      Color(0xFF3B82F6),
      Color(0xFF22C55E),
      Color(0xFFF59E0B),
      Color(0x00000000),
    ],
    gap: 0.24,
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    child: Text('Saving...'),
  ),
)
```

---

## Common patterns

### Pattern: Tracer mode

```dart
BorderLoading(
  mode: BorderLoadingMode.tracer,
  tracer: const BorderTracerSpec(
    lengthFraction: 0.12,
    dashCount: 2,
  ),
  spec: const BorderGradientSpec(
    type: BorderGradientType.linear,
    colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Text('Uploading...'),
  ),
)
```

### Pattern: Determinate upload progress

```dart
BorderLoading(
  mode: BorderLoadingMode.progress,
  progress: 0.72,
  spec: const BorderGradientSpec(
    type: BorderGradientType.linear,
    colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Text('72%'),
  ),
)
```

### Pattern: Stream-driven upload progress

```dart
final uploadProgressStream = Stream<double>.periodic(
  const Duration(milliseconds: 120),
  (tick) => (tick / 50).clamp(0.0, 1.0),
).take(51);

BorderLoading(
  mode: BorderLoadingMode.progress,
  progress: 0.0,
  progressStream: uploadProgressStream,
  spec: const BorderGradientSpec(
    type: BorderGradientType.linear,
    colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Text('Uploading...'),
  ),
)
```

### Pattern: Custom shader spec

```dart
class MyBorderSpec extends BorderLoadingSpec {
  const MyBorderSpec();

  @override
  Shader createShader({
    required Rect bounds,
    required double progress,
    required Path path,
  }) {
    return const LinearGradient(
      colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)],
    ).createShader(bounds);
  }
}
```

---

## API

### Constructor

- `BorderLoading`
- `child` (`Widget`, required)
- `strokeWidth` (`double`)
- `padding` (`EdgeInsets`)
- `borderRadius` (`BorderRadius`)
- `shapeBorder` (`ShapeBorder?`)
- `mode` (`BorderLoadingMode`)
- `progress` (`double`, 0..1 used by `BorderLoadingMode.progress`)
- `progressStream` (`Stream<double>?`, optional live progress source)
- `tracer` (`BorderTracerSpec`)
- `spec` (`BorderLoadingSpec`)
- `duration` (`Duration`)
- `curve` (`Curve`)
- `backgroundColor` (`Color?`)
- `opacity` (`double`)

### Callbacks

- No callbacks.

### Types and helpers

- `BorderLoadingMode`
- `BorderTracerSpec`
- `BorderLoadingSpec`
- `BorderGradientSpec`
- `BorderGradientType`

---

## Theming

- Configure colors and animation behavior through `BorderGradientSpec`.
- Use `backgroundColor` when you need a filled backing behind the child.

---

## Accessibility

- Pair loading/progress visuals with text labels (for example, `Uploading 72%`).
- Avoid relying only on color to communicate progress state.

---

## Do / Don’t

**Do**
- ✅ Use `mode: BorderLoadingMode.progress` for real upload/download progress.
- ✅ Keep `curve: Curves.linear` for constant-speed loading motion.

**Don’t**
- ❌ Use looping loading modes for determinate progress values.
- ❌ Set very thick strokes on tiny widgets unless intentionally styled.

---

## Related components

- `progress`
- `linear_progress_indicator`
- `circular_progress_indicator`

---

## Registry rules

- One public class per file.
- Keep internals under `_impl/`.
