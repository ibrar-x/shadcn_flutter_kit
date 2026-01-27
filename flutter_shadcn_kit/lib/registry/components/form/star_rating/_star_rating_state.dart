part of 'star_rating.dart';

class _StarRatingState extends State<StarRating>
    with FormValueSupplier<double, StarRating> {
  double? _changingValue;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant StarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(double value) {
    widget.onChanged?.call(value);
  }

  Widget _buildStar(BuildContext context, [bool focusBorder = false]) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<StarRatingTheme>(context);
    var starValleyRounding = widget.starValleyRounding ?? 0.0;
    var starSquash = widget.starSquash ?? 0.0;
    var starInnerRadiusRatio = widget.starInnerRadiusRatio ?? 0.4;
    var starRotation = widget.starRotation ?? 0.0;
    var starSize = styleValue(
            widgetValue: widget.starSize,
            themeValue: compTheme?.starSize,
            defaultValue: 24.0) *
        scaling;
    return Container(
      width: starSize,
      height: starSize,
      decoration: ShapeDecoration(
        color: !focusBorder ? Colors.white : null,
        shape: StarBorder(
          points: widget.starPoints,
          pointRounding: widget.starPointRounding ?? (theme.radius / 2),
          valleyRounding: starValleyRounding * theme.radius,
          squash: starSquash,
          innerRadiusRatio: starInnerRadiusRatio,
          rotation: starRotation,
          side: focusBorder && _focused
              ? BorderSide(
                  color: theme.colorScheme.ring,
                  width: 2.0 * scaling,
                  strokeAlign: BorderSide.strokeAlignOutside)
              : BorderSide.none,
        ),
      ),
    );
  }

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    double roundedValue =
        ((_changingValue ?? widget.value) / widget.step).round() * widget.step;
    return AnimatedValueBuilder(
      value: roundedValue,
      duration: kDefaultDuration,
      builder: (context, roundedValue, child) {
        final theme = Theme.of(context);
        final scaling = theme.scaling;
        final compTheme = ComponentTheme.maybeOf<StarRatingTheme>(context);
        var starSize = styleValue(
            widgetValue: widget.starSize,
            themeValue: compTheme?.starSize,
            defaultValue: 24.0 * scaling);
        var starSpacing = styleValue(
            widgetValue: widget.starSpacing,
            themeValue: compTheme?.starSpacing,
            defaultValue: 5.0 * scaling);
        var activeColor = styleValue(
            widgetValue: widget.activeColor,
            themeValue: compTheme?.activeColor,
            defaultValue: _enabled
                ? theme.colorScheme.primary
                : theme.colorScheme.mutedForeground);
        var backgroundColor = styleValue(
            widgetValue: widget.backgroundColor,
            themeValue: compTheme?.backgroundColor,
            defaultValue: theme.colorScheme.muted);
        return FocusableActionDetector(
          enabled: _enabled,
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          onShowFocusHighlight: (showFocus) {
            setState(() {
              _focused = showFocus;
            });
          },
          onShowHoverHighlight: (showHover) {
            if (!showHover) {
              setState(() {
                _changingValue = null;
              });
            }
          },
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.arrowRight):
                IncreaseStarIntent(widget.step),
            LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                DecreaseStarIntent(widget.step),
          },
          actions: {
            IncreaseStarIntent: CallbackAction<IncreaseStarIntent>(
              onInvoke: (intent) {
                if (widget.onChanged != null) {
                  widget.onChanged!(
                      (roundedValue + intent.step).clamp(0.0, widget.max));
                }
                return;
              },
            ),
            DecreaseStarIntent: CallbackAction<DecreaseStarIntent>(
              onInvoke: (intent) {
                if (widget.onChanged != null) {
                  widget.onChanged!(
                      (roundedValue - intent.step).clamp(0.0, widget.max));
                }
                return;
              },
            ),
          },
          child: MouseRegion(
            onHover: (event) {
              if (!_enabled) return;
              if (widget.onChanged == null) return;
              double size = context.size!.width;
              double progress = (event.localPosition.dx / size).clamp(0.0, 1.0);
              double newValue = (progress * widget.max).clamp(0.0, widget.max);
              setState(() {
                _changingValue = newValue;
              });
            },
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (widget.onChanged != null && roundedValue != widget.value) {
                  widget.onChanged!(roundedValue);
                }
              },
              onTapDown: (details) {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                double totalStarSize =
                    starSize + (starSpacing * (widget.max.ceil() - 1));
                double progress =
                    (details.localPosition.dx / totalStarSize).clamp(0.0, 1.0);
                double newValue =
                    (progress * widget.max).clamp(0.0, widget.max);
                widget.onChanged!(newValue);
              },
              onPanUpdate: (details) {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                int totalStars = widget.max.ceil();
                double totalStarSize =
                    starSize * totalStars + (starSpacing * (totalStars - 1));
                double progress =
                    (details.localPosition.dx / totalStarSize).clamp(0.0, 1.0);
                double newValue =
                    (progress * widget.max).clamp(0.0, widget.max);
                setState(() {
                  _changingValue = newValue;
                });
              },
              onPanEnd: (details) {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                widget.onChanged!(_changingValue ?? roundedValue);
                setState(() {
                  _changingValue = null;
                });
              },
              onPanCancel: () {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                widget.onChanged!(_changingValue ?? roundedValue);
                setState(() {
                  _changingValue = null;
                });
              },
              child: Flex(
                direction: widget.direction,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.max.ceil(); i++)
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [
                                activeColor,
                                backgroundColor,
                              ],
                              stops: [
                                (roundedValue - i).clamp(0.0, 1.0),
                                (roundedValue - i).clamp(0.0, 1.0),
                              ],
                              begin: widget.direction == Axis.horizontal
                                  ? Alignment.centerLeft
                                  : Alignment.bottomCenter,
                              end: widget.direction == Axis.horizontal
                                  ? Alignment.centerRight
                                  : Alignment.topCenter,
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcIn,
                          child: _buildStar(context),
                        ),
                        _buildStar(context, true),
                      ],
                    ),
                ],
              ).gap(starSpacing),
            ),
          ),
        );
      },
    );
  }
}
