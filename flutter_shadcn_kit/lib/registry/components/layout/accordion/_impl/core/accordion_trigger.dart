part of '../../accordion.dart';

/// Tappable header that controls its parent [AccordionItem].
class AccordionTrigger extends StatefulWidget {
  /// Creates a trigger for the accordion section.
  const AccordionTrigger({super.key, required this.child});

  /// Content displayed inside the trigger row.
  final Widget child;

  @override
/// Executes `createState` behavior for this component/composite.
  State<AccordionTrigger> createState() => _AccordionTriggerState();
}
