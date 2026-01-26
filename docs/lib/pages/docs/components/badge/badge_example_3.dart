import 'package:docs/ui/shadcn/shadcn_ui.dart';

/// Outline badge style.
///
/// Outlined appearance for a more subtle badge.
class BadgeExample3 extends StatelessWidget {
  const BadgeExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const OutlineBadge(
      child: Text('Outline'),
    );
  }
}
