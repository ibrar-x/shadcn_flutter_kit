import 'package:flutter/material.dart';

import '_impl/core/shad_slider_logic.dart';
import '_impl/core/shad_slider_models.dart';
import '_impl/styles/shad_slider_presets.dart';

class ShadSlider extends StatefulWidget {
  const ShadSlider._({
    super.key,
    required this.min,
    required this.max,
    required this.enabled,
    required this.snap,
    required this.trackHeight,
    required this.trackRadius,
    required this.thumbInset,
    required this.thumbSize,
    required this.fillStopsAtThumbCenter,
    required this.fillEdgeBiasPx,
    required this.preset,
    required this.value,
    required this.onChanged,
    required this.rangeValue,
    required this.onRangeChanged,
    required this.trackBuilder,
    required this.fillBuilder,
    required this.thumbBuilder,
    required this.ticksBuilder,
    required this.overlayBuilder,
    required this.semanticLabel,
  });

  factory ShadSlider.single({
    Key? key,
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0,
    double max = 1,
    bool enabled = true,
    ShadSnap snap = const ShadSnap.none(),
    double trackHeight = 28,
    double? trackRadius,
    double thumbInset = 10,
    Size thumbSize = const Size(22, 28),
    bool fillStopsAtThumbCenter = true,
    double fillEdgeBiasPx = 1,
    String preset = 'brightness',
    ShadTrackBuilder? trackBuilder,
    ShadFillBuilder? fillBuilder,
    ShadThumbBuilder? thumbBuilder,
    ShadTicksBuilder? ticksBuilder,
    ShadOverlayBuilder? overlayBuilder,
    String? semanticLabel,
  }) {
    return ShadSlider._(
      key: key,
      min: min,
      max: max,
      enabled: enabled,
      snap: snap,
      trackHeight: trackHeight,
      trackRadius: trackRadius,
      thumbInset: thumbInset,
      thumbSize: thumbSize,
      fillStopsAtThumbCenter: fillStopsAtThumbCenter,
      fillEdgeBiasPx: fillEdgeBiasPx,
      preset: preset,
      value: value,
      onChanged: onChanged,
      rangeValue: null,
      onRangeChanged: null,
      trackBuilder: trackBuilder,
      fillBuilder: fillBuilder,
      thumbBuilder: thumbBuilder,
      ticksBuilder: ticksBuilder,
      overlayBuilder: overlayBuilder,
      semanticLabel: semanticLabel,
    );
  }

  factory ShadSlider.range({
    Key? key,
    required ShadRangeValue rangeValue,
    required ValueChanged<ShadRangeValue> onChanged,
    double min = 0,
    double max = 1,
    bool enabled = true,
    ShadSnap snap = const ShadSnap.none(),
    double trackHeight = 28,
    double? trackRadius,
    double thumbInset = 10,
    Size thumbSize = const Size(22, 28),
    double minRange = 0,
    bool allowSwap = false,
    bool fillStopsAtThumbCenter = true,
    double fillEdgeBiasPx = 1,
    String preset = 'rangeSoft',
    ShadTrackBuilder? trackBuilder,
    ShadFillBuilder? fillBuilder,
    ShadThumbBuilder? thumbBuilder,
    ShadTicksBuilder? ticksBuilder,
    ShadOverlayBuilder? overlayBuilder,
    String? semanticLabel,
  }) {
    final rv = rangeValue.copyWith(minRange: minRange, allowSwap: allowSwap);
    return ShadSlider._(
      key: key,
      min: min,
      max: max,
      enabled: enabled,
      snap: snap,
      trackHeight: trackHeight,
      trackRadius: trackRadius,
      thumbInset: thumbInset,
      thumbSize: thumbSize,
      fillStopsAtThumbCenter: fillStopsAtThumbCenter,
      fillEdgeBiasPx: fillEdgeBiasPx,
      preset: preset,
      value: null,
      onChanged: null,
      rangeValue: rv,
      onRangeChanged: onChanged,
      trackBuilder: trackBuilder,
      fillBuilder: fillBuilder,
      thumbBuilder: thumbBuilder,
      ticksBuilder: ticksBuilder,
      overlayBuilder: overlayBuilder,
      semanticLabel: semanticLabel,
    );
  }

  final double min;
  final double max;
  final bool enabled;
  final ShadSnap snap;

  final double trackHeight;
  final double? trackRadius;
  final double thumbInset;
  final Size thumbSize;

  final bool fillStopsAtThumbCenter;
  final double fillEdgeBiasPx;

  final String preset;

  final double? value;
  final ValueChanged<double>? onChanged;

  final ShadRangeValue? rangeValue;
  final ValueChanged<ShadRangeValue>? onRangeChanged;

