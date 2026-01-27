part of 'control.dart';

class _ControlledComponentAdapterState<T>
    extends State<ControlledComponentAdapter<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    T? value = widget.controller?.value ?? widget.initialValue;
    assert(value != null, 'Either controller or initialValue must be provided');
    _value = value as T;
    widget.controller?.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {
      _value = widget.controller!.value;
    });
  }

  @override
  void didUpdateWidget(covariant ControlledComponentAdapter<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);
    }
  }

  void _onChanged(T value) {
    widget.onChanged?.call(value);
    final controller = widget.controller;
    if (controller != null) {
      controller.value = value;
    } else {
      setState(() {
        _value = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      ControlledComponentData(
        value: _value,
        onChanged: _onChanged,
        enabled: widget.enabled,
      ),
    );
  }
}
