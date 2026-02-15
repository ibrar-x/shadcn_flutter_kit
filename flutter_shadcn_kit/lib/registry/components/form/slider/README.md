# Slider (refined v2 presets)

This slider is a **general-purpose engine** with **design-grade presets**.

## Presets
- `brightness` (default for single)
- `rangeSoft` (default for range)
- `stepsDots`
- `waveform`

## Thumb variants (builders)
For range selector visuals, you can swap:
- `ShadSliderDefaults.circleThumb`
- `ShadSliderDefaults.squareThumb`
- `ShadSliderDefaults.pinThumb`

(These helpers live in `_impl/defaults.dart`, but you can still reference them from `preview.dart` and local builders in your app.)

## Examples

### Brightness
```dart
ShadSlider.single(
  value: brightness,
  onChanged: (v) => setState(() => brightness = v),
  preset: 'brightness',
);
```

### Range
```dart
ShadSlider.range(
  min: 0,
  max: 10,
  rangeValue: range,
  onChanged: (v) => setState(() => range = v),
  preset: 'rangeSoft',
);
```

### Steps + dots
```dart
ShadSlider.single(
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
ShadSlider.single(
  value: v,
  onChanged: (x) => setState(() => v = x),
  preset: 'waveform',
  ticksBuilder: (ctx, s) => myWaveformTicks(ctx, s, amps),
);
```
