part of '../../window.dart';

class _SnapHoverState extends State<_SnapHover> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
          widget.hovering(true);
        });
      },
      onHover: (_) {
        setState(() {
          _hovering = true;
          widget.hovering(true);
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
          widget.hovering(false);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _hovering
              ? theme.colorScheme.secondary
              : theme.colorScheme.card,
          border: Border.all(color: theme.colorScheme.border),
          borderRadius: BorderRadius.only(
            topLeft: widget.topLeft
                ? theme.radiusSmRadius
                : theme.radiusLgRadius,
            topRight: widget.topRight
                ? theme.radiusSmRadius
                : theme.radiusLgRadius,
            bottomLeft: widget.bottomLeft
                ? theme.radiusSmRadius
                : theme.radiusLgRadius,
            bottomRight: widget.bottomRight
                ? theme.radiusSmRadius
                : theme.radiusLgRadius,
          ),
        ),
      ),
    );
  }
}
