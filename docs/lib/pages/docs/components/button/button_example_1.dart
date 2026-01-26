import 'package:docs/ui/shadcn/shadcn_ui.dart';

/// Primary button.
///
/// Use for the main call-to-action on a screen.
class ButtonExample1 extends StatelessWidget {
  const ButtonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {},
      child: const Text('Primary'),
    );
  }
}
