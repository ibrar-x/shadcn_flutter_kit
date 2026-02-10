import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../utils/desktop_pointer_scroll_event.dart';
import '../core/scroll_view_interceptor.dart';

const double kScrollDragSpeed = 0.02;
const double kMaxScrollSpeed = 10.0;

class ScrollViewInterceptorState extends State<ScrollViewInterceptor>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Duration? _lastTime;
  PointerDownEvent? _event;
  Offset? _lastOffset;
  MouseCursor? _cursor;
  bool pointerMoved = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    Duration delta = _lastTime == null ? Duration.zero : elapsed - _lastTime!;
    _lastTime = elapsed;
    if (delta.inMilliseconds == 0) return;
    Offset positionDelta = _event!.position - _lastOffset!;
    double incX =
        pow(-positionDelta.dx * kScrollDragSpeed, 3) / delta.inMilliseconds;
    double incY =
        pow(-positionDelta.dy * kScrollDragSpeed, 3) / delta.inMilliseconds;
    incX = incX.clamp(-kMaxScrollSpeed, kMaxScrollSpeed);
    incY = incY.clamp(-kMaxScrollSpeed, kMaxScrollSpeed);
    var instance = GestureBinding.instance;
    HitTestResult result = HitTestResult();
    instance.hitTestInView(result, _event!.position, _event!.viewId);
    var pointerScrollEvent = DesktopPointerScrollEvent(
      position: _event!.position,
      device: _event!.device,
      embedderId: _event!.embedderId,
      kind: _event!.kind,
      timeStamp: Duration(milliseconds: DateTime.now().millisecondsSinceEpoch),
      viewId: _event!.viewId,
      scrollDelta: Offset(incX, incY),
    );
    for (final path in result.path) {
      try {
        path.target.handleEvent(pointerScrollEvent, path);
      } catch (e, s) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: e,
            stack: s,
            library: 'shadcn_flutter',
            context: ErrorDescription(
              'while dispatching a pointer scroll event',
            ),
          ),
        );
      }
    }
  }

  void _activate(PointerDownEvent event) {
    _event = event;
    _lastOffset = event.position;
    _lastTime = null;
    _ticker.start();
    setState(() {
      _cursor = SystemMouseCursors.allScroll;
    });
  }

  void _deactivate() {
    _ticker.stop();
    _lastTime = null;
    _event = null;
    _lastOffset = null;
    setState(() {
      _cursor = null;
    });
  }

  void _toggleScrollMode(PointerDownEvent event) {
    if (_ticker.isActive) {
      _deactivate();
    } else if (event.buttons == kMiddleMouseButton) {
      _activate(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        Listener(
          onPointerDown: (event) {
            pointerMoved = false;
            _toggleScrollMode(event);
          },
          onPointerUp: (event) {
            if (_ticker.isActive && pointerMoved) {
              _deactivate();
            }
          },
          onPointerMove: (event) {
            if (_ticker.isActive) {
              pointerMoved = true;
              _lastOffset = event.position;
            }
          },
          child: widget.child,
        ),
        if (_cursor != null)
          Positioned.fill(
            child: MouseRegion(
              onHover: (event) => {_lastOffset = event.position},
              cursor: _cursor!,
              hitTestBehavior: HitTestBehavior.translucent,
            ),
          ),
      ],
    );
  }
}
