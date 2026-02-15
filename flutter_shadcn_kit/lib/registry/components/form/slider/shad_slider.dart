import 'package:flutter/material.dart' hide Slider;

import '_impl/core/shad_slider_logic.dart';
import '_impl/core/shad_slider_models.dart';
import '_impl/styles/shad_slider_defaults.dart';

/// New experimental slider engine implementation.
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
    required this.fillStopsAtThumbCenter,
    required this.fillEdgeBiasPx,
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
    ShadSliderSnap snap = const ShadSliderSnap.none(),
    double trackHeight = 28,
    double? trackRadius,
    double thumbInset = 8,
    bool fillStopsAtThumbCenter = true,
    double fillEdgeBiasPx = 1,
    ShadSliderTrackBuilder? trackBuilder,
    ShadSliderFillBuilder? fillBuilder,
    ShadSliderThumbBuilder? thumbBuilder,
    ShadSliderTicksBuilder? ticksBuilder,
    ShadSliderOverlayBuilder? overlayBuilder,
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
      fillStopsAtThumbCenter: fillStopsAtThumbCenter,
      fillEdgeBiasPx: fillEdgeBiasPx,
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
    required ShadSliderRangeValue rangeValue,
    required ValueChanged<ShadSliderRangeValue> onChanged,
    double min = 0,
    double max = 1,
    bool enabled = true,
    ShadSliderSnap snap = const ShadSliderSnap.none(),
    double trackHeight = 28,
    double? trackRadius,
    double thumbInset = 8,
    double minRange = 0,
    bool allowSwap = false,
    bool fillStopsAtThumbCenter = true,
    double fillEdgeBiasPx = 1,
    ShadSliderTrackBuilder? trackBuilder,
    ShadSliderFillBuilder? fillBuilder,
    ShadSliderThumbBuilder? thumbBuilder,
    ShadSliderTicksBuilder? ticksBuilder,
    ShadSliderOverlayBuilder? overlayBuilder,
    String? semanticLabel,
  }) {
    final configured = rangeValue.copyWith(
      minRange: minRange,
      allowSwap: allowSwap,
    );

    return ShadSlider._(
      key: key,
      min: min,
      max: max,
      enabled: enabled,
      snap: snap,
      trackHeight: trackHeight,
      trackRadius: trackRadius,
      thumbInset: thumbInset,
      fillStopsAtThumbCenter: fillStopsAtThumbCenter,
      fillEdgeBiasPx: fillEdgeBiasPx,
      value: null,
      onChanged: null,
      rangeValue: configured,
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
  final ShadSliderSnap snap;

  final double trackHeight;
  final double? trackRadius;
  final double thumbInset;

  final bool fillStopsAtThumbCenter;
  final double fillEdgeBiasPx;

  final double? value;
  final ValueChanged<double>? onChanged;

  final ShadSliderRangeValue? rangeValue;
  final ValueChanged<ShadSliderRangeValue>? onRangeChanged;

  final ShadSliderTrackBuilder? trackBuilder;
  final ShadSliderFillBuilder? fillBuilder;
  final ShadSliderThumbBuilder? thumbBuilder;
  final ShadSliderTicksBuilder? ticksBuilder;
  final ShadSliderOverlayBuilder? overlayBuilder;

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

  @override
  void didUpdateWidget(covariant ShadSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isRange != widget.isRange) {
      _activeThumb = null;
      _dragging = false;
    }
  }

  void _emitSingle(double nextValue) {
    if (!widget.enabled) return;
    widget.onChanged?.call(nextValue);
  }

  void _emitRange(ShadSliderRangeValue nextValue) {
    if (!widget.enabled) return;
    widget.onRangeChanged?.call(nextValue);
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.max > widget.min);

    final defaults = ShadSliderDefaults.of(context);
    final trackBuilder = widget.trackBuilder ?? defaults.trackBuilder;
    final fillBuilder = widget.fillBuilder ?? defaults.fillBuilder;
    final thumbBuilder = widget.thumbBuilder ?? defaults.thumbBuilder;
    final ticksBuilder = widget.ticksBuilder ?? defaults.ticksBuilder;
    final overlayBuilder = widget.overlayBuilder ?? defaults.overlayBuilder;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = widget.trackHeight;
        final radius = widget.trackRadius ?? (height / 2);
        final trackRect = Rect.fromLTWH(0, 0, width, height);

        final view = _logic.buildView(
          min: widget.min,
          max: widget.max,
          snap: widget.snap,
          enabled: widget.enabled,
          trackRect: trackRect,
          trackRadius: radius,
          thumbInset: widget.thumbInset,
          dragging: _dragging,
          activeThumb: _activeThumb,
          fillStopsAtThumbCenter: widget.fillStopsAtThumbCenter,
          fillEdgeBiasPx: widget.fillEdgeBiasPx,
          textDirection: Directionality.of(context),
          value: widget.value,
          rangeValue: widget.rangeValue,
        );

        Widget content = SizedBox(
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              trackBuilder(context, view),
              fillBuilder(context, view),
              ticksBuilder(context, view),
              for (final thumb in view.thumbs)
                Positioned(
                  left: thumb.center.dx - (thumb.size.width / 2),
                  top: thumb.center.dy - (thumb.size.height / 2),
                  child: thumbBuilder(context, thumb),
                ),
              overlayBuilder(context, view),
            ],
          ),
        );

        content = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: widget.enabled
              ? (details) {
                  final hit = _logic.hitTest(
                    view: view,
                    localPosition: details.localPosition,
                  );

                  final next = _logic.updateFromDx(
                    view: view,
                    dx: details.localPosition.dx,
                    thumbIndex: hit.activeThumb,
                    snap: widget.snap,
                  );

                  if (next.singleValue != null) {
                    _emitSingle(next.singleValue!);
                  }
                  if (next.rangeValue != null) {
                    _emitRange(next.rangeValue!);
                  }

                  _activeThumb = next.activeThumb;
                }
              : null,
          onHorizontalDragStart: widget.enabled
              ? (details) {
                  setState(() {
                    _dragging = true;
                    _activeThumb = _logic.pickActiveThumb(
                      view: view,
                      dx: details.localPosition.dx,
                    );
                  });
                }
              : null,
          onHorizontalDragUpdate: widget.enabled
              ? (details) {
                  final next = _logic.updateFromDx(
                    view: view,
                    dx: details.localPosition.dx,
                    thumbIndex: _activeThumb ?? 0,
                    snap: widget.snap,
                  );

                  if (next.singleValue != null) {
                    _emitSingle(next.singleValue!);
                  }
                  if (next.rangeValue != null) {
                    _emitRange(next.rangeValue!);
                  }

                  if (next.activeThumb != _activeThumb) {
                    setState(() => _activeThumb = next.activeThumb);
                  }
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
