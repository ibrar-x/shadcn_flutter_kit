part of '../../window.dart';

class _WindowNavigatorState extends State<WindowNavigator>
    with WindowNavigatorHandle {
  late List<Window> _windows;
  late List<Window> _topWindows;
  int _focusLayer = 0; // 0: background, 1: foreground, 2: foremost

  final ValueNotifier<_DraggingWindow?> _draggingWindow =
      ValueNotifier<_DraggingWindow?>(null);
  final ValueNotifier<bool> _hoveringTopSnapper = ValueNotifier(false);
  final ValueNotifier<WindowSnapStrategy?> _snappingStrategy =
      ValueNotifier(null);

  void _startDraggingWindow(Window draggingWindow, Offset cursorPosition) {
    if (_draggingWindow.value != null) return;
    _draggingWindow.value = _DraggingWindow(draggingWindow, cursorPosition);
  }

  void _updateDraggingWindow(Window handle, Offset cursorPosition) {
    if (_draggingWindow.value == null ||
        _draggingWindow.value!.window != handle) {
      return;
    }
    _draggingWindow.value =
        _DraggingWindow(_draggingWindow.value!.window, cursorPosition);
  }

  void _stopDraggingWindow(Window handle) {
    if (_draggingWindow.value == null ||
        _draggingWindow.value!.window != handle) {
      return;
    }
    var snapping = _snappingStrategy.value;
    if (snapping != null && handle.mounted) {
      handle.handle.maximized = snapping.relativeBounds;
    }
    _draggingWindow.value = null;
    _hoveringTopSnapper.value = false;
    _snappingStrategy.value = null;
  }

  @override
  List<Window> get windows => UnmodifiableListView(_windows + _topWindows);

  @override
  void initState() {
    super.initState();
    _windows = [];
    _topWindows = [];
    for (var window in widget.initialWindows) {
      if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
        _topWindows.add(window);
      } else {
        _windows.add(window);
      }
    }
  }

  @override
  bool isFocused(Window window) {
    if (_focusLayer == 0) return false;
    if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
      if (_focusLayer == 1) return false;
      int index = _topWindows.indexOf(window);
      return index == 0;
    } else {
      if (_focusLayer == 2) return false;
      int index = _windows.indexOf(window);
      return index == 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<WindowTheme>(context);
    final titleBarHeight = (compTheme?.titleBarHeight ?? 32) * theme.scaling;
    return LayoutBuilder(builder: (context, constraints) {
      return ListenableBuilder(
          listenable: Listenable.merge([
            _draggingWindow,
            _snappingStrategy,
          ]),
          builder: (context, child) {
            return ClipRect(
              child: GroupWidget(
                children: [
                  Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (_) {
                      if (_focusLayer != 0) {
                        setState(() {
                          _focusLayer = 0;
                        });
                      }
                    },
                    child: widget.child,
                  ),
                  _WindowLayerGroup(
                    constraints: constraints,
                    windows: _windows,
                    handle: this,
                    alwaysOnTop: false,
                    showTopSnapBar: widget.showTopSnapBar,
                  ),
                  _WindowLayerGroup(
                    constraints: constraints,
                    windows: _topWindows,
                    handle: this,
                    alwaysOnTop: true,
                    showTopSnapBar: widget.showTopSnapBar,
                  ),
                  GroupPositioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: titleBarHeight,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0, 0, 1, 1),
                        shouldMinifyWindow: false,
                      ))),
                  GroupPositioned(
                      top: titleBarHeight,
                      bottom: 0,
                      left: 0,
                      width: titleBarHeight,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0, 0, 0.5, 1),
                        shouldMinifyWindow: false,
                      ))),
                  GroupPositioned(
                      top: titleBarHeight,
                      bottom: 0,
                      right: 0,
                      width: titleBarHeight,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0.5, 0, 0.5, 1),
                        shouldMinifyWindow: false,
                      ))),
                ],
              ),
            );
          });
    });
  }

  Widget _createBorderSnapStrategy(WindowSnapStrategy snapStrategy) {
    return MouseRegion(
      opaque: false,
      hitTestBehavior: HitTestBehavior.translucent,
      onHover: (event) {
        _snappingStrategy.value = snapStrategy;
      },
      onEnter: (event) {
        _snappingStrategy.value = snapStrategy;
      },
      onExit: (event) {
        _snappingStrategy.value = null;
      },
    );
  }

  Widget _createPaneSnapStrategy(
      Size size, ThemeData theme, WindowSnapStrategy snapStrategy,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRight = false,
      bool allLeft = false,
      bool allRight = false,
      bool allTop = false,
      bool allBottom = false}) {
    const double gap = 2;
    var left = snapStrategy.relativeBounds.left * size.width;
    var top = snapStrategy.relativeBounds.top * size.height;
    var width = snapStrategy.relativeBounds.width * size.width;
    var height = snapStrategy.relativeBounds.height * size.height;
    if (topLeft && topRight) {
      top += gap;
      height -= gap;
      if (bottomLeft) {
        left += gap;
        width -= gap;
      } else if (bottomRight) {
        width -= gap;
      }
    } else if (bottomLeft && bottomRight) {
      height -= gap;
      if (topLeft) {
        left += gap;
        width -= gap;
      } else if (topRight) {
        width -= gap;
      }
    } else if (topLeft && bottomLeft) {
      left += gap;
      width -= gap;
      if (topRight) {
        top += gap;
        height -= gap;
      } else if (bottomRight) {
        height -= gap;
      }
    } else if (topRight && bottomRight) {
      width -= gap;
      if (topLeft) {
        top += gap;
        height -= gap;
      } else if (bottomLeft) {
        height -= gap;
      }
    } else if (allLeft && allRight) {
      left += gap;
      width -= gap * 2;
      if (allTop) {
        top += gap;
        height -= gap;
      } else if (allBottom) {
        height -= gap;
      }
    } else if (allTop && allBottom) {
      top += gap;
      height -= gap * 2;
      if (allLeft) {
        left += gap;
        width -= gap;
      } else if (allRight) {
        width -= gap;
      }
    }
    return GroupPositioned.fromRect(
      rect: Rect.fromLTWH(
        left,
        top,
        width,
        height,
      ),
      child: _SnapHover(
        topLeft: topLeft || allLeft || allTop,
        topRight: topRight || allRight || allTop,
        bottomLeft: bottomLeft || allLeft || allBottom,
        bottomRight: bottomRight || allRight || allBottom,
        hovering: (value) {
          if (value) {
            _snappingStrategy.value = snapStrategy;
          }
        },
      ),
    );
  }

  @override
  void focusWindow(Window window) {
    if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
      _topWindows.remove(window);
      _topWindows.insert(0, window);
      _focusLayer = 2;
    } else {
      _windows.remove(window);
      _windows.insert(0, window);
      _focusLayer = 1;
    }
    setState(() {});
  }

  @override
  void pushWindow(Window window) {
    setState(() {
      if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
        _topWindows.insert(0, window);
      } else {
        _windows.insert(0, window);
      }
    });
  }

  @override
  void removeWindow(Window window) {
    setState(() {
      _windows.remove(window);
      _topWindows.remove(window);
    });
  }

  @override
  void setAlwaysOnTop(Window window, bool value) {
    if (value && _windows.contains(window)) {
      _windows.remove(window);
      _topWindows.add(window);
    } else if (!value && _topWindows.contains(window)) {
      _topWindows.remove(window);
      _windows.add(window);
    }
  }

  @override
  void unfocusWindow(Window window) {
    _focusLayer = 0;
  }
}
