import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../carousel/carousel_shared.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/navigation/stepper/stepper.dart'
    as shadcn_stepper;

const ComponentExample stepperExample2 = ComponentExample(
  title: 'Horizontal',
  builder: _buildStepperExample2,
  code: '''Stepper(
  direction: Axis.horizontal,
  steps: [
    Step(title: Text('Step 1'), contentBuilder: ...),
    Step(title: Text('Step 2'), contentBuilder: ...),
    Step(title: Text('Step 3'), contentBuilder: ...),
  ],
)''',
);

Widget _buildStepperExample2(BuildContext context) {
  return const _StepperExample2();
}

class _StepperExample2 extends StatefulWidget {
  const _StepperExample2();

  @override
  State<_StepperExample2> createState() => _StepperExample2State();
}

class _StepperExample2State extends State<_StepperExample2> {
  final shadcn_stepper.StepperController controller =
      shadcn_stepper.StepperController();

  @override
  Widget build(BuildContext context) {
    return shadcn_stepper.Stepper(
      controller: controller,
      direction: Axis.horizontal,
      steps: [
        shadcn_stepper.Step(
          title: const Text('Step 1'),
          contentBuilder: (context) {
            return shadcn_stepper.StepContainer(
              actions: [
                const shadcn_buttons.SecondaryButton(child: Text('Prev')),
                shadcn_buttons.PrimaryButton(
                  onPressed: controller.nextStep,
                  child: const Text('Next'),
                ),
              ],
              child: const NumberedContainer(index: 1, height: 200),
            );
          },
        ),
        shadcn_stepper.Step(
          title: const Text('Step 2'),
          contentBuilder: (context) {
            return shadcn_stepper.StepContainer(
              actions: [
                shadcn_buttons.SecondaryButton(
                  onPressed: controller.previousStep,
                  child: const Text('Prev'),
                ),
                shadcn_buttons.PrimaryButton(
                  onPressed: controller.nextStep,
                  child: const Text('Next'),
                ),
              ],
              child: const NumberedContainer(index: 2, height: 200),
            );
          },
        ),
        shadcn_stepper.Step(
          title: const Text('Step 3'),
          contentBuilder: (context) {
            return shadcn_stepper.StepContainer(
              actions: [
                shadcn_buttons.SecondaryButton(
                  onPressed: controller.previousStep,
                  child: const Text('Prev'),
                ),
                shadcn_buttons.PrimaryButton(
                  onPressed: controller.nextStep,
                  child: const Text('Finish'),
                ),
              ],
              child: const NumberedContainer(index: 3, height: 200),
            );
          },
        ),
      ],
    );
  }
}
