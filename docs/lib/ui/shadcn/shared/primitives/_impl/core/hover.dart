part of '../../hover.dart';

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
