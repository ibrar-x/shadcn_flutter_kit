import 'package:docs/shadcn_ui.dart';

/// Primary badge style.
///
/// Badges are small, attention-grabbing labels. Use `PrimaryBadge` for the
/// default emphasis.
class BadgeExample1 extends StatelessWidget {
  const BadgeExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimaryBadge(
      child: Text('Primary'),
    );
  }
}
