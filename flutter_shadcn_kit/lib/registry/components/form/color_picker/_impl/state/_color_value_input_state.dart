part of '../../color_picker.dart';

class _ColorValueInputState extends State<_ColorValueInput> {
  late TextEditingController _controller;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant _ColorValueInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !_focused) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() {
          _focused = focused;
        });
      },
      child: TextField(
        placeholder: widget.placeholder,
        keyboardType: widget.keyboardType,
        controller: _controller,
        onChanged: widget.onChanged != null
            ? (val) {
                if (_focused) {
                  widget.onChanged!(val);
                }
              }
            : null,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
