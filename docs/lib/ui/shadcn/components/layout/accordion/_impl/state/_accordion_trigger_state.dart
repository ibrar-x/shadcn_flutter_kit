part of '../../accordion.dart';

class _AccordionTriggerState extends State<AccordionTrigger> {
  bool _expanded = false;
  bool _hovering = false;
  bool _focusing = false;
  _AccordionItemState? _item;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newItem = Data.of<_AccordionItemState>(context);
    if (newItem != _item) {
      _item?._expanded.removeListener(_onExpandedChanged);
      newItem._expanded.addListener(_onExpandedChanged);
      _item = newItem;
    }
  }

  void _onExpandedChanged() {
    if (_expanded != (_item?._expanded.value ?? false)) {
      setState(() {
        _expanded = _item?._expanded.value ?? false;
      });
    }
  }

  @override
  void dispose() {
    _item?._expanded.removeListener(_onExpandedChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accTheme = ComponentTheme.maybeOf<AccordionTheme>(context);
    final scaling = theme.scaling;

    final arrowColor =
        accTheme?.arrowIconColor ?? theme.colorScheme.mutedForeground;
    final baseIconSize = theme.iconTheme.medium.size ??
        theme.iconTheme.small.size ??
        theme.iconTheme.xSmall.size ??
        (20 * scaling);

    final tween = _expanded
        ? Tween<double>(begin: 1.0, end: 0.0)
        : Tween<double>(begin: 0.0, end: 1.0);

    return GestureDetector(
      onTap: _item?._dispatchToggle,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowFocusHighlight: (value) {
          setState(() {
            _focusing = value;
          });
        },
        onShowHoverHighlight: (value) {
          setState(() {
            _hovering = value;
          });
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction(
            onInvoke: (intent) {
              _item?._dispatchToggle();
              return true;
            },
          ),
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _focusing
                  ? theme.colorScheme.ring
                  : theme.colorScheme.ring.withAlpha(0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(theme.radiusXs),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: accTheme?.padding ?? 16 * scaling,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: DefaultTextStyle.merge(
                      style: TextStyle(
                        decoration: _hovering
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                      child: widget.child,
                    ),
                  ),
                ),
                SizedBox(width: accTheme?.iconGap ?? 18 * scaling),
                TweenAnimationBuilder<double>(
                  tween: tween,
                  duration: accTheme?.duration ?? kDefaultDuration,
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value * pi,
                      child: IconTheme(
                        data: IconThemeData(
                          color: arrowColor,
                          size: baseIconSize,
                        ),
                        child: Icon(
                            accTheme?.arrowIcon ?? Icons.keyboard_arrow_up),
                      ),
                    );
                  },
                ),
              ],
            ),
          ).medium().small(),
        ),
      ),
    );
  }
}
