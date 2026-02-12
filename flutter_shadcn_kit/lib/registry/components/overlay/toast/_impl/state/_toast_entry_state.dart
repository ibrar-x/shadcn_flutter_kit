part of '../../toast.dart';

/// _ToastEntryState defines a reusable type for this registry module.
class _ToastEntryState extends State<ToastEntry>
    with SingleTickerProviderStateMixin {
/// Stores `_controller` state/configuration for this implementation.
  late AnimationController _controller;

  @override
/// Executes `initState` behavior for this component/composite.
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _controller.forward();
/// Creates a `Future.delayed` instance.
    Future.delayed(widget.duration, () {
      if (mounted) {
/// Creates a `_controller.reverse` instance.
        _controller.reverse().whenComplete(() {
          widget.onDismissed();
        });
      }
    });
  }

  @override
/// Executes `dispose` behavior for this component/composite.
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
      child: widget.child,
    );
  }
}
