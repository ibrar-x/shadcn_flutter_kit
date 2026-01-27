part of '../../accordion.dart';

class AccordionState extends State<Accordion> {
  final ValueNotifier<_AccordionItemState?> _expanded = ValueNotifier(null);

  @override
  void dispose() {
    _expanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final accTheme = ComponentTheme.maybeOf<AccordionTheme>(context);
    final dividerColor = accTheme?.dividerColor ?? theme.colorScheme.muted;
    final dividerHeight = accTheme?.dividerHeight ?? 1 * scaling;

    final children = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      children.add(widget.items[i]);
      if (i < widget.items.length - 1) {
        children.add(Container(
          color: dividerColor,
          height: dividerHeight,
        ));
      }
    }
    children.add(const Divider());

    return Data.inherit(
      data: this,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
