part of '../core/hsl_color_slider.dart';

class _HSLColorSliderState extends State<HSLColorSlider> {
  late double _currentHorizontal;
  late double _currentVertical;
  late double _hue;
  late double _saturation;
  late double _lightness;
  late double _alpha;

  @override
  void initState() {
    super.initState();
    _currentHorizontal = horizontal;
    _currentVertical = vertical;
    HSLColor hsl = widget.color;
    _hue = hsl.hue;
    _saturation = hsl.saturation;
    _lightness = hsl.lightness;
    _alpha = hsl.alpha;
  }

  void _updateColor(Offset localPosition, Size size) {
    _currentHorizontal = ((localPosition.dx - widget.padding.left) /
            (size.width - widget.padding.horizontal))
        .clamp(0, 1);
    _currentVertical = ((localPosition.dy - widget.padding.top) /
            (size.height - widget.padding.vertical))
        .clamp(0, 1);
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        _hue = _currentHorizontal * 360;
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        _hue = _currentHorizontal * 360;
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        _hue = _currentHorizontal * 360;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        _saturation = _currentHorizontal;
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        _saturation = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        _lightness = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        _hue = _currentHorizontal * 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        _alpha = _currentHorizontal;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        _hue = _currentVertical * 360;
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        _hue = _currentVertical * 360;
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        _hue = _currentVertical * 360;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        _saturation = _currentVertical;
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        _saturation = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        _lightness = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        _alpha = _currentVertical;
      }
    }
    widget.onChanging?.call(HSLColor.fromAHSL(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _lightness.clamp(0, 1),
    ));
  }

  @override
  void didUpdateWidget(covariant HSLColorSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      HSLColor hsl = widget.color;
      _hue = hsl.hue;
      _saturation = hsl.saturation;
      _lightness = hsl.lightness;
      _alpha = hsl.alpha;
      _currentHorizontal = horizontal;
      _currentVertical = vertical;
    }
  }

  bool get isSingleChannel {
    return widget.sliderType == HSLColorSliderType.hue ||
        widget.sliderType == HSLColorSliderType.sat ||
        widget.sliderType == HSLColorSliderType.lum ||
        widget.sliderType == HSLColorSliderType.alpha;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double cursorRadius = theme.scaling * 16;
    double radDiv = isSingleChannel ? 4 : 2;
    return GestureDetector(
      onTapDown: (details) {
        _updateColor(details.localPosition, context.size!);
        widget.onChanged?.call(HSLColor.fromAHSL(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _lightness.clamp(0, 1),
        ));
      },
      onPanUpdate: (details) {
        setState(() {
          _updateColor(details.localPosition, context.size!);
        });
      },
      onPanEnd: (details) {
        widget.onChanged?.call(HSLColor.fromAHSL(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _lightness.clamp(0, 1),
        ));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: AlphaPainter(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: HSLColorSliderPainter(
                    sliderType: widget.sliderType,
                    color: HSLColor.fromAHSL(
                      _alpha.clamp(0, 1),
                      _hue.clamp(0, 360),
                      _saturation.clamp(0, 1),
                      _lightness.clamp(0, 1),
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
                              (_currentVertical.clamp(0, 1) * 2) - 1),
                          child: Container(
                            width: cursorRadius,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: widget.color.toColor(),
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
                              (_currentVertical.clamp(0, 1) * 2) - 1),
                          child: Container(
                            height: cursorRadius,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: widget.color.toColor(),
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
                          (_currentVertical.clamp(0, 1) * 2) - 1),
                      child: Container(
                        width: cursorRadius,
                        height: cursorRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color.toColor(),
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
    HSLColor hsl = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    }
    return 0;
  }

  double get horizontal {
    HSLColor hsl = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    }
    return 0;
  }
}
