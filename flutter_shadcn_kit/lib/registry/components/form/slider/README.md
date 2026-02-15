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
`waveThumbBorderColor`, `waveThumbBorderWidth`, `waveHitSlop`, `waveEnabled`.
