part of '../../radio_group.dart';

class _RadioItemState<T> extends State<RadioItem<T>> {
  late FocusNode _focusNode;

  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant RadioItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groupData = Data.maybeOf<RadioGroupData<T>>(context);
    final group = Data.maybeOf<RadioGroupState<T>>(context);
    assert(groupData != null,
        'RadioItem<$T> must be a descendant of RadioGroup<$T>');
    return GestureDetector(
      onTap: widget.enabled && groupData?.enabled == true
          ? () {
              group?._setSelected(widget.value);
            }
          : null,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        mouseCursor: widget.enabled && groupData?.enabled == true
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
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
        child: Data<RadioGroupData<T>>.boundary(
          child: Data<_RadioItemState<T>>.boundary(
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.leading != null) widget.leading!,
                  if (widget.leading != null)
                    SizedBox(width: 8 * theme.scaling),
                  Radio(
                      value: groupData?.selectedItem == widget.value,
                      focusing:
                          _focusing && groupData?.selectedItem == widget.value),
                  if (widget.trailing != null)
                    SizedBox(width: 8 * theme.scaling),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
