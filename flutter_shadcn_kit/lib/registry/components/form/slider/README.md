# Slider

Registry slider component with single and range modes, token-driven theming,
and preset visuals.

## Presets
- `brightness` (default for single)
- `rangeSoft` (default for range)
- `stepsDots`
- `waveform`

## Variants
- `BrightnessSlider` (preset wrapper for `brightness`)
- `RangeSoftSlider` (preset wrapper for `rangeSoft`)
- `StepsDotsSlider` (preset wrapper for `stepsDots`)
- `WaveformSlider` (preset wrapper for `waveform`)
- `WaveSlider` (waveform-only scrubber, no linear track)

## Thumb builders
- `ShadSliderDefaults.circleThumb`
- `ShadSliderDefaults.squareThumb`
- `ShadSliderDefaults.pinThumb`
- `ShadSliderDefaults.barThumb(radius: ...)`

## Key parameters

### `thumbEdgeOffsetPx`
Type: `double`

Controls horizontal inside/outside thumb placement.

- `0`: thumb stays inside track bounds
- positive: thumb moves toward/outside track ends
- negative: thumb moves further inside

### `thumbVerticalOffsetPx`
Type: `double`

Controls vertical thumb position from track center.

- `0`: centered
- positive: down
- negative: up

### `joinGapPx`
Type: `double`

Gap around thumb center between active and remaining segments.
Gap collapses automatically at min/max ends.

## Examples

### Single (brightness)
```dart
Slider.single(
  value: brightness,
  onChanged: (v) => setState(() => brightness = v),
  preset: 'brightness',
);
```

### Range
```dart
Slider.range(
  min: 0,
  max: 10,
  rangeValue: range,
  onChanged: (v) => setState(() => range = v),
  preset: 'rangeSoft',
);
```

### Steps + dots
```dart
Slider.single(
  min: 0,
  max: 10,
  snap: const ShadSnap.steps(10),
  value: v,
  onChanged: (x) => setState(() => v = x),
  preset: 'stepsDots',
);
```

### Waveform
Provide a custom ticksBuilder that draws your waveform bars:
```dart
Slider.single(
  value: v,
  onChanged: (x) => setState(() => v = x),
  preset: 'waveform',
  ticksBuilder: (ctx, s) => myWaveformTicks(ctx, s, amps),
);
```

### Wave slider variant
```dart
WaveSlider(
  value: progress,
  onChanged: (v) => setState(() => progress = v),
  samples: amplitudes, // normalized [0..1]
  showThumb: true,
)
```

### Force inside thumb + slight down offset
```dart
Slider.single(
  value: value,
  onChanged: onChanged,
  thumbEdgeOffsetPx: 0,
  thumbVerticalOffsetPx: 2,
);
```

### Push thumb outward + move up
```dart
Slider.single(
  value: value,
  onChanged: onChanged,
  thumbEdgeOffsetPx: 6,
  thumbVerticalOffsetPx: -2,
);
```

### Segment Layout + Track Renderer (new)
```dart
Slider.single(
  value: value,
  onChanged: onChanged,
  segmentLayout: const ShadJoinGapLayout(
    gapPx: 6,
    endsPolicy: ShadGapEndsPolicy.noneAtMinMax,
    segmentRadius: ShadSegmentRadiusPolicy.fullPills,
  ),
  trackRenderer: const ShadSegmentedCapsuleRenderer(),
);
```

Use `ShadContinuousLayout` for no-gap geometry, and
`ShadWaveformRenderer` / `ShadStepDotsRenderer` for specialized rendering.

### Drag popover (custom, e.g. price)
```dart
WaveformSlider(
  value: v,
  onChanged: onChanged,
  dragPopoverBuilder: (context, state, thumb) {
    final price = (thumb.value * 120).toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('\$$price', style: const TextStyle(color: Colors.white)),
    );
  },
  dragPopoverOffset: const Offset(0, -12),
);
```

