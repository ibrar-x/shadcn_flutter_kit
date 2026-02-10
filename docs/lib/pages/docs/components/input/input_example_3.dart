import 'package:docs/shadcn_ui.dart';
import '../../../../ui/shadcn/components/form/input/input.dart' as input;

class InputExample3 extends StatelessWidget {
  const InputExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          placeholder: const Text('Enter your name'),
          features: [
            const InputFeature.clear(),
            // Hint shows a small tooltip-like popup for the input field.
            InputFeature.hint(
              popupBuilder: (context) {
                return const TooltipContainer(
                    child: Text('This is for your username'));
              },
            ),
            // Convenience actions for copying/pasting directly from the text field UI.
            const InputFeature.copy(),
            const InputFeature.paste(),
          ],
        ),
        const Gap(24),
        const TextField(
          placeholder: Text('Enter your password'),
          features: [
            InputFeature.clear(
              visibility: InputFeatureVisibility.textNotEmpty,
            ),
            // Password toggle configured with `hold` mode: press-and-hold to peek,
            // release to hide again.
            InputFeature.passwordToggle(mode: PasswordPeekMode.hold),
          ],
        ),
        const Gap(24),
        const TextField(
          initialValue: '10',
          placeholder: Text('Quantity'),
          features: [
            input.InputAboveBelowFeature.above(
              Text('Numeric input'),
            ),
            input.InputAboveBelowFeature.below(
              Text('Min 0 / Max 20'),
            ),
            input.InputStepperButtonFeature.decrement(),
            input.InputSpinnerFeature(step: 2, min: 0, max: 20),
            input.InputStepperButtonFeature(),
          ],
        ),
      ],
    );
  }
}
