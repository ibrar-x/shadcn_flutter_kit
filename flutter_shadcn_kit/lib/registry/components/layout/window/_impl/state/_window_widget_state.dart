part of '../../window.dart';

class _WindowWidgetState extends State<WindowWidget> with WindowHandle {
  @override
  late WindowController controller;
  late WindowState state;
  WindowViewport? _viewport;
  Window? _entry;
  Alignment? _dragAlignment;

  void _initializeController() {
    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = WindowController(
        bounds: widget.bounds!,
        maximized: widget.maximized,
        minimized: widget.minimized!,
        closable: widget.closable!,
        resizable: widget.resizable!,
        draggable: widget.draggable!,
        maximizable: widget.maximizable!,
        minimizable: widget.minimizable!,
        enableSnapping: widget.enableSnapping!,
        constraints: widget.constraints!,
      );
    }
    controller._attachedState = this;
    state = controller.value;
    controller.addListener(_handleControllerUpdate);
  }

  void _handleControllerUpdate() {
    didControllerUpdate(state);
    state = controller.value;
  }

  void didControllerUpdate(WindowState oldState) {
    if (oldState.alwaysOnTop != state.alwaysOnTop) {
      _viewport?.navigator.setAlwaysOnTop(_entry!, state.alwaysOnTop);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewport = Data.maybeOf<WindowViewport>(context);
    _entry = Data.maybeOf<Window>(context);
  }

  @override
  void didUpdateWidget(covariant WindowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller.removeListener(_handleControllerUpdate);
      controller._attachedState = null;
      WindowState oldState = state;
      _initializeController();
      if (oldState != state) {
        didControllerUpdate(oldState);
      }
    }
  }

  Widget _wrapResizer({
    required MouseCursor cursor,
    required Rect Function(Rect bounds, Offset delta) onResize,
    required int adjustmentX,
    required int adjustmentY,
  }) {
    return MouseRegion(
      cursor: cursor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (details) {
          if (state.maximized != null || state.minimized) return;
          var newBounds = onResize(bounds, details.delta);
          double deltaXAdjustment = 0;
          double deltaYAdjustment = 0;
          if (newBounds.width < state.constraints.minWidth) {
            deltaXAdjustment = state.constraints.minWidth - newBounds.width;
          } else if (newBounds.width > state.constraints.maxWidth) {
            deltaXAdjustment = state.constraints.maxWidth - newBounds.width;
          }
          if (newBounds.height < state.constraints.minHeight) {
            deltaYAdjustment = state.constraints.minHeight - newBounds.height;
          } else if (newBounds.height > state.constraints.maxHeight) {
            deltaYAdjustment = state.constraints.maxHeight - newBounds.height;
          }
          deltaXAdjustment *= adjustmentX;
          deltaYAdjustment *= adjustmentY;
          if (deltaXAdjustment != 0 || deltaYAdjustment != 0) {
            newBounds = onResize(
              newBounds,
              Offset(deltaXAdjustment, deltaYAdjustment),
            );
          }
          bounds = newBounds;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Data<WindowHandle>.inherit(
      data: this,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          final compTheme = ComponentTheme.maybeOf<WindowTheme>(context);
          var resizeThickness =
              widget.resizeThickness ?? compTheme?.resizeThickness ?? 8;
          final titleBarHeight =
              (widget.titleBarHeight ?? compTheme?.titleBarHeight ?? 32) *
              theme.scaling;

          Widget windowClient = Card(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.zero,
            borderRadius: state.maximized != null
                ? BorderRadius.zero
                : theme.borderRadiusMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.title != null || widget.actions != null)
                  ClickDetector(
                    onClick: maximizable
                        ? (details) {
                            if (details.clickCount >= 2) {
                              if (maximized == null) {
                                maximized = const Rect.fromLTWH(0, 0, 1, 1);
                              } else {
                                maximized = null;
                              }
                            }
                          }
                        : null,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        var localPosition = details.localPosition;
                        var bounds = this.bounds;
                        var max = maximized;
                        var size = _viewport?.size;
                        if (max != null && size != null) {
                          bounds = Rect.fromLTWH(
                            max.left * size.width,
                            max.top * size.height,
                            max.width * size.width,
                            max.height * size.height,
                          );
                        }
                        var alignX = lerpDouble(
                          -1,
                          1,
                          (localPosition.dx / bounds.width),
                        )!;
                        var alignY = lerpDouble(
                          -1,
                          1,
                          (localPosition.dy / bounds.height),
                        )!;
                        _dragAlignment = Alignment(alignX, alignY);
                        if (_entry != null) {
                          _viewport?.navigator._state._startDraggingWindow(
                            _entry!,
                            details.globalPosition,
                          );
                        }
                        if (state.maximized != null) {
                          maximized = null;
                          RenderBox? layerRenderBox =
                              _viewport?.navigator._state.context
                                      .findRenderObject()
                                  as RenderBox?;
                          if (layerRenderBox != null) {
                            Offset layerLocal = layerRenderBox.globalToLocal(
                              details.globalPosition,
                            );
                            Size titleSize = Size(
                              this.bounds.width,
                              titleBarHeight,
                            );
                            this.bounds = Rect.fromLTWH(
                              layerLocal.dx - titleSize.width / 2,
                              layerLocal.dy - titleSize.height / 2,
                              this.bounds.width,
                              this.bounds.height,
                            );
                          }
                        }
                      },
                      onPanUpdate: (details) {
                        bounds = bounds.translate(
                          details.delta.dx,
                          details.delta.dy,
                        );
                        if (_entry != null) {
                          _viewport?.navigator._state._updateDraggingWindow(
                            _entry!,
                            details.globalPosition,
                          );
                        }
                      },
                      onPanEnd: (details) {
                        if (_entry != null) {
                          _viewport?.navigator._state._stopDraggingWindow(
                            _entry!,
                          );
                        }
                        _dragAlignment = null;
                      },
                      onPanCancel: () {
                        if (_entry != null) {
                          _viewport?.navigator._state._stopDraggingWindow(
                            _entry!,
                          );
                        }
                        _dragAlignment = null;
                      },
                      child: Container(
                        height: titleBarHeight,
                        padding: EdgeInsets.all(
                          theme.density.baseGap * theme.scaling * 0.25,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8 * theme.scaling,
                                ),
                                child: (_viewport?.focused ?? true)
                                    ? (widget.title ?? const SizedBox())
                                    : (widget.title ?? const SizedBox())
                                          .muted(),
                              ),
                            ),
                            if (widget.actions != null) widget.actions!,
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.content != null) Expanded(child: widget.content!),
              ],
            ),
          );
          // add transition
          windowClient = AnimatedValueBuilder(
            initialValue: 0.0,
            value: (_viewport?.closed ?? false) ? 0.0 : 1.0,
            duration: kDefaultDuration,
            onEnd: (value) {
              if (_viewport?.closed ?? false) {
                _viewport?.navigator.removeWindow(_entry!);
              }
            },
            builder: (context, value, child) {
              return Transform.scale(
                scale: (_viewport?.closed ?? false)
                    ? lerpDouble(0.8, 1.0, value)!
                    : lerpDouble(0.9, 1.0, value)!,
                child: Opacity(opacity: value, child: child),
              );
            },
            child: windowClient,
          );
          windowClient = AnimatedScale(
            scale: (_viewport?.minify ?? false) ? 0.65 : 1.0,
            duration: kDefaultDuration,
            alignment: _dragAlignment ?? Alignment.center,
            curve: Curves.easeInOut,
            child: windowClient,
          );
          windowClient = IgnorePointer(
            ignoring: _viewport?.ignorePointer ?? false,
            child: windowClient,
          );
          Widget windowContainer = Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              if (_entry != null) {
                _viewport?.navigator.focusWindow(_entry!);
              }
            },
            child: GroupWidget(
              children: [
                windowClient,
                // Resize regions
                if (resizable &&
                    maximized == null &&
                    _dragAlignment == null) ...[
                  // top left
                  GroupPositioned(
                    top: 0,
                    left: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpLeft,
                      adjustmentX: -1,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + delta,
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // top right
                  GroupPositioned(
                    top: 0,
                    right: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpRight,
                      adjustmentX: 1,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topRight + delta,
                          bounds.bottomLeft,
                        );
                      },
                    ),
                  ),
                  // bottom left
                  GroupPositioned(
                    bottom: 0,
                    left: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeDownLeft,
                      adjustmentX: -1,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomLeft + delta,
                          bounds.topRight,
                        );
                      },
                    ),
                  ),
                  // bottom right
                  GroupPositioned(
                    bottom: 0,
                    right: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeDownRight,
                      adjustmentX: 1,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomRight + delta,
                          bounds.topLeft,
                        );
                      },
                    ),
                  ),
                  // top
                  GroupPositioned(
                    top: 0,
                    left: resizeThickness * theme.scaling,
                    right: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpDown,
                      adjustmentX: 0,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + Offset(0, delta.dy),
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // bottom
                  GroupPositioned(
                    bottom: 0,
                    left: resizeThickness * theme.scaling,
                    right: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpDown,
                      adjustmentX: 0,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomLeft + Offset(0, delta.dy),
                          bounds.topRight,
                        );
                      },
                    ),
                  ),
                  // left
                  GroupPositioned(
                    top: resizeThickness * theme.scaling,
                    left: 0,
                    bottom: resizeThickness * theme.scaling,
                    width: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeLeftRight,
                      adjustmentX: -1,
                      adjustmentY: 0,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + Offset(delta.dx, 0),
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // right
                  GroupPositioned(
                    top: resizeThickness * theme.scaling,
                    right: 0,
                    bottom: resizeThickness * theme.scaling,
                    width: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeLeftRight,
                      adjustmentX: 1,
                      adjustmentY: 0,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topRight + Offset(delta.dx, 0),
                          bounds.bottomLeft,
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
          final size = _viewport?.size ?? Size.zero;
          final maximizedRect = maximized;
          final targetRect = maximizedRect == null
              ? bounds
              : Rect.fromLTWH(
                  maximizedRect.left * size.width,
                  maximizedRect.top * size.height,
                  maximizedRect.width * size.width,
                  maximizedRect.height * size.height,
                );
          return AnimatedValueBuilder<Rect>(
            value: targetRect,
            duration: kDefaultDuration,
            curve: Curves.easeInOut,
            lerp: Rect.lerp,
            builder: (context, rect, child) {
              return GroupPositioned.fromRect(rect: rect, child: child!);
            },
            child: windowContainer,
          );
        },
      ),
    );
  }

  @override
  bool get alwaysOnTop => state.alwaysOnTop;

  @override
  Rect get bounds => state.bounds;

  @override
  bool get closable => state.closable;

  @override
  bool get draggable => state.draggable;

  @override
  bool get enableSnapping => state.enableSnapping;

  @override
  bool get maximizable => state.maximizable;

  @override
  Rect? get maximized => state.maximized;

  @override
  bool get minimizable => state.minimizable;

  @override
  bool get minimized => state.minimized;

  @override
  bool get resizable => state.resizable;

  @override
  bool get focused => state.alwaysOnTop;

  @override
  set alwaysOnTop(bool value) {
    if (value != state.alwaysOnTop) {
      controller.value = state.copyWith(alwaysOnTop: () => value);
    }
  }

  @override
  set bounds(Rect value) {
    if (value != state.bounds) {
      controller.value = state.copyWith(bounds: () => value);
    }
  }

  @override
  set closable(bool value) {
    if (value != state.closable) {
      controller.value = state.copyWith(closable: () => value);
    }
  }

  @override
  void close() {
    _entry?.closed.value = true;
  }

  @override
  set draggable(bool value) {
    if (value != state.draggable) {
      controller.value = state.copyWith(draggable: () => value);
    }
  }

  @override
  set enableSnapping(bool value) {
    if (value != state.enableSnapping) {
      controller.value = state.copyWith(enableSnapping: () => value);
    }
  }

  @override
  set focused(bool value) {
    if (_entry == null) return;
    if (value) {
      _viewport?.navigator.focusWindow(_entry!);
    } else {
      _viewport?.navigator.unfocusWindow(_entry!);
    }
  }

  @override
  set maximizable(bool value) {
    if (value != state.maximizable) {
      controller.value = state.copyWith(maximizable: () => value);
    }
  }

  @override
  set maximized(Rect? value) {
    if (value != state.maximized) {
      controller.value = state.withMaximized(value);
    }
  }

  @override
  set minimizable(bool value) {
    if (value != state.minimizable) {
      controller.value = state.copyWith(minimizable: () => value);
    }
  }

  @override
  set minimized(bool value) {
    if (value != state.minimized) {
      controller.value = state.copyWith(minimized: () => value);
    }
  }

  @override
  set resizable(bool value) {
    if (value != state.resizable) {
      controller.value = state.copyWith(resizable: () => value);
    }
  }
}
