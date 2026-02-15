part of '../../slider.dart';

class _SliderState extends State<Slider>
    with FormValueSupplier<SliderValue, Slider> {
  late SliderValue _currentValue;
  bool _dragging = false;
  bool _hovering = false;

  bool _focusingStart = false;
  bool _focusingEnd = false;

  _ActiveThumb _activeThumb = _ActiveThumb.single;

  bool get enabled => widget.enabled ?? widget.onChanged != null;

  SliderTheme? _componentTheme(BuildContext context) =>
      ComponentTheme.maybeOf<SliderTheme>(context);

  double _resolveMinWidth(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return (widget.minWidth ?? compTheme?.minWidth ?? 20) * theme.scaling;
  }

  double _resolveMinHeight(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    final configured = widget.minHeight ?? compTheme?.minHeight;
    if (configured != null) {
      return configured * theme.scaling;
    }
    final baseHeight = max(
      16 * theme.scaling,
      max(
            _resolveTrackHeight(context, theme),
            _resolveThumbSize(context, theme),
          ) +
          _resolveThumbFocusedBorderWidth(context, theme),
    );
    return baseHeight;
  }

  double _resolveMaxHeight(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    final configured = widget.maxHeight ?? compTheme?.maxHeight;
    if (configured == null) return _resolveMinHeight(context, theme);
    return configured * theme.scaling;
  }

  double _resolveHorizontalPadding(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return (widget.horizontalPadding ??
            compTheme?.horizontalPadding ??
            theme.density.baseGap * 0.5) *
        theme.scaling;
  }

  double _resolveTrackHeight(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return (widget.trackHeight ?? compTheme?.trackHeight ?? 6) * theme.scaling;
  }

  BorderRadiusGeometry _resolveTrackRadius(
    BuildContext context,
    ThemeData theme,
  ) {
    final compTheme = _componentTheme(context);
    return widget.trackRadius ??
        compTheme?.trackRadius ??
        BorderRadius.circular(theme.radiusSm);
  }

  Color _resolveTrackColor(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return widget.trackColor ??
        compTheme?.trackColor ??
        theme.colorScheme.primary.scaleAlpha(0.2);
  }

  Color _resolveValueColor(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return widget.valueColor ??
        compTheme?.valueColor ??
        theme.colorScheme.primary;
  }

  Color _resolveDisabledTrackColor(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return widget.disabledTrackColor ??
        compTheme?.disabledTrackColor ??
        theme.colorScheme.muted;
  }

  Color _resolveDisabledValueColor(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return widget.disabledValueColor ??
        compTheme?.disabledValueColor ??
        theme.colorScheme.mutedForeground;
  }

  double _resolveHintHeight(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return (widget.hintHeight ?? compTheme?.hintHeight ?? 6) * theme.scaling;
  }

  BorderRadiusGeometry _resolveHintRadius(
    BuildContext context,
    ThemeData theme,
  ) {
    final compTheme = _componentTheme(context);
    return widget.hintRadius ??
        compTheme?.hintRadius ??
        BorderRadius.circular(theme.radiusSm);
  }

  Color _resolveHintColor(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return widget.hintColor ??
        compTheme?.hintColor ??
        theme.colorScheme.primary.scaleAlpha(0.2);
  }

  double _resolveThumbSize(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return (widget.thumbSize ?? compTheme?.thumbSize ?? 16) * theme.scaling;
  }

  double _resolveThumbInset(BuildContext context, ThemeData theme) {
    return (widget.thumbInset ?? 0) * theme.scaling;
  }

  double _resolveFillEndBias(BuildContext context, ThemeData theme) {
    return (widget.fillEndBias ?? SliderStyleDefaults.brightnessFillEndBias) *
        theme.scaling;
  }

  Color _resolveThumbColor(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    if (!enabled) {
      return widget.disabledThumbColor ??
          compTheme?.disabledThumbColor ??
          theme.colorScheme.background;
    }
    return widget.thumbColor ??
        compTheme?.thumbColor ??
        theme.colorScheme.background;
  }

  Color _resolveThumbBorderColor(
    BuildContext context,
    ThemeData theme,
    bool focusing,
  ) {
    final compTheme = _componentTheme(context);
    if (!enabled) {
      return widget.disabledThumbBorderColor ??
          compTheme?.disabledThumbBorderColor ??
          _resolveDisabledValueColor(context, theme);
    }
    if (focusing) {
      return widget.thumbFocusedBorderColor ??
          compTheme?.thumbFocusedBorderColor ??
          theme.colorScheme.primary;
    }
    return widget.thumbBorderColor ??
        compTheme?.thumbBorderColor ??
        theme.colorScheme.primary.scaleAlpha(0.5);
  }

  double _resolveThumbBorderWidth(BuildContext context, ThemeData theme) {
    final compTheme = _componentTheme(context);
    return (widget.thumbBorderWidth ?? compTheme?.thumbBorderWidth ?? 1) *
        theme.scaling;
  }

  double _resolveThumbFocusedBorderWidth(
    BuildContext context,
    ThemeData theme,
  ) {
    final compTheme = _componentTheme(context);
    return (widget.thumbFocusedBorderWidth ??
            compTheme?.thumbFocusedBorderWidth ??
            2) *
        theme.scaling;
  }

  double _clampUnit(double value) => value.clamp(0.0, 1.0);

  double _toUnit(double actual) {
    final range = widget.max - widget.min;
    if (range == 0) return 0;
    return _clampUnit((actual - widget.min) / range);
  }

  double _toActual(double unit) {
    return widget.min + _clampUnit(unit) * (widget.max - widget.min);
  }

  double _snapUnit(double value) {
    var clamped = _clampUnit(value);

    if (widget.snap._mode == _SliderSnapMode.steps &&
        (widget.snap.stepCount ?? 0) > 0) {
      final steps = widget.snap.stepCount!;
      clamped = (clamped * steps).round() / steps;
      return _clampUnit(clamped);
    }

    if (widget.snap._mode == _SliderSnapMode.customValues &&
        (widget.snap.snapValues?.isNotEmpty ?? false)) {
      final values = widget.snap.snapValues!
          .map(_toUnit)
          .map(_clampUnit)
          .toList(growable: false);
      values.sort();
      var best = values.first;
      var bestDiff = (best - clamped).abs();
      for (final candidate in values.skip(1)) {
        final diff = (candidate - clamped).abs();
        if (diff < bestDiff) {
          best = candidate;
          bestDiff = diff;
        }
      }
      return _clampUnit(best);
    }

    if (widget.divisions != null && widget.divisions! > 0) {
      clamped = (clamped * widget.divisions!).round() / widget.divisions!;
      return _clampUnit(clamped);
    }

    return clamped;
  }

  SliderValue _normalizedFromValue(SliderValue value) {
    if (value.isRanged) {
      final start = _toUnit(value.start);
      final end = _toUnit(value.end);
      return SliderValue.ranged(min(start, end), max(start, end));
    }
    return SliderValue.single(_toUnit(value.value));
  }

  SliderValue _actualFromNormalized(SliderValue value) {
    if (value.isRanged) {
      return SliderValue.ranged(_toActual(value.start), _toActual(value.end));
    }
    return SliderValue.single(_toActual(value.value));
  }

  @override
  void initState() {
    super.initState();
    _currentValue = _normalizedFromValue(widget.value);
    formValue = _currentValue;
  }

  void _dispatchValueChangeStart(SliderValue normalized) {
    if (!enabled) return;
    widget.onChangeStart?.call(_actualFromNormalized(normalized));
  }

  void _dispatchValueChange(SliderValue normalized) {
    if (!enabled) return;
    final actual = _actualFromNormalized(normalized);
    if (actual != widget.value) {
      widget.onChanged?.call(actual);
    }
  }

  void _dispatchValueChangeEnd(SliderValue normalized) {
    if (!enabled) return;
    final actual = _actualFromNormalized(normalized);
    if (actual != widget.value) {
      widget.onChangeEnd?.call(actual);
    }
  }

  @override
  void didUpdateWidget(covariant Slider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && !_dragging) {
      _currentValue = _normalizedFromValue(widget.value);
      formValue = _currentValue;
    }
  }

  @override
  void didReplaceFormValue(SliderValue value) {
    widget.onChanged?.call(value);
    widget.onChangeEnd?.call(value);
  }

  Rect _trackRectFor(
    BoxConstraints constraints,
    BuildContext context,
    ThemeData theme,
  ) {
    final inset = _resolveThumbInset(context, theme);
    final width = max(1.0, constraints.maxWidth - inset * 2);
    final trackHeight = _resolveTrackHeight(context, theme);
    final top = ((constraints.maxHeight - trackHeight) / 2).clamp(
      0.0,
      double.infinity,
    );
    return Rect.fromLTWH(inset, top, width, trackHeight);
  }

  double _unitToDx(double unit, Rect trackRect, TextDirection direction) {
    final resolved = direction == TextDirection.rtl ? 1 - unit : unit;
    return trackRect.left + resolved * trackRect.width;
  }

  double _dxToUnit(double dx, Rect trackRect, TextDirection direction) {
    final raw = ((dx - trackRect.left) / trackRect.width).clamp(0.0, 1.0);
    return direction == TextDirection.rtl ? 1 - raw : raw;
  }

  _ActiveThumb _selectActiveThumb(double unit) {
    if (!_currentValue.isRanged) return _ActiveThumb.single;
    final startDist = (_currentValue.start - unit).abs();
    final endDist = (_currentValue.end - unit).abs();
    if (startDist < endDist) return _ActiveThumb.start;
    if (endDist < startDist) return _ActiveThumb.end;

    final canMoveStart = unit <= _currentValue.end;
    final canMoveEnd = unit >= _currentValue.start;
    if (canMoveStart && !canMoveEnd) return _ActiveThumb.start;
    if (canMoveEnd && !canMoveStart) return _ActiveThumb.end;
    return _ActiveThumb.start;
  }

  SliderValue _rangeAfterMove({
    required _ActiveThumb thumb,
    required double nextUnit,
  }) {
    var start = _currentValue.start;
    var end = _currentValue.end;

    if (thumb == _ActiveThumb.start) {
      start = _snapUnit(nextUnit);
    } else {
      end = _snapUnit(nextUnit);
    }

    if (!widget.allowThumbSwap) {
      if (thumb == _ActiveThumb.start) {
        start = min(start, end);
      } else {
        end = max(end, start);
      }
      return SliderValue.ranged(start, end);
    }

    if (start > end) {
      final swappedStart = end;
      end = start;
      start = swappedStart;
      _activeThumb = thumb == _ActiveThumb.start
          ? _ActiveThumb.end
          : _ActiveThumb.start;
    }

    return SliderValue.ranged(start, end);
  }

  void _applyTapPosition(double dx, Rect trackRect, TextDirection direction) {
    final unit = _snapUnit(_dxToUnit(dx, trackRect, direction));
    if (_currentValue.isRanged) {
      _activeThumb = _selectActiveThumb(unit);
      final next = _rangeAfterMove(thumb: _activeThumb, nextUnit: unit);
      _dispatchValueChangeStart(next);
      _dispatchValueChange(next);
      _dispatchValueChangeEnd(next);
      setState(() => _currentValue = next);
      return;
    }

    final next = SliderValue.single(unit);
    _dispatchValueChangeStart(next);
    _dispatchValueChange(next);
    _dispatchValueChangeEnd(next);
    setState(() => _currentValue = next);
  }

  void _applyDragPosition(double dx, Rect trackRect, TextDirection direction) {
    final unit = _snapUnit(_dxToUnit(dx, trackRect, direction));

    if (_currentValue.isRanged) {
      final next = _rangeAfterMove(thumb: _activeThumb, nextUnit: unit);
      if (next == _currentValue) return;
      _dispatchValueChange(next);
      setState(() => _currentValue = next);
      return;
    }

    final next = SliderValue.single(unit);
    if (next == _currentValue) return;
    _dispatchValueChange(next);
    setState(() => _currentValue = next);
  }

  SliderStateView _stateView(
    BuildContext context,
    Rect trackRect,
    TextDirection direction,
  ) {
    final theme = Theme.of(context);
    final bias = _resolveFillEndBias(context, theme);

    final tStart = _currentValue.start;
    final tEnd = _currentValue.end;
    final startDx = _unitToDx(tStart, trackRect, direction);
    final endDx = _unitToDx(tEnd, trackRect, direction);

    final leftDx = min(startDx, endDx);
    final rightDx = max(startDx, endDx);

    final activeRect = _currentValue.isRanged
        ? Rect.fromLTRB(
            (leftDx + bias).clamp(trackRect.left, trackRect.right),
            trackRect.top,
            (rightDx - bias).clamp(trackRect.left, trackRect.right),
            trackRect.bottom,
          )
        : Rect.fromLTRB(
            trackRect.left,
            trackRect.top,
            (endDx - bias).clamp(trackRect.left, trackRect.right),
            trackRect.bottom,
          );

    return SliderStateView(
      trackRect: trackRect,
      activeRect: activeRect,
      isRange: _currentValue.isRanged,
      t: tEnd,
      tStart: tStart,
      tEnd: tEnd,
      value: _toActual(tEnd),
      valueStart: _toActual(tStart),
      valueEnd: _toActual(tEnd),
      hovering: _hovering,
      dragging: _dragging,
      enabled: enabled,
      divisions: widget.divisions,
      textDirection: direction,
    );
  }

  Widget _defaultTrackBuilder(BuildContext context, SliderStateView state) {
    final theme = Theme.of(context);
    return Positioned.fromRect(
      rect: state.trackRect,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: state.enabled
              ? _resolveTrackColor(context, theme)
              : _resolveDisabledTrackColor(context, theme),
          borderRadius: _resolveTrackRadius(context, theme),
        ),
      ),
    );
  }

  Widget _defaultFillBuilder(BuildContext context, SliderStateView state) {
    final theme = Theme.of(context);
    final atMax = !state.isRange && state.t >= 0.999;

    final resolved = _resolveTrackRadius(context, theme);
    final radius = resolved is BorderRadius
        ? resolved
        : BorderRadius.circular(theme.radiusSm);
    final fillRadius = state.isRange
        ? radius
        : BorderRadius.only(
            topLeft: radius.topLeft,
            bottomLeft: radius.bottomLeft,
            topRight: atMax ? radius.topRight : Radius.zero,
            bottomRight: atMax ? radius.bottomRight : Radius.zero,
          );

    return Positioned.fromRect(
      rect: state.activeRect,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: state.enabled
              ? _resolveValueColor(context, theme)
              : _resolveDisabledValueColor(context, theme),
          borderRadius: fillRadius,
        ),
      ),
    );
  }

  Widget _defaultThumbVisual(BuildContext context, SliderThumbStateView state) {
    return Container(
      width: state.size,
      height: state.size,
      decoration: BoxDecoration(
        color: state.color,
        shape: BoxShape.circle,
        border: Border.all(
          color: state.borderColor,
          width: state.borderWidth,
          strokeAlign: state.focused
              ? BorderSide.strokeAlignOutside
              : BorderSide.strokeAlignInside,
        ),
      ),
    );
  }

  Widget _buildThumb(
    BuildContext context,
    SliderStateView state,
    double unit,
    bool focusing,
    ValueChanged<bool> onFocus,
    _ActiveThumb thumb,
    VoidCallback onIncrease,
    VoidCallback onDecrease,
  ) {
    final theme = Theme.of(context);
    final center = Offset(
      _unitToDx(unit, state.trackRect, state.textDirection),
      state.trackRect.center.dy,
    );
    final size = _resolveThumbSize(context, theme);
    final thumbState = SliderThumbStateView(
      trackRect: state.trackRect,
      center: center,
      isStartThumb: thumb == _ActiveThumb.start,
      isEndThumb: thumb == _ActiveThumb.end,
      isActiveThumb: _activeThumb == thumb,
      focused: focusing,
      dragging: _dragging,
      enabled: enabled,
      t: unit,
      value: _toActual(unit),
      size: size,
      color: _resolveThumbColor(context, theme),
      borderColor: _resolveThumbBorderColor(context, theme, focusing),
      borderWidth: focusing
          ? _resolveThumbFocusedBorderWidth(context, theme)
          : _resolveThumbBorderWidth(context, theme),
    );

    return Positioned(
      left: center.dx - (size / 2),
      top: center.dy - (size / 2),
      child: FocusableActionDetector(
        enabled: enabled,
        onShowFocusHighlight: onFocus,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.arrowLeft):
              const DecreaseSliderValue(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight):
              const IncreaseSliderValue(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp):
              const IncreaseSliderValue(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown):
              const DecreaseSliderValue(),
        },
        actions: {
          IncreaseSliderValue: CallbackAction(
            onInvoke: (e) {
              onIncrease();
              return true;
            },
          ),
          DecreaseSliderValue: CallbackAction(
            onInvoke: (e) {
              onDecrease();
              return true;
            },
          ),
        },
        child:
            widget.thumbBuilder?.call(context, thumbState) ??
            _defaultThumbVisual(context, thumbState),
      ),
    );
  }

  void _stepSingle(bool increase) {
    var value = _currentValue.value;
    final defaultStep = 1 / (widget.divisions ?? 100);
    final step = increase
        ? (widget.increaseStep ?? defaultStep)
        : -(widget.decreaseStep ?? defaultStep);

    final next = SliderValue.single(_snapUnit(value + step));
    _dispatchValueChangeStart(next);
    _dispatchValueChange(next);
    _dispatchValueChangeEnd(next);
    setState(() => _currentValue = next);
  }

  void _stepRange(_ActiveThumb thumb, bool increase) {
    final defaultStep = 1 / (widget.divisions ?? 100);
    final step = increase
        ? (widget.increaseStep ?? defaultStep)
        : -(widget.decreaseStep ?? defaultStep);
    _activeThumb = thumb;

    final next = _rangeAfterMove(
      thumb: thumb,
      nextUnit:
          (thumb == _ActiveThumb.start
              ? _currentValue.start
              : _currentValue.end) +
          step,
    );

    _dispatchValueChangeStart(next);
    _dispatchValueChange(next);
    _dispatchValueChangeEnd(next);
    setState(() => _currentValue = next);
  }

  Widget _buildHint(BuildContext context, SliderStateView state) {
    final theme = Theme.of(context);
    final hint = widget.hintValue;
    if (hint == null) return const SizedBox.shrink();

    final hintStart = _unitToDx(
      _toUnit(hint.start),
      state.trackRect,
      state.textDirection,
    );
    final hintEnd = _unitToDx(
      _toUnit(hint.end),
      state.trackRect,
      state.textDirection,
    );

    return Positioned.fromRect(
      rect: Rect.fromLTRB(
        hint.isRanged ? min(hintStart, hintEnd) : state.trackRect.left,
        state.trackRect.top,
        max(hintStart, hintEnd),
        state.trackRect.bottom,
      ),
      child: Center(
        child: Container(
          height: _resolveHintHeight(context, theme),
          decoration: BoxDecoration(
            color: _resolveHintColor(context, theme),
            borderRadius: _resolveHintRadius(context, theme),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minHeight = _resolveMinHeight(context, theme);
    final maxHeight = max(minHeight, _resolveMaxHeight(context, theme));

    return Container(
      constraints: BoxConstraints(
        minWidth: _resolveMinWidth(context, theme),
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _resolveHorizontalPadding(context, theme),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textDirection = Directionality.of(context);
            final trackRect = _trackRectFor(constraints, context, theme);
            final state = _stateView(context, trackRect, textDirection);

            return Semantics(
              enabled: enabled,
              slider: true,
              value: state.isRange
                  ? '${state.valueStart.toStringAsFixed(2)} to ${state.valueEnd.toStringAsFixed(2)}'
                  : state.value.toStringAsFixed(2),
              child: GestureDetector(
                onTapDown: !enabled
                    ? null
                    : (details) {
                        _applyTapPosition(
                          details.localPosition.dx,
                          trackRect,
                          textDirection,
                        );
                      },
                onHorizontalDragStart: !enabled
                    ? null
                    : (details) {
                        _dragging = true;
                        final unit = _dxToUnit(
                          details.localPosition.dx,
                          trackRect,
                          textDirection,
                        );
                        _activeThumb = _selectActiveThumb(unit);
                        _dispatchValueChangeStart(_currentValue);
                      },
                onHorizontalDragUpdate: !enabled
                    ? null
                    : (details) {
                        _applyDragPosition(
                          details.localPosition.dx,
                          trackRect,
                          textDirection,
                        );
                      },
                onHorizontalDragEnd: !enabled
                    ? null
                    : (details) {
                        _dragging = false;
                        _dispatchValueChangeEnd(_currentValue);
                        setState(() {});
                      },
                child: MouseRegion(
                  cursor: !enabled
                      ? SystemMouseCursors.forbidden
                      : SystemMouseCursors.click,
                  onEnter: (_) {
                    if (_hovering) return;
                    setState(() => _hovering = true);
                  },
                  onExit: (_) {
                    if (!_hovering) return;
                    setState(() => _hovering = false);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      widget.trackBuilder?.call(context, state) ??
                          _defaultTrackBuilder(context, state),
                      if (widget.hintValue != null) _buildHint(context, state),
                      widget.fillBuilder?.call(context, state) ??
                          _defaultFillBuilder(context, state),
                      if (widget.ticksBuilder != null)
                        widget.ticksBuilder!.call(context, state),
                      _buildThumb(
                        context,
                        state,
                        state.tStart,
                        _focusingStart,
                        (focusing) => setState(() => _focusingStart = focusing),
                        state.isRange
                            ? _ActiveThumb.start
                            : _ActiveThumb.single,
                        () => state.isRange
                            ? _stepRange(_ActiveThumb.start, true)
                            : _stepSingle(true),
                        () => state.isRange
                            ? _stepRange(_ActiveThumb.start, false)
                            : _stepSingle(false),
                      ),
                      if (state.isRange)
                        _buildThumb(
                          context,
                          state,
                          state.tEnd,
                          _focusingEnd,
                          (focusing) => setState(() => _focusingEnd = focusing),
                          _ActiveThumb.end,
                          () => _stepRange(_ActiveThumb.end, true),
                          () => _stepRange(_ActiveThumb.end, false),
                        ),
                      if (widget.overlayBuilder != null)
                        widget.overlayBuilder!.call(context, state),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
