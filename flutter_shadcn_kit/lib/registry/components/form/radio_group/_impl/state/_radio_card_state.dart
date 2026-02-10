part of '../../radio_group.dart';

class _RadioCardState<T> extends State<RadioCard<T>> {
  late FocusNode _focusNode;
  bool _focusing = false;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant RadioCard<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<RadioCardTheme>(context);
    final groupData = Data.maybeOf<RadioGroupData<T>>(context);
    final group = Data.maybeOf<RadioGroupState<T>>(context);
    assert(
      groupData != null,
      'RadioCard<$T> must be a descendant of RadioGroup<$T>',
    );
    return GestureDetector(
      onTap: widget.enabled && groupData?.enabled == true
          ? () {
              group?._setSelected(widget.value);
            }
          : null,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        actions: {
          NextItemIntent: CallbackAction<NextItemIntent>(
            onInvoke: (intent) {
              if (group != null) {
                group._setSelected(widget.value);
              }
              return null;
            },
          ),
          PreviousItemIntent: CallbackAction<PreviousItemIntent>(
            onInvoke: (intent) {
              if (group != null) {
                group._setSelected(widget.value);
              }
              return null;
            },
          ),
        },
        mouseCursor: widget.enabled && groupData?.enabled == true
            ? styleValue(
                defaultValue: SystemMouseCursors.click,
                themeValue: componentTheme?.enabledCursor,
              )
            : styleValue(
                defaultValue: SystemMouseCursors.forbidden,
                themeValue: componentTheme?.disabledCursor,
              ),
        onShowFocusHighlight: (value) {
          if (value && widget.enabled && groupData?.enabled == true) {
            group?._setSelected(widget.value);
          }
          if (value != _focusing) {
            setState(() {
              _focusing = value;
            });
          }
        },
        onShowHoverHighlight: (value) {
          if (value != _hovering) {
            setState(() {
              _hovering = value;
            });
          }
        },
        child: Data<RadioGroupData<T>>.boundary(
          child: Data<_RadioCardState<T>>.boundary(
            child: Card(
              borderColor: groupData?.selectedItem == widget.value
                  ? styleValue(
                      defaultValue: theme.colorScheme.primary,
                      themeValue: componentTheme?.selectedBorderColor,
                    )
                  : styleValue(
                      defaultValue: theme.colorScheme.muted,
                      themeValue: componentTheme?.borderColor,
                    ),
              borderWidth: groupData?.selectedItem == widget.value
                  ? styleValue(
                      defaultValue: 2 * theme.scaling,
                      themeValue: componentTheme?.selectedBorderWidth,
                    )
                  : styleValue(
                      defaultValue: 1 * theme.scaling,
                      themeValue: componentTheme?.borderWidth,
                    ),
              borderRadius: styleValue(
                defaultValue: theme.borderRadiusMd,
                themeValue: componentTheme?.borderRadius,
              ),
              padding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              duration: kDefaultDuration,
              fillColor: _hovering
                  ? styleValue(
                      defaultValue: theme.colorScheme.muted,
                      themeValue: componentTheme?.hoverColor,
                    )
                  : styleValue(
                      defaultValue: theme.colorScheme.background,
                      themeValue: componentTheme?.color,
                    ),
              child: Container(
                padding: styleValue(
                  defaultValue: EdgeInsets.all(
                    theme.density.baseContentPadding * theme.scaling,
                  ),
                  themeValue: componentTheme?.padding,
                ),
                child: AnimatedPadding(
                  duration: kDefaultDuration,
                  padding: groupData?.selectedItem == widget.value
                      ? styleValue(
                          defaultValue: EdgeInsets.zero,
                          themeValue: componentTheme?.borderWidth != null
                              ? EdgeInsets.all(componentTheme!.borderWidth!)
                              : null,
                        )
                      // to compensate for the border width
                      : styleValue(
                          defaultValue: EdgeInsets.all(1 * theme.scaling),
                          themeValue:
                              componentTheme?.borderWidth != null &&
                                  componentTheme?.selectedBorderWidth != null
                              ? EdgeInsets.all(
                                  componentTheme!.borderWidth! -
                                      componentTheme.selectedBorderWidth!,
                                )
                              : null,
                        ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
