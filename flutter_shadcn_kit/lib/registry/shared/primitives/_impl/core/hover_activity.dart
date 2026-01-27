part of '../../hover.dart';

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
