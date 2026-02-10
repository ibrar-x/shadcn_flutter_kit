part of '../../formatted_input.dart';

class _EditablePartWidgetState extends State<_EditablePartWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _EditablePartController(
      maxLength: widget.length,
      hasPlaceholder: widget.placeholder != null,
      text: widget.data.initialValue,
    );
    _controller.addListener(_onTextChanged);
    if (widget.data.controller != null) {
      widget.data.controller!.addListener(_onFormattedInputControllerChange);
    }
  }

  void _onTextChanged() {
    if (_updating) return;
    _updating = true;
    try {
      if (widget.data.controller != null) {
        var value = widget.data.controller!.value;
        var parts = List<FormattedValuePart>.from(value.parts);
        int valueIndex = 0;
        for (int i = 0; i < parts.length; i++) {
          if (parts[i].part.canHaveValue) {
            if (valueIndex == widget.data.partIndex) {
              parts[i] = parts[i].withValue(_controller.text);
              break;
            }
            valueIndex++;
          }
        }
        widget.data.controller!.value = FormattedValue(parts);
      }
    } finally {
      _updating = false;
    }
  }

  bool _updating = false;
  void _onFormattedInputControllerChange() {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      if (widget.data.controller != null) {
        var value = widget.data.controller!.value;
        var part = value.values.elementAt(widget.data.partIndex);
        String newText = part.value ?? '';
        if (_controller.text != newText) {
          _controller.value = _controller.value.replaceText(newText);
        }
      }
    } finally {
      _updating = false;
    }
  }

  @override
  void didUpdateWidget(covariant _EditablePartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      final oldValue = _controller.value;
      _controller = _EditablePartController(
        maxLength: widget.length,
        hasPlaceholder: widget.placeholder != null,
        text: oldValue.text,
      );
    } else if (widget.data.initialValue != oldWidget.data.initialValue) {
      // Update text if initialValue changes externally
      if (_controller.text != widget.data.initialValue) {
        _controller.text = widget.data.initialValue ?? '';
      }
    }
    if (oldWidget.data.controller != widget.data.controller) {
      if (oldWidget.data.controller != null) {
        oldWidget.data.controller!.removeListener(
          _onFormattedInputControllerChange,
        );
      }
      if (widget.data.controller != null) {
        widget.data.controller!.addListener(_onFormattedInputControllerChange);
      }
    }
  }

  @override
  void dispose() {
    if (widget.data.controller != null) {
      widget.data.controller!.removeListener(_onFormattedInputControllerChange);
    }
    super.dispose();
  }

  FormattedInputData get data => widget.data;

  void _onChanged(String value) {
    int length = value.length;
    if (length >= widget.length) {
      _nextFocus();
    }
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == 0) {
          _previousFocus();
          return KeyEventResult.handled;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == 0) {
          _previousFocus();
          return KeyEventResult.handled;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == _controller.text.length) {
          _nextFocus();
          return KeyEventResult.handled;
        }
      }
    }
    return KeyEventResult.ignored;
  }

  void _nextFocus() {
    int nextIndex = data.partIndex + 1;
    if (nextIndex < data.focusNodes.length) {
      FocusNode nextNode = data.focusNodes[nextIndex];
      nextNode.requestFocus();
    }
  }

  void _previousFocus() {
    int nextIndex = data.partIndex - 1;
    if (nextIndex >= 0) {
      FocusNode nextNode = data.focusNodes[nextIndex];
      nextNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Focus(
      onKeyEvent: _onKeyEvent,
      child: FormEntry(
        key: TextFieldKey(data.partIndex),
        child: SizedBox(
          width: widget.width,
          child: ComponentTheme(
            data: const FocusOutlineTheme(
              border: Border.fromBorderSide(BorderSide.none),
            ),
            child: TextField(
              focusNode: data.focusNode,
              controller: _controller,
              maxLength: widget.length,
              onChanged: _onChanged,
              decoration: const BoxDecoration(),
              style: DefaultTextStyle.of(
                context,
              ).style.merge(theme.typography.mono),
              border: const Border.fromBorderSide(BorderSide.none),
              textAlign: TextAlign.center,
              initialValue: data.initialValue,
              maxLines: 1,
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              placeholder: widget.placeholder,
              padding: EdgeInsets.symmetric(
                horizontal: theme.density.baseGap * theme.scaling * 0.75,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
