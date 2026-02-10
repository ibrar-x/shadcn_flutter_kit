part of '../core/hsv_color_slider.dart';

class _HSVColorSliderState extends State<HSVColorSlider> {
  late double _currentHorizontal;
  late double _currentVertical;
  late double _hue;
  late double _saturation;
  late double _value;
  late double _alpha;

  @override
  void initState() {
    super.initState();
    _currentHorizontal = horizontal;
    _currentVertical = vertical;
    HSVColor hsv = widget.value;
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _value = hsv.value;
    _alpha = hsv.alpha;
  }

  void _updateColor(Offset localPosition, Size size) {
    _currentHorizontal =
        ((localPosition.dx - widget.padding.left) /
                (size.width - widget.padding.horizontal))
            .clamp(0, 1);
    _currentVertical =
        ((localPosition.dy - widget.padding.top) /
                (size.height - widget.padding.vertical))
            .clamp(0, 1);
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        _hue = _currentHorizontal * 360;
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        _hue = _currentHorizontal * 360;
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        _hue = _currentHorizontal * 360;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        _saturation = _currentHorizontal;
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        _saturation = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentHorizontal * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentHorizontal;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        _hue = _currentVertical * 360;
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        _hue = _currentVertical * 360;
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        _hue = _currentVertical * 360;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        _saturation = _currentVertical;
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        _saturation = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentVertical;
      }
    }
    widget.onChanging?.call(
      HSVColor.fromAHSV(
        _alpha.clamp(0, 1),
        _hue.clamp(0, 360),
        _saturation.clamp(0, 1),
        _value.clamp(0, 1),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HSVColorSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      HSVColor hsv = widget.value;
      _hue = hsv.hue;
      _saturation = hsv.saturation;
      _value = hsv.value;
      _alpha = hsv.alpha;
      _currentHorizontal = horizontal;
      _currentVertical = vertical;
    }
  }

  bool get isSingleChannel {
    return widget.sliderType == HSVColorSliderType.hue ||
        widget.sliderType == HSVColorSliderType.sat ||
        widget.sliderType == HSVColorSliderType.val ||
        widget.sliderType == HSVColorSliderType.alpha;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double cursorRadius = theme.scaling * 16;
    double radDiv = isSingleChannel ? 4 : 2;
    return GestureDetector(
      onTapDown: (details) {
        _updateColor(details.localPosition, context.size!);
        widget.onChanged?.call(
          HSVColor.fromAHSV(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _value.clamp(0, 1),
          ),
        );
      },
      onPanUpdate: (details) {
        setState(() {
          _updateColor(details.localPosition, context.size!);
        });
      },
      onPanEnd: (details) {
        widget.onChanged?.call(
          HSVColor.fromAHSV(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _value.clamp(0, 1),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(painter: AlphaPainter()),
              ),
            ),
          ),
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: HSVColorSliderPainter(
                    sliderType: widget.sliderType,
                    color: HSVColor.fromAHSV(
                      _alpha.clamp(0, 1),
                      _hue.clamp(0, 360),
                      _saturation.clamp(0, 1),
                      _value.clamp(0, 1),
                    ),
                    reverse: widget.reverse,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -cursorRadius / radDiv,
            top: -cursorRadius / radDiv,
            bottom: -cursorRadius / radDiv,
            right: -cursorRadius / radDiv,
            child: isSingleChannel
                ? (widget.reverse
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: widget.padding.left,
                            right: widget.padding.right,
                          ),
                          child: Align(
                            alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1,
                            ),
                            child: Container(
                              width: cursorRadius,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: widget.value.toColor(),
                                border: Border.all(
                                  color: Colors.white,
                                  width: theme.scaling * 2,
                                ),
                                borderRadius: BorderRadius.all(widget.radius),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            top: widget.padding.top,
                            bottom: widget.padding.bottom,
                          ),
                          child: Align(
                            alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1,
                            ),
                            child: Container(
                              height: cursorRadius,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: widget.value.toColor(),
                                border: Border.all(
                                  color: Colors.white,
                                  width: theme.scaling * 2,
                                ),
                                borderRadius: BorderRadius.all(widget.radius),
                              ),
                            ),
                          ),
                        ))
                : Padding(
                    padding: widget.padding,
                    child: Align(
                      alignment: Alignment(
                        (_currentHorizontal.clamp(0, 1) * 2) - 1,
                        (_currentVertical.clamp(0, 1) * 2) - 1,
                      ),
                      child: Container(
                        width: cursorRadius,
                        height: cursorRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.value.toColor(),
                          border: Border.all(
                            color: Colors.white,
                            width: theme.scaling * 2,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  double get vertical {
    HSVColor hsv = widget.value;
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }

  double get horizontal {
    HSVColor hsv = widget.value;
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }
}
