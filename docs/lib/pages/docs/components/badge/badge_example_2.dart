import 'package:docs/shadcn_ui.dart';

/// Secondary badge style.
///
/// Use `SecondaryBadge` for a lighter emphasis compared to primary.
class BadgeExample2 extends StatelessWidget {
  const BadgeExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SecondaryBadge(
      child: Text('Secondary'),
    );
  }
}
