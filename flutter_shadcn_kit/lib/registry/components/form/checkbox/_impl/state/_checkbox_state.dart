part of '../../checkbox.dart';

class _CheckboxState extends State<Checkbox>
    with FormValueSupplier<CheckboxState, Checkbox> {
  final bool _focusing = false;
  bool _shouldAnimate = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.state;
  }

  void _changeTo(CheckboxState state) {
    if (widget.onChanged != null) {
      widget.onChanged!(state);
    }
  }

  void _tap() {
    if (widget.tristate) {
      switch (widget.state) {
        case CheckboxState.checked:
          _changeTo(CheckboxState.unchecked);
          break;
        case CheckboxState.unchecked:
          _changeTo(CheckboxState.indeterminate);
          break;
        case CheckboxState.indeterminate:
          _changeTo(CheckboxState.checked);
          break;
      }
    } else {
      _changeTo(
        widget.state == CheckboxState.checked
            ? CheckboxState.unchecked
            : CheckboxState.checked,
      );
    }
  }

  @override
  void didReplaceFormValue(CheckboxState value) {
    _changeTo(value);
  }

  @override
  void didUpdateWidget(covariant Checkbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      formValue = widget.state;
      _shouldAnimate = true;
    }
  }

  bool get enabled => widget.enabled ?? widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<CheckboxTheme>(context);
    final size = styleValue(
      widgetValue: widget.size,
      themeValue: compTheme?.size,
      defaultValue: 16 * scaling,
    );
    final gap = styleValue(
      widgetValue: widget.gap,
      themeValue: compTheme?.gap,
      defaultValue: 8 * scaling,
    );
    final backgroundColor = styleValue(
      widgetValue: widget.backgroundColor,
      themeValue: compTheme?.backgroundColor,
      defaultValue: theme.colorScheme.input.scaleAlpha(0.3),
    );
    final activeColor = styleValue(
      widgetValue: widget.activeColor,
      themeValue: compTheme?.activeColor,
      defaultValue: theme.colorScheme.primary,
    );
    final borderColor = styleValue(
      widgetValue: widget.borderColor,
      themeValue: compTheme?.borderColor,
      defaultValue: theme.colorScheme.border,
    );
    final borderRadius = styleValue<BorderRadiusGeometry>(
      widgetValue: widget.borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: BorderRadius.circular(theme.radiusSm),
    );
    return Clickable(
      enabled: widget.onChanged != null,
      mouseCursor: enabled
          ? const WidgetStatePropertyAll(SystemMouseCursors.click)
          : const WidgetStatePropertyAll(SystemMouseCursors.forbidden),
      onPressed: enabled ? _tap : null,
      enableFeedback: enabled,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) widget.leading!.small().medium(),
          SizedBox(width: gap),
          AnimatedContainer(
            duration: kDefaultDuration,
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: widget.state == CheckboxState.checked
                  ? activeColor
                  : backgroundColor,
              borderRadius:
                  optionallyResolveBorderRadius(context, borderRadius) ??
                  BorderRadius.circular(theme.radiusSm),
              border: Border.all(
                color: !enabled
                    ? theme.colorScheme.muted
                    : widget.state == CheckboxState.checked
                    ? activeColor
                    : borderColor,
                width: (_focusing ? 2 : 1) * scaling,
              ),
            ),
            child: widget.state == CheckboxState.checked
                ? Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      child: SizedBox(
                        width: scaling * 9,
                        height: scaling * 6.5,
                        child: AnimatedValueBuilder(
                          value: 1.0,
                          initialValue: _shouldAnimate ? 0.0 : null,
                          duration: const Duration(milliseconds: 300),
                          curve: const IntervalDuration(
                            start: Duration(milliseconds: 175),
                            duration: Duration(milliseconds: 300),
                          ),
                          builder: (context, value, child) {
                            return CustomPaint(
                              painter: AnimatedCheckPainter(
                                progress: value,
                                color: theme.colorScheme.primaryForeground,
                                strokeWidth: scaling * 1,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: widget.state == CheckboxState.indeterminate
                          ? scaling * 8
                          : 0,
                      height: widget.state == CheckboxState.indeterminate
                          ? scaling * 8
                          : 0,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(theme.radiusXs),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: gap),
          if (widget.trailing != null) widget.trailing!.small().medium(),
        ],
      ),
    );
  }
}
