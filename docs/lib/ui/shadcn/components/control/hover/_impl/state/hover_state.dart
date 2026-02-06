import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/style_value.dart';
import '../themes/hover_theme.dart';
import '../core/hover_widget.dart';

class HoverState extends State<Hover> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? _enterTime;
  late Duration _waitDur;
  late Duration _minDur;
  late Duration _showDur;
  late HitTestBehavior _behavior;

  @override
  void initState() {
    super.initState();
    _waitDur = widget.waitDuration ?? const Duration(milliseconds: 500);
    _minDur = widget.minDuration ?? const Duration(milliseconds: 0);
    _showDur = widget.showDuration ?? const Duration(milliseconds: 200);
    _controller = AnimationController(
      vsync: this,
      duration: _waitDur,
    );
    _controller.addStatusListener(_onStatusChanged);
  }

  void _onEnter() {
    _enterTime = DateTime.now().millisecondsSinceEpoch;
    _controller.forward();
  }

  void _onExit(bool cursorOut) {
    int minDuration = _minDur.inMilliseconds;
    int? enterTime = _enterTime;
    if (enterTime != null) {
      int duration = DateTime.now().millisecondsSinceEpoch - enterTime;
      _controller.reverseDuration = cursorOut
          ? Duration(milliseconds: duration < minDuration ? minDuration : 0)
          : _showDur;
      _controller.reverse();
    }
    _enterTime = null;
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onHover(true);
    } else if (status == AnimationStatus.dismissed) {
      widget.onHover(false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final compTheme = ComponentTheme.maybeOf<HoverTheme>(context);
    _waitDur = styleValue(
        widgetValue: widget.waitDuration,
        themeValue: compTheme?.waitDuration,
        defaultValue: const Duration(milliseconds: 500));
    _minDur = styleValue(
        widgetValue: widget.minDuration,
        themeValue: compTheme?.minDuration,
        defaultValue: const Duration(milliseconds: 0));
    _showDur = styleValue(
        widgetValue: widget.showDuration,
        themeValue: compTheme?.showDuration,
        defaultValue: const Duration(milliseconds: 200));
    _behavior = styleValue(
        widgetValue: widget.hitTestBehavior,
        themeValue: compTheme?.hitTestBehavior,
        defaultValue: HitTestBehavior.deferToChild);
    _controller.duration = _waitDur;
    bool enableLongPress = platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    return TapRegion(
      behavior: _behavior,
      onTapOutside: (details) {
        _onExit(true);
      },
      child: MouseRegion(
        hitTestBehavior: _behavior,
        onEnter: (_) => _onEnter(),
        onExit: (_) {
          _onExit(true);
        },
        child: GestureDetector(
          // for mobile platforms, hover is triggered by a long press
          onLongPressDown: enableLongPress
              ? (details) {
                  _onEnter();
                }
              : null,
          onLongPressCancel: enableLongPress
              ? () {
                  _onExit(true);
                }
              : null,
          onLongPressUp: enableLongPress
              ? () {
                  _onExit(true);
                }
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}
