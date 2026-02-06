part of '../../accordion.dart';

class _AccordionItemState extends State<AccordionItem>
    with SingleTickerProviderStateMixin {
  AccordionState? accordion;
  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  late AnimationController _controller;
  late CurvedAnimation _easeInAnimation;
  AccordionTheme? _theme;

  @override
  void initState() {
    super.initState();
    _expanded.value = widget.expanded;
    _controller = AnimationController(vsync: this);
    _updateAnimations();
  }

  void _updateAnimations() {
    _controller.duration = _theme?.duration ?? const Duration(milliseconds: 200);
    _controller.value = _expanded.value ? 1 : 0;
    _easeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: _theme?.curve ?? Curves.easeIn,
      reverseCurve: _theme?.reverseCurve ?? Curves.easeOut,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newAccordion = Data.of<AccordionState>(context);
    if (newAccordion != accordion) {
      accordion?._expanded.removeListener(_onExpandedChanged);
      newAccordion._expanded.addListener(_onExpandedChanged);
      accordion = newAccordion;
    }

    final theme = ComponentTheme.maybeOf<AccordionTheme>(context);
    if (_theme != theme) {
      _theme = theme;
      _updateAnimations();
    }

    if (accordion != null && accordion!._expanded.value == null && widget.expanded) {
      accordion!._expanded.value = this;
    }
    _onExpandedChanged();
  }

  @override
  void dispose() {
    _controller.dispose();
    accordion?._expanded.removeListener(_onExpandedChanged);
    super.dispose();
  }

  void _onExpandedChanged() {
    final shouldBeExpanded = accordion?._expanded.value == this;
    if (_expanded.value != shouldBeExpanded) {
      setState(() {
        _expanded.value = shouldBeExpanded;
        if (shouldBeExpanded) {
          _expand();
        } else {
          _collapse();
        }
      });
    }
  }

  void _expand() {
    _controller.forward();
    _expanded.value = true;
  }

  void _collapse() {
    _controller.reverse();
    _expanded.value = false;
  }

  void _dispatchToggle() {
    if (accordion?._expanded.value == this) {
      accordion?._expanded.value = null;
    } else {
      accordion?._expanded.value = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    return Data.inherit(
      data: this,
      child: GestureDetector(
        child: Column(
          children: [
            widget.trigger,
            SizeTransition(
              key: const ValueKey('accordion_size_transition'),
              sizeFactor: _easeInAnimation,
              axisAlignment: -1,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: _theme?.padding ?? 16 * scaling,
                ),
                child: widget.content,
              ).small().normal(),
            ),
          ],
        ),
      ),
    );
  }
}