### Drag popover (built-in helper)
```dart
Slider.single(
  value: value,
  onChanged: onChanged,
  dragPopoverBuilder: ShadSliderDefaults.valuePopover(
    formatter: (v) => '${(v * 100).round()}%',
  ),
  dragPopoverVisibility: ShadPopoverVisibility.always,
);
```

### Wave slider (domain values like price)
```dart
WaveSlider.domain(
  min: 90,
  max: 120,
  value: 97,
  onChanged: (price) => setState(() => currentPrice = price),
  samples: amplitudes,
  valueFormatter: (v) => '\$${v.toStringAsFixed(0)}',
  popoverVisibility: ShadPopoverVisibility.always,
  popoverBuilder: ShadSliderDefaults.waveValuePopoverPill(
    formatter: (v) => '\$${v.toStringAsFixed(0)}',
  ),
);
```

### Popover shapes
```dart
ShadSliderDefaults.valuePopoverPill()
ShadSliderDefaults.valuePopoverRounded()
ShadSliderDefaults.valuePopoverSquare()
```

### Preset wrappers
```dart
BrightnessSlider(value: v, onChanged: onChanged)
RangeSoftSlider(rangeValue: rv, onChanged: onRangeChanged)
StepsDotsSlider(value: v, steps: 10, onChanged: onChanged)
WaveformSlider(value: v, onChanged: onChanged)
```

### Wave theme fields
`SliderTheme` also supports wave-specific theming:
`waveHeight`, `wavePadding`, `waveBarWidth`, `waveBarGap`, `waveMinBarHeight`,
`waveMaxBarHeight`, `waveCornerRadius`, `waveActiveColor`, `waveInactiveColor`,
`waveDisabledOpacity`, `waveShowThumb`, `waveThumbRadius`, `waveThumbColor`,
`waveThumbBorderColor`, `waveThumbBorderWidth`, `waveHitSlop`, `waveEnabled`,
`wavePopoverBuilder`, `wavePopoverOffset`, `wavePopoverVisibility`.

Shared popover theme fields for all slider types:
`dragPopoverBuilder`, `dragPopoverOffset`, `dragPopoverVisibility`,
`popoverShape`, `popoverBackgroundColor`, `popoverForegroundColor`.

## Theme Color Examples

### Define once, apply to all slider variants
```dart
ComponentTheme(
  data: SliderTheme(
    // shared slider palette (no custom fillBuilder needed)
    guideColor: const Color(0xFFE2E8F0),
    fillActiveColor: const Color(0xFF0F172A),
    fillInactiveColor: const Color(0xFFEDF2F7),
    thumbFillColor: const Color(0xFFFFFFFF),
    thumbBorderColor: const Color(0xFFCBD5E1),
    dotsActiveColor: const Color(0xFF334155),
    dotsInactiveColor: const Color(0xFFCBD5E1),
    waveformTicksActiveColor: const Color(0x99FFFFFF),
    waveformTicksInactiveColor: const Color(0x660F172A),
  ),
  child: Column(
    children: [
      BrightnessSlider(value: a, onChanged: onA),
      RangeSoftSlider(rangeValue: r, onChanged: onR),
      StepsDotsSlider(value: b, onChanged: onB),
      WaveformSlider(value: c, onChanged: onC),
    ],
  ),
);
```

### 1) Default color theme for all `Slider` instances
```dart
ComponentTheme(
  data: SliderTheme(
    trackBuilder: (context, s) => Container(
      width: s.trackRect.width,
      height: s.trackRect.height,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF3),
        borderRadius: BorderRadius.circular(s.trackRadius),
      ),
    ),
    fillBuilder: (context, s) {
      final active = const Color(0xFF1E293B);
      final rem = const Color(0xFFCBD5E1);
      if (!s.isRange) {
        return Stack(
          children: [
            if ((s.activeRect?.width ?? 0) > 0)
              Positioned.fromRect(
                rect: s.activeRect!,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(s.trackRadius),
                  ),
                ),
              ),
            if ((s.remainingRect?.width ?? 0) > 0)
              Positioned.fromRect(
                rect: s.remainingRect!,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: rem,
                    borderRadius: BorderRadius.circular(s.trackRadius),
                  ),
                ),
              ),
          ],
        );
      }
      return const SizedBox.shrink();
    },
  ),
  child: Slider.single(value: v, onChanged: onChanged),
);
```

