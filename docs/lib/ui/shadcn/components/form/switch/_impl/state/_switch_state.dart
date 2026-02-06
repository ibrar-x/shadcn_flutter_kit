part of '../../switch.dart';

class _SwitchState extends State<Switch> with FormValueSupplier<bool, Switch> {
  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void didUpdateWidget(covariant Switch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(bool value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<SwitchTheme>(context);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 8 * scaling);
    final activeColor = styleValue(
        widgetValue: widget.activeColor,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final inactiveColor = styleValue(
        widgetValue: widget.inactiveColor,
        themeValue: compTheme?.inactiveColor,
        defaultValue: theme.colorScheme.input);
    final activeThumbColor = styleValue(
        widgetValue: widget.activeThumbColor,
        themeValue: compTheme?.activeThumbColor,
        defaultValue: theme.colorScheme.background);
    final inactiveThumbColor = styleValue(
        widgetValue: widget.inactiveThumbColor,
        themeValue: compTheme?.inactiveThumbColor,
        defaultValue: theme.colorScheme.foreground);
    final borderRadius = styleValue<BorderRadiusGeometry>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusXl));
    return FocusOutline(
      focused: _focusing && _enabled,
      borderRadius: optionallyResolveBorderRadius(context, borderRadius) ??
          BorderRadius.circular(theme.radiusXl),
      child: GestureDetector(
        onTap: _enabled
            ? () {
                widget.onChanged?.call(!widget.value);
              }
            : null,
        child: FocusableActionDetector(
          enabled: _enabled,
          onShowFocusHighlight: (value) {
            setState(() {
              _focusing = value;
            });
          },
          actions: {
            ActivateIntent: CallbackAction(
              onInvoke: (Intent intent) {
                widget.onChanged?.call(!widget.value);
                return true;
              },
            ),
          },
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          },
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leading != null) widget.leading!,
              if (widget.leading != null) SizedBox(width: gap),
              AnimatedContainer(
                duration: kSwitchDuration,
                width: (32 + 4) * scaling,
                height: (16 + 4) * scaling,
                padding: EdgeInsets.all(2 * scaling),
                decoration: BoxDecoration(
                  borderRadius:
                      optionallyResolveBorderRadius(context, borderRadius) ??
                          BorderRadius.circular(theme.radiusXl),
                  color: !_enabled
                      ? theme.colorScheme.muted
                      : widget.value
                          ? activeColor
                          : inactiveColor,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: kSwitchDuration,
                      curve: Curves.easeInOut,
                      left: widget.value ? 16 * scaling : 0,
                      top: 0,
                      bottom: 0,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(theme.radiusLg),
                            color: !_enabled
                                ? theme.colorScheme.mutedForeground
                                : widget.value
                                    ? activeThumbColor
                                    : inactiveThumbColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null) SizedBox(width: gap),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
