import 'package:docs/ui/shadcn/shadcn_ui.dart';

/// Collapsible list with a trigger and multiple content sections.
///
/// The first item is a [CollapsibleTrigger] that toggles visibility of
/// subsequent [CollapsibleContent] sections.
class CollapsibleExample1 extends StatelessWidget {
  const CollapsibleExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Collapsible(
      children: [
        const CollapsibleTrigger(
          child: Text('@mibrar starred 3 repositories'),
        ),
        OutlinedContainer(
          child: const Text('@ibrar-x/shadcn_flutter_kit')
              .small()
              .mono()
              .withPadding(horizontal: 16, vertical: 8),
        ).withPadding(top: 8),
        CollapsibleContent(
          child: OutlinedContainer(
            child: const Text('@flutter/flutter')
                .small()
                .mono()
                .withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
        CollapsibleContent(
          child: OutlinedContainer(
            child: const Text('@dart-lang/sdk')
                .small()
                .mono()
                .withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
      ],
    );
  }
}
