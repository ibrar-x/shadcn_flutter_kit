import 'dart:async';

import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import '../utils/style_value.dart';

/// Theme configuration for hover-related widgets and behaviors.
class HoverTheme extends ComponentThemeData {
  /// Debounce duration for repeated hover events.
  final Duration? debounceDuration;

  /// Hit test behavior for hover detection.
  final HitTestBehavior? hitTestBehavior;

  /// Wait duration before showing hover feedback.
  final Duration? waitDuration;

  /// Minimum duration to keep hover feedback visible.
  final Duration? minDuration;

  /// Duration for hover feedback show animations.
  final Duration? showDuration;

  const HoverTheme({
    this.debounceDuration,
    this.hitTestBehavior,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
  });

  HoverTheme copyWith({
    ValueGetter<Duration?>? debounceDuration,
    ValueGetter<HitTestBehavior?>? hitTestBehavior,
    ValueGetter<Duration?>? waitDuration,
    ValueGetter<Duration?>? minDuration,
    ValueGetter<Duration?>? showDuration,
  }) {
    return HoverTheme(
      debounceDuration:
          debounceDuration == null ? this.debounceDuration : debounceDuration(),
      hitTestBehavior:
          hitTestBehavior == null ? this.hitTestBehavior : hitTestBehavior(),
      waitDuration: waitDuration == null ? this.waitDuration : waitDuration(),
      minDuration: minDuration == null ? this.minDuration : minDuration(),
      showDuration: showDuration == null ? this.showDuration : showDuration(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HoverTheme &&
        other.debounceDuration == debounceDuration &&
        other.hitTestBehavior == hitTestBehavior &&
        other.waitDuration == waitDuration &&
        other.minDuration == minDuration &&
        other.showDuration == showDuration;
  }

  @override
  int get hashCode => Object.hash(
        debounceDuration,
        hitTestBehavior,
        waitDuration,
        minDuration,
        showDuration,
      );
}

/// Tracks mouse hover state and triggers callbacks.
class HoverActivity extends StatefulWidget {
  final Widget child;
  final VoidCallback? onHover;
  final VoidCallback? onExit;
  final VoidCallback? onEnter;
  final Duration? debounceDuration;
  final HitTestBehavior? hitTestBehavior;

  const HoverActivity({
    super.key,
    required this.child,
    this.onHover,
    this.onExit,
    this.onEnter,
    this.hitTestBehavior,
    this.debounceDuration,
  });

  @override
  State<HoverActivity> createState() => _HoverActivityState();
}

class _HoverActivityState extends State<HoverActivity>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.debounceDuration,
    );
    _controller.addStatusListener(_onStatusChanged);
  }

  void _onStatusChanged(AnimationStatus status) {
    widget.onHover?.call();
  }

  @override
  void didUpdateWidget(covariant HoverActivity oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.debounceDuration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<HoverTheme>(context);
    final debounceDuration = styleValue(
        widgetValue: widget.debounceDuration,
        themeValue: compTheme?.debounceDuration,
        defaultValue: const Duration(milliseconds: 100));
    final behavior = styleValue(
        widgetValue: widget.hitTestBehavior,
        themeValue: compTheme?.hitTestBehavior,
        defaultValue: HitTestBehavior.deferToChild);
    _controller.duration = debounceDuration;
    return MouseRegion(
      hitTestBehavior: behavior,
      onEnter: (_) {
        widget.onEnter?.call();
        _controller.repeat(reverse: true);
      },
      onExit: (_) {
        _controller.stop();
        widget.onExit?.call();
      },
      child: widget.child,
    );
  }
}

/// Hover wrapper that controls delayed show/hide callbacks.
class Hover extends StatefulWidget {
  final Widget child;
  final Duration? waitDuration;
  final Duration? minDuration;
  final Duration? showDuration;
  final ValueChanged<bool>? onHover;

  const Hover({
    super.key,
    required this.child,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
    this.onHover,
  });

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  bool _hovered = false;
  bool _showed = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<HoverTheme>(context);
    final waitDuration = styleValue(
        widgetValue: widget.waitDuration,
        themeValue: compTheme?.waitDuration,
        defaultValue: const Duration(milliseconds: 300));
    final minDuration = styleValue(
        widgetValue: widget.minDuration,
        themeValue: compTheme?.minDuration,
        defaultValue: const Duration(milliseconds: 0));
    final showDuration = styleValue(
        widgetValue: widget.showDuration,
        themeValue: compTheme?.showDuration,
        defaultValue: const Duration(milliseconds: 150));

    return HoverActivity(
      hitTestBehavior: HitTestBehavior.deferToChild,
      onEnter: () {
        _hovered = true;
        _timer?.cancel();
        _timer = Timer(waitDuration, () {
          if (_hovered) {
            widget.onHover?.call(true);
            _showed = true;
          }
        });
      },
      onExit: () {
        _hovered = false;
        if (_showed) {
          _timer?.cancel();
          _timer = Timer(minDuration + showDuration, () {
            _showed = false;
            widget.onHover?.call(false);
          });
        }
      },
      child: widget.child,
    );
  }
}
