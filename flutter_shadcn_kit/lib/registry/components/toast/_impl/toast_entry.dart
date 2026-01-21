part of '../toast.dart';

class ToastEntry extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration animationDuration;
  final Curve animationCurve;
  final VoidCallback onDismissed;

  const ToastEntry({
    super.key,
    required this.child,
    required this.duration,
    required this.animationDuration,
    required this.animationCurve,
    required this.onDismissed,
  });

  @override
  State<ToastEntry> createState() => _ToastEntryState();
}

class _ToastEntryState extends State<ToastEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _controller.forward();
    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().whenComplete(() {
          widget.onDismissed();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
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
