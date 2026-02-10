part of '../../drawer.dart';

class _DrawerWrapperState extends State<DrawerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ControlledAnimation _extraOffset;

  OverlayPosition get resolvedPosition {
    var position = widget.position;
    if (position == OverlayPosition.start) {
      return Directionality.of(context) == TextDirection.ltr
          ? OverlayPosition.left
          : OverlayPosition.right;
    }
    if (position == OverlayPosition.end) {
      return Directionality.of(context) == TextDirection.ltr
          ? OverlayPosition.right
          : OverlayPosition.left;
    }
    return position;
  }

  @override
  void initState() {
    super.initState();
    _controller =
        widget.animationController ??
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 350),
        );
    _extraOffset = ControlledAnimation(_controller);
  }

  double? get expandingHeight {
    switch (resolvedPosition) {
      case OverlayPosition.left:
      case OverlayPosition.right:
        return double.infinity;
      default:
        return null;
    }
  }

  double? get expandingWidth {
    switch (resolvedPosition) {
      case OverlayPosition.top:
      case OverlayPosition.bottom:
        return double.infinity;
      default:
        return null;
    }
  }

  Widget buildDraggableBar(ThemeData theme) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
      case OverlayPosition.right:
        return Container(
          width: widget.dragHandleSize?.width ?? 6 * theme.scaling,
          height: widget.dragHandleSize?.height ?? 100 * theme.scaling,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: theme.borderRadiusXxl,
          ),
        );
      case OverlayPosition.top:
      case OverlayPosition.bottom:
        return Container(
          width: widget.dragHandleSize?.width ?? 100 * theme.scaling,
          height: widget.dragHandleSize?.height ?? 6 * theme.scaling,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: theme.borderRadiusXxl,
          ),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  Size getSize(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.hasSize ?? false
        ? renderBox?.size ?? widget.size
        : widget.size;
  }

  Widget buildDraggable(
    BuildContext context,
    ControlledAnimation? controlled,
    Widget child,
    ThemeData theme,
  ) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.width;
            double newValue = controlled.value + increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onHorizontalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _extraOffset,
                builder: (context, child) {
                  return Gap(
                    widget.extraSize.width + max(_extraOffset.value, 0),
                  );
                },
              ),
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                      scaleX:
                          1 + _extraOffset.value / getSize(context).width / 4,
                      alignment: Alignment.centerRight,
                      child: child,
                    );
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              if (widget.showDragHandle) ...[
                Gap(
                  widget.gapAfterDragger ??
                      theme.density.baseGap * theme.scaling * gapLg,
                ),
                buildDraggableBar(theme),
                Gap(
                  widget.gapBeforeDragger ??
                      theme.density.baseGap * theme.scaling * gapMd,
                ),
              ],
            ],
          ),
        );
      case OverlayPosition.right:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.width;
            double newValue = controlled.value - increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  -details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onHorizontalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showDragHandle) ...[
                Gap(
                  widget.gapBeforeDragger ??
                      theme.density.baseGap * theme.scaling * gapMd,
                ),
                buildDraggableBar(theme),
                Gap(
                  widget.gapAfterDragger ??
                      theme.density.baseGap * theme.scaling * gapLg,
                ),
              ],
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                      scaleX:
                          1 + _extraOffset.value / getSize(context).width / 4,
                      alignment: Alignment.centerLeft,
                      child: child,
                    );
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              AnimatedBuilder(
                animation: _extraOffset,
                builder: (context, child) {
                  return Gap(
                    widget.extraSize.width + max(_extraOffset.value, 0),
                  );
                },
              ),
            ],
          ),
        );
      case OverlayPosition.top:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.height;
            double newValue = controlled.value + increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onVerticalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _extraOffset,
                builder: (context, child) {
                  return Gap(
                    widget.extraSize.height + max(_extraOffset.value, 0),
                  );
                },
              ),
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                      scaleY:
                          1 + _extraOffset.value / getSize(context).height / 4,
                      alignment: Alignment.bottomCenter,
                      child: child,
                    );
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              if (widget.showDragHandle) ...[
                Gap(
                  widget.gapAfterDragger ??
                      theme.density.baseGap * theme.scaling * gapLg,
                ),
                buildDraggableBar(theme),
                Gap(
                  widget.gapBeforeDragger ??
                      theme.density.baseGap * theme.scaling * gapMd,
                ),
              ],
            ],
          ),
        );
      case OverlayPosition.bottom:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.height;
            double newValue = controlled.value - increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  -details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onVerticalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showDragHandle) ...[
                Gap(
                  widget.gapBeforeDragger ??
                      theme.density.baseGap * theme.scaling * gapMd,
                ),
                buildDraggableBar(theme),
                Gap(
                  widget.gapAfterDragger ??
                      theme.density.baseGap * theme.scaling * gapLg,
                ),
              ],
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                      scaleY:
                          1 + _extraOffset.value / getSize(context).height / 4,
                      alignment: Alignment.topCenter,
                      child: child,
                    );
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              AnimatedBuilder(
                animation: _extraOffset,
                builder: (context, child) {
                  return Gap(
                    widget.extraSize.height + max(_extraOffset.value, 0),
                  );
                },
              ),
            ],
          ),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  @override
  void didUpdateWidget(covariant DrawerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationController != oldWidget.animationController) {
      if (oldWidget.animationController == null) {
        _controller.dispose();
      }
      _controller =
          widget.animationController ??
          AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 350),
          );
    }
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Border getBorder(ThemeData theme) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        // top, right, bottom
        return Border(
          right: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.right:
        // top, left, bottom
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.top:
        // left, right, bottom
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          right: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.bottom:
        // left, right, top
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          right: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  BorderRadiusGeometry getBorderRadius(double radius) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case OverlayPosition.right:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      case OverlayPosition.top:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case OverlayPosition.bottom:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  BoxDecoration getDecoration(ThemeData theme) {
    var border = getBorder(theme);
    // according to the design, the border radius is 10
    // seems to be a fixed value
    var borderRadius = widget.borderRadius ?? getBorderRadius(theme.radiusXxl);
    var backgroundColor = theme.colorScheme.background;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    if (surfaceOpacity != null && surfaceOpacity < 1) {
      if (widget.stackIndex == 0) {
        // the top sheet should have a higher opacity to prevent
        // visual bleeding from the main content
        surfaceOpacity = surfaceOpacity * 1.25;
      }
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    return BoxDecoration(
      borderRadius: borderRadius,
      color: backgroundColor,
      border: border,
    );
  }

  Widget buildChild(BuildContext context) {
    return widget.child;
  }

  EdgeInsets buildPadding(BuildContext context) {
    return widget.padding;
  }

  EdgeInsets buildMargin(BuildContext context) {
    return EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<_MountedOverlayEntryData>(context);
    final animation = data?.state._controlledAnimation;
    final theme = Theme.of(context);
    var surfaceBlur = widget.surfaceBlur ?? theme.surfaceBlur;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    var borderRadius = widget.borderRadius ?? getBorderRadius(theme.radiusXxl);
    Widget container = Container(
      width: widget.expands ? expandingWidth : null,
      height: widget.expands ? expandingHeight : null,
      decoration: getDecoration(theme),
      padding: buildPadding(context),
      margin: buildMargin(context),
      child: widget.draggable
          ? buildDraggable(context, animation, buildChild(context), theme)
          : buildChild(context),
    );

    if (widget.constraints != null) {
      container = ConstrainedBox(
        constraints: widget.constraints!,
        child: container,
      );
    }

    if (widget.alignment != null) {
      container = Align(alignment: widget.alignment!, child: container);
    }

    if (surfaceBlur != null && surfaceBlur > 0) {
      container = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: getBorderRadius(theme.radiusXxl),
        child: container,
      );
    }
    var barrierColor = widget.barrierColor ?? Colors.black.scaleAlpha(0.8);
    if (animation != null) {
      if (widget.stackIndex != 0) {
        // weaken the barrier color for the upper sheets
        barrierColor = barrierColor.scaleAlpha(0.75);
      }
      container = ModalBackdrop(
        surfaceClip: ModalBackdrop.shouldClipSurface(surfaceOpacity),
        borderRadius: borderRadius,
        barrierColor: barrierColor,
        fadeAnimation: animation,
        padding: buildMargin(context),
        child: container,
      );
    }
    return container;
  }
}