### 2) Brightness-specific colors
```dart
ComponentTheme(
  data: SliderTheme(
    preset: 'brightness',
    fillBuilder: (context, s) {
      final fill = const Color(0xFF111827);
      final rem = const Color(0xFFE5E7EB);
      return Stack(
        children: [
          if ((s.activeRect?.width ?? 0) > 0)
            Positioned.fromRect(
              rect: s.activeRect!,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(s.trackRadius),
                ),
              ),
            ),
          if ((s.remainingRect?.width ?? 0) > 0)
            Positioned.fromRect(
              rect: s.remainingRect!,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: rem,
                  borderRadius: BorderRadius.circular(s.trackRadius),
                ),
              ),
            ),
        ],
      );
    },
  ),
  child: BrightnessSlider(value: v, onChanged: onChanged),
);
```

### 3) RangeSoft-specific colors
```dart
ComponentTheme(
  data: SliderTheme(
    preset: 'rangeSoft',
    fillBuilder: (context, s) {
      final selected = const Color(0xFF0F172A);
      final rem = const Color(0xFFE2E8F0);
      return Stack(
        children: [
          if ((s.leftRemainingRect?.width ?? 0) > 0)
            Positioned.fromRect(rect: s.leftRemainingRect!, child: ColoredBox(color: rem)),
          if ((s.rightRemainingRect?.width ?? 0) > 0)
            Positioned.fromRect(rect: s.rightRemainingRect!, child: ColoredBox(color: rem)),
          if ((s.rangeRect?.width ?? 0) > 0)
            Positioned.fromRect(rect: s.rangeRect!, child: ColoredBox(color: selected)),
        ],
      );
    },
  ),
  child: RangeSoftSlider(rangeValue: rv, onChanged: onRangeChanged),
);
```

### 4) StepsDots-specific colors
```dart
ComponentTheme(
  data: SliderTheme(
    preset: 'stepsDots',
    ticksBuilder: (context, s) {
      final active = const Color(0xFF1D4ED8);
      final inactive = const Color(0xFFBFDBFE);
      final t = s.t ?? 0;
      return Stack(
        children: [
          for (final m in s.marks)
            Positioned(
              left: m.x - 3,
              top: s.trackRect.center.dy - 3,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: m.t <= t ? active : inactive,
                ),
              ),
            ),
        ],
      );
    },
  ),
  child: StepsDotsSlider(value: v, steps: 10, onChanged: onChanged),
);
```

### 5) WaveformSlider-specific inner-bar colors
```dart
WaveformSlider(
  value: v,
  onChanged: onChanged,
  ticksBuilder: (context, s) {
    final w = s.trackRect.width;
    final h = s.trackRect.height;
    final activeX = w * (s.t ?? 0);
    const bars = 64;
    final barW = w / bars;
    final activeInner = const Color(0x99FFFFFF); // inner color on dark segment
    final inactiveInner = const Color(0x660F172A); // inner color on light segment
    return Stack(
      children: [
        for (int i = 0; i < bars; i++)
          Positioned(
            left: i * barW,
            top: h * 0.2,
            child: Container(
              width: (barW * 0.55).clamp(1.0, 8.0),
              height: h * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: (i * barW) <= activeX ? activeInner : inactiveInner,
              ),
            ),
          ),
      ],
    );
  },
);
```

### 6) WaveSlider-specific colors (built-in fields)
```dart
ComponentTheme(
  data: SliderTheme(
    waveActiveColor: const Color(0xFF0F172A),
    waveInactiveColor: const Color(0xFFE2E8F0),
    waveThumbColor: const Color(0xFFFFFFFF),
    waveThumbBorderColor: const Color(0xFF0F172A),
  ),
  child: WaveSlider(
    value: progress,
    onChanged: onChanged,
    samples: amplitudes,
  ),
);
```
