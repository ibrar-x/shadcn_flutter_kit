part of '../../window.dart';

class _SnapHover extends StatefulWidget {
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;
  final ValueChanged<bool> hovering;

  const _SnapHover({
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
    required this.hovering,
  });

  @override
  State<_SnapHover> createState() => _SnapHoverState();
}
