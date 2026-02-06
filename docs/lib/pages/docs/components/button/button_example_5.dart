import 'package:docs/shadcn_ui.dart';

/// Destructive button.
///
/// Use to represent dangerous or irreversible actions (e.g., delete).
class ButtonExample5 extends StatelessWidget {
  const ButtonExample5({super.key});

  @override
  Widget build(BuildContext context) {
    return DestructiveButton(
      onPressed: () {},
      child: const Text('Destructive'),
    );
  }
}
