import 'package:docs/shadcn_ui.dart';
import 'package:docs/ui/shadcn/components/form/slider/_impl/core/shad_slider_models.dart'
    show ShadPopoverVisibility;
import 'package:docs/ui/shadcn/components/form/slider/_impl/styles/shad_slider_defaults.dart'
    show ShadSliderDefaults;
import 'package:flutter/material.dart' as m;

class SliderExample5 extends StatefulWidget {
  const SliderExample5({super.key});

  @override
  State<SliderExample5> createState() => _SliderExample5State();
}

class _SliderExample5State extends State<SliderExample5> {
  double value = 0.72;
  double min = 0;
  double max = 1;

  bool enabled = true;
  bool fillStopsAtThumbCenter = false;
  bool popoverAlways = false;

  double trackHeight = 30;
  double trackRadius = 16;
  double joinGapPx = 2;
  double fillEdgeBiasPx = 0;
  double thumbEdgeOffsetPx = 0;
  double thumbVerticalOffsetPx = 0;
  double thumbWidth = 10;
  double thumbHeight = 25;
  double thumbRadius = 4;
  double thumbInsideOffsetPx = 4;

  String preset = 'brightness';

  @override
  Widget build(BuildContext context) {
    final maxSafe = max <= min ? min + 0.1 : max;
    value = value.clamp(min, maxSafe);

    final controls = _ControlsPanel(
      children: [
        const _SectionLabel('Preset'),
        m.DropdownButton<String>(
          value: preset,
          isExpanded: true,
          onChanged: (next) {
            if (next == null) return;
            setState(() => preset = next);
          },
          items: const [
            m.DropdownMenuItem(value: 'brightness', child: Text('brightness')),
            m.DropdownMenuItem(value: 'stepsDots', child: Text('stepsDots')),
            m.DropdownMenuItem(value: 'waveform', child: Text('waveform')),
          ],
        ),
        const SizedBox(height: 12),
        _RangeControl(
          label: 'Value',
          value: value,
          min: min,
          max: maxSafe,
          onChanged: (v) => setState(() => value = v),
        ),
        _RangeControl(
          label: 'Min',
          value: min,
          min: -1,
          max: 0.9,
          onChanged: (v) => setState(() => min = v),
        ),
        _RangeControl(
          label: 'Max',
          value: maxSafe,
          min: min + 0.1,
          max: 2,
          onChanged: (v) => setState(() => max = v),
        ),
        _RangeControl(
          label: 'Track Height',
          value: trackHeight,
          min: 2,
          max: 48,
          onChanged: (v) => setState(() => trackHeight = v),
        ),
        _RangeControl(
          label: 'Track Radius',
          value: trackRadius,
          min: 0,
          max: 40,
          onChanged: (v) => setState(() => trackRadius = v),
        ),
        _RangeControl(
          label: 'Join Gap',
          value: joinGapPx,
          min: 0,
          max: 12,
          onChanged: (v) => setState(() => joinGapPx = v),
        ),
        _RangeControl(
          label: 'Fill Bias',
          value: fillEdgeBiasPx,
          min: -6,
          max: 6,
          onChanged: (v) => setState(() => fillEdgeBiasPx = v),
        ),
        _RangeControl(
          label: 'Thumb Edge Offset',
          value: thumbEdgeOffsetPx,
          min: -24,
          max: 24,
          onChanged: (v) => setState(() => thumbEdgeOffsetPx = v),
        ),
        _RangeControl(
          label: 'Thumb Vertical Offset',
          value: thumbVerticalOffsetPx,
          min: -16,
          max: 16,
          onChanged: (v) => setState(() => thumbVerticalOffsetPx = v),
        ),
        _RangeControl(
          label: 'Thumb Width',
          value: thumbWidth,
          min: 4,
          max: 32,
          onChanged: (v) => setState(() => thumbWidth = v),
        ),
        _RangeControl(
          label: 'Thumb Height',
          value: thumbHeight,
          min: 8,
          max: 48,
          onChanged: (v) => setState(() => thumbHeight = v),
        ),
        _RangeControl(
          label: 'Thumb Radius',
          value: thumbRadius,
          min: 0,
          max: 24,
          onChanged: (v) => setState(() => thumbRadius = v),
        ),
        _RangeControl(
          label: 'Thumb Inside Offset',
          value: thumbInsideOffsetPx,
          min: 0,
          max: 12,
          onChanged: (v) => setState(() => thumbInsideOffsetPx = v),
        ),
        m.SwitchListTile.adaptive(
          dense: true,
          value: enabled,
          contentPadding: EdgeInsets.zero,
          title: const Text('Enabled'),
          onChanged: (v) => setState(() => enabled = v),
        ),
        m.SwitchListTile.adaptive(
          dense: true,
          value: fillStopsAtThumbCenter,
          contentPadding: EdgeInsets.zero,
          title: const Text('Fill Stops At Thumb Center'),
          onChanged: (v) => setState(() => fillStopsAtThumbCenter = v),
        ),
        m.SwitchListTile.adaptive(
          dense: true,
          value: popoverAlways,
          contentPadding: EdgeInsets.zero,
          title: const Text('Always Show Popover'),
          onChanged: (v) => setState(() => popoverAlways = v),
        ),
      ],
    );

    final slider = Slider.single(
      min: min,
      max: maxSafe,
      value: value,
      enabled: enabled,
      preset: preset,
      trackHeight: trackHeight,
      trackRadius: trackRadius,
      joinGapPx: joinGapPx,
      fillEdgeBiasPx: fillEdgeBiasPx,
      fillStopsAtThumbCenter: fillStopsAtThumbCenter,
      thumbEdgeOffsetPx: thumbEdgeOffsetPx,
      thumbVerticalOffsetPx: thumbVerticalOffsetPx,
      thumbSize: Size(thumbWidth, thumbHeight),
      thumbBuilder: ShadSliderDefaults.barThumb(
        radius: thumbRadius,
        insideOffsetPx: thumbInsideOffsetPx,
      ),
      dragPopoverVisibility: popoverAlways
          ? ShadPopoverVisibility.always
          : ShadPopoverVisibility.whileDragging,
      dragPopoverBuilder: ShadSliderDefaults.valuePopoverRounded(
        formatter: (v) => '${(v * 100).round()}%',
      ),
      onChanged: (next) => setState(() => value = next),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              controls,
              const Gap(16),
              slider,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 320, child: controls),
            const Gap(16),
            Expanded(child: slider),
          ],
        );
      },
    );
  }
}

class _ControlsPanel extends StatelessWidget {
  const _ControlsPanel({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text).small().semiBold(),
    );
  }
}

class _RangeControl extends StatelessWidget {
  const _RangeControl({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('$label: ${value.toStringAsFixed(2)}').xSmall(),
          Slider.single(
            value: value.clamp(min, max),
            min: min,
            max: max,
            trackHeight: 8,
            joinGapPx: 0,
            fillStopsAtThumbCenter: true,
            thumbSize: const Size(14, 14),
            thumbBuilder: ShadSliderDefaults.circleThumb,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
