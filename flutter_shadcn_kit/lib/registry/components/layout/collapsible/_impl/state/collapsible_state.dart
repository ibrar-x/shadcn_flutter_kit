part of '../../collapsible.dart';

class CollapsibleState extends State<Collapsible> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded ?? false;
  }

  @override
  void didUpdateWidget(covariant Collapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != null) {
      _isExpanded = widget.isExpanded!;
    }
  }

  void _handleTap() {
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<CollapsibleTheme>(context);

    return Data.inherit(
      data: CollapsibleStateData(
        isExpanded: _isExpanded,
        handleTap: _handleTap,
      ),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment:
              compTheme?.crossAxisAlignment ?? CrossAxisAlignment.stretch,
          mainAxisAlignment:
              compTheme?.mainAxisAlignment ?? MainAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}