  final ShadTrackBuilder? trackBuilder;
  final ShadFillBuilder? fillBuilder;
  final ShadThumbBuilder? thumbBuilder;
  final ShadTicksBuilder? ticksBuilder;
  final ShadOverlayBuilder? overlayBuilder;

  final String? semanticLabel;

  bool get isRange => rangeValue != null;

  @override
  State<ShadSlider> createState() => _ShadSliderState();
}

class _ShadSliderState extends State<ShadSlider> {
  late final ShadSliderLogic _logic;
  int? _activeThumb;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _logic = ShadSliderLogic();
  }

  void _emitSingle(double v) {
    if (!widget.enabled) return;
    widget.onChanged?.call(v);
  }

  void _emitRange(ShadRangeValue rv) {
    if (!widget.enabled) return;
    widget.onRangeChanged?.call(rv);
  }

  ShadSliderPreset _parsePreset(String name, {required bool isRange}) {
    switch (name) {
      case 'stepsDots':
        return ShadSliderPreset.stepsDots;
      case 'waveform':
        return ShadSliderPreset.waveform;
      case 'rangeSoft':
        return ShadSliderPreset.rangeSoft;
      case 'brightness':
      default:
        return isRange
            ? ShadSliderPreset.rangeSoft
            : ShadSliderPreset.brightness;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.max > widget.min);

    final preset = _parsePreset(widget.preset, isRange: widget.isRange);
    final resolved = resolveShadSliderPreset(
      context,
      preset: preset,
      trackHeight: widget.trackHeight,
      thumbInset: widget.thumbInset,
      fillEdgeBiasPx: widget.fillEdgeBiasPx,
      trackBuilder: widget.trackBuilder,
      fillBuilder: widget.fillBuilder,
      thumbBuilder: widget.thumbBuilder,
      ticksBuilder: widget.ticksBuilder,
      overlayBuilder: widget.overlayBuilder,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = resolved.trackHeight;
        final radius = widget.trackRadius ?? h / 2;
        final dir = Directionality.of(context);
        final trackRect = Rect.fromLTWH(0, 0, w, h);

        final view = _logic.buildView(
          min: widget.min,
          max: widget.max,
          snap: widget.snap,
          enabled: widget.enabled,
          trackRect: trackRect,
          trackRadius: radius,
          thumbInset: resolved.thumbInset,
          dragging: _dragging,
          activeThumb: _activeThumb,
          fillStopsAtThumbCenter: widget.fillStopsAtThumbCenter,
          fillEdgeBiasPx: resolved.fillEdgeBiasPx,
          textDirection: dir,
          value: widget.value,
          rangeValue: widget.rangeValue,
          thumbSize: Size(widget.thumbSize.width, h),
        );

        Widget content = SizedBox(
          height: h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              resolved.trackBuilder(context, view),
              resolved.fillBuilder(context, view),
              resolved.ticksBuilder(context, view),
              for (final t in view.thumbs)
                Positioned(
                  left: t.center.dx - t.size.width / 2,
                  top: t.center.dy - t.size.height / 2,
                  child: resolved.thumbBuilder(context, t),
                ),
              resolved.overlayBuilder(context, view),
            ],
          ),
        );

        content = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: widget.enabled
              ? (d) {
                  final hit = _logic.hitTest(
                    view: view,
                    localPosition: d.localPosition,
                  );
                  _activeThumb = hit.activeThumb;
                  final next = _logic.updateFromDx(
                    view: view,
                    snap: widget.snap,
                    dx: d.localPosition.dx,
                    thumbIndex: _activeThumb ?? 0,
                  );
                  if (next.singleValue != null) _emitSingle(next.singleValue!);
                  if (next.rangeValue != null) _emitRange(next.rangeValue!);
                }
              : null,
          onHorizontalDragStart: widget.enabled
              ? (d) => setState(() {
                  _dragging = true;
                  _activeThumb = _logic.pickActiveThumb(
                    view: view,
                    dx: d.localPosition.dx,
                  );
                })
              : null,
          onHorizontalDragUpdate: widget.enabled
              ? (d) {
                  final next = _logic.updateFromDx(
                    view: view,
                    snap: widget.snap,
                    dx: d.localPosition.dx,
                    thumbIndex: _activeThumb ?? 0,
                  );
                  if (next.singleValue != null) _emitSingle(next.singleValue!);
                  if (next.rangeValue != null) _emitRange(next.rangeValue!);
                }
              : null,
          onHorizontalDragEnd: widget.enabled
              ? (_) => setState(() {
                  _dragging = false;
                  _activeThumb = null;
                })
              : null,
          onHorizontalDragCancel: widget.enabled
              ? () => setState(() {
                  _dragging = false;
                  _activeThumb = null;
                })
              : null,
          child: content,
        );

        return Semantics(
          label: widget.semanticLabel,
          enabled: widget.enabled,
          slider: true,
          child: content,
        );
      },
    );
  }
}
