# Slider (`slider`)

General-purpose slider engine with controlled value input, snapping, and pluggable render builders.

## Install

```bash
flutter_shadcn add slider
```

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/slider/slider.dart';
```

## Quick Start

### Brightness slider (thin bar thumb)

```dart
Slider(
  value: SliderValue.single(62),
  min: 0,
  max: 100,
  onChanged: (value) => setState(() => sliderValue = value),
  trackHeight: 88,
  trackRadius: BorderRadius.circular(999),
  fillEndBias: 1,
  thumbBuilder: (context, state) {
    return Container(
      width: 10,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  },
)
```

### Range slider

```dart
Slider(
  value: SliderValue.ranged(2, 8),
  min: 1,
  max: 10,
  snap: const SliderSnap.steps(9),
  onChanged: (value) => setState(() => range = value),
)
```

### Stepped slider

```dart
Slider(
  value: SliderValue.single(4),
  min: 0,
  max: 10,
  snap: const SliderSnap.steps(10),
  onChanged: (value) => setState(() => sliderValue = value),
)
```

## Recipes

### Custom thumb
Use `thumbBuilder` with `SliderThumbStateView`.

### Tick marks
Use `ticksBuilder` and the geometry from `SliderStateView.trackRect`.

### Waveform renderer
Use `overlayBuilder` or `ticksBuilder` to paint bars from waveform samples and style selected bars from `tStart/tEnd`.

## API highlights

- Required: `value`, `onChanged`
- Core: `min`, `max`, `enabled`
- Snap: `snap` (`none`, `steps`, `values`)
- Legacy compatibility: `divisions` still supported
- Styling: `trackHeight`, `trackRadius`, `thumbSize`, `thumbInset`, `fillEndBias`, colors
- Builders: `trackBuilder`, `fillBuilder`, `thumbBuilder`, `ticksBuilder`, `overlayBuilder`
- Range behavior: `allowThumbSwap`

## Included variants

- `RangeSelectorSliderVariant` (`line`, `ring`, `square` thumb styles)
- `HybridTickSliderVariant`
- `StripedSliderVariant`
- `WaveRangeSliderVariant`
- `MediaControlSliderVariant`
- `LabeledSliderVariant`
- `RangedScaleSliderVariant`

## Registry rules

- One public class in `slider.dart`
- Internal helpers under `_impl/`
