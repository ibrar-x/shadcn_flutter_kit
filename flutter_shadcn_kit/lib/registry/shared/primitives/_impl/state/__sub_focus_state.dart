part of '../../subfocus.dart';


class _SubFocusState extends State<SubFocus> with SubFocusState {
  SubFocusScopeState? _scope;
  bool _focused = false;
  bool _active = true;
  int _focusCount = 0;

  @override
  int get focusCount => _focusCount;

  @override
  bool unfocus() {
    return _scope?.unfocus(this) ?? false;
  }

  @override
  void activate() {
    super.activate();
    _active = true;
  }

  @override
  void deactivate() {
    _active = false;
    super.deactivate();
  }

  @override
  void didUpdateWidget(covariant SubFocus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        _focused = _scope?.attach(this) ?? false;
      } else {
        _focused = false;
        _scope?.detach(this);
      }
    }
  }

  @override
  Object? invokeAction(Intent intent) {
    return Actions.invoke(context, intent);
  }

  @override
  void ensureVisible(
      {ScrollPositionAlignmentPolicy alignmentPolicy =
          ScrollPositionAlignmentPolicy.explicit}) {
    if (!mounted || !_active) return;
    Scrollable.ensureVisible(
      context,
      alignmentPolicy: alignmentPolicy,
    );
  }

  @override
  bool requestFocus() {
    if (!mounted || !_active) return false;
    if (_scope != null) {
      return _scope!.requestFocus(this);
    }
    return false;
  }

  @override
  bool get isFocused => _focused && widget.enabled;

  @override
  RenderBox? findRenderObject() {
    if (!mounted || !_active) {
      return null;
    }
    return context.findRenderObject() as RenderBox?;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newScope = Data.maybeOf<SubFocusScopeState>(context);
    if (newScope != _scope) {
      _focusCount = 0;
      _scope?.detach(this);
      _scope = newScope;
      if (widget.enabled) {
        _focused = _scope?.attach(this) ?? false;
      }
    }
  }

  @override
  void dispose() {
    _scope?.detach(this);
    super.dispose();
  }

  @override
  void markFocused(bool focus) {
    if (!mounted || !_active) {
      return;
    }
    setState(() {
      if (focus) {
        _focusCount++;
      }
      _focused = focus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, this);
  }
}
