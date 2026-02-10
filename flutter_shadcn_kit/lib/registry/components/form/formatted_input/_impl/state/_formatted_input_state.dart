part of '../../formatted_input.dart';

class _FormattedInputState extends State<FormattedInput> {
  final FormController _controller = FormController();
  bool _hasFocus = false;
  FormattedValue? _value;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? widget.controller?.value;
    _controller.addListener(_notifyChanged);
    int partIndex = 0;
    if (_value != null) {
      for (var part in _value!.parts) {
        if (part.part.canHaveValue) {
          partIndex++;
        }
      }
    }
    _focusNodes = _allocateFocusNodes(partIndex);
  }

  List<FocusNode> _allocateFocusNodes(
    int newLength, [
    List<FocusNode>? oldNodes,
  ]) {
    if (oldNodes == null) {
      return List.generate(newLength, (index) => FocusNode());
    }
    if (newLength == oldNodes.length) {
      return oldNodes;
    }
    if (newLength < oldNodes.length) {
      for (var i = newLength; i < oldNodes.length; i++) {
        oldNodes[i].dispose();
      }
      return oldNodes.sublist(0, newLength);
    }
    return [
      ...oldNodes,
      ...List.generate(newLength - oldNodes.length, (index) => FocusNode()),
    ];
  }

  Widget _buildPart(int index, InputPart part) {
    var formattedInputData = FormattedInputData(
      partIndex: index,
      initialValue: index < 0 ? null : (_value?[index]?.value ?? ''),
      enabled: widget.enabled,
      controller: widget.controller,
      focusNode: index < 0 ? null : _focusNodes[index],
      focusNodes: _focusNodes,
    );
    return part.build(context, formattedInputData);
  }

  bool _updating = false;
  void _notifyChanged() {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      List<FormattedValuePart> parts = [];
      var values = _controller.values;
      var value = _value;
      if (value != null) {
        int partIndex = 0;
        for (var i = 0; i < value.parts.length; i++) {
          var part = value.parts[i];
          if (part.part.canHaveValue) {
            FormKey key = FormKey(partIndex);
            var val = values[key];
            parts.add(part.withValue(val as String? ?? ''));
            partIndex++;
          } else {
            parts.add(part);
          }
        }
        _focusNodes = _allocateFocusNodes(partIndex, _focusNodes);
      } else {
        _focusNodes = _allocateFocusNodes(0, _focusNodes);
      }
      var newValue = FormattedValue(parts);
      if (widget.onChanged != null && newValue != _value) {
        widget.onChanged!(newValue);
      }
    } finally {
      _updating = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> children = [];
    if (_value != null) {
      int partIndex = 0;
      for (var part in _value!.parts) {
        if (part.part.canHaveValue) {
          children.add(_buildPart(partIndex, part.part));
          partIndex++;
        } else {
          children.add(_buildPart(-1, part.part));
        }
      }
    }
    final compTheme = ComponentTheme.maybeOf<FormattedInputTheme>(context);
    return SizedBox(
      height: (compTheme?.height ?? kTextFieldHeight) * theme.scaling, // 32 + 2
      child: TextFieldTapRegion(
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _hasFocus = hasFocus;
            });
          },
          child: FocusOutline(
            focused: _hasFocus,
            borderRadius: theme.borderRadiusMd,
            child: OutlinedContainer(
              borderRadius: theme.borderRadiusMd,
              borderColor: theme.colorScheme.border,
              backgroundColor: theme.colorScheme.input.scaleAlpha(0.3),
              padding:
                  compTheme?.padding ??
                  EdgeInsets.symmetric(
                    horizontal: theme.density.baseGap * theme.scaling * 0.75,
                  ),
              child: Form(
                controller: _controller,
                child: FocusTraversalGroup(
                  policy: WidgetOrderTraversalPolicy(),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.leading != null) widget.leading!,
                        ...children,
                        if (widget.trailing != null) widget.trailing!,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
