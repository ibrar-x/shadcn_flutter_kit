part of '../../accordion.dart';

/// An entry inside an [Accordion].
class AccordionItem extends StatefulWidget {
  /// Creates a collapsible accordion entry.
  const AccordionItem({
    super.key,
    required this.trigger,
    required this.content,
    this.expanded = false,
  });

  /// Widget that toggles the expansion state.
  final Widget trigger;

  /// Content revealed when the item is expanded.
  final Widget content;

  /// Whether the item should start expanded.
  final bool expanded;

  @override
/// Executes `createState` behavior for this component/composite.
  State<AccordionItem> createState() => _AccordionItemState();
}
