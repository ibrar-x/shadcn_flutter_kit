part of '../../hover.dart';


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
