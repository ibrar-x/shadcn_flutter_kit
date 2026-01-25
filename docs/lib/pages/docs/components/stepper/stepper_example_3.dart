import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../carousel/carousel_shared.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/navigation/stepper/stepper.dart'
    as shadcn_stepper;

const ComponentExample stepperExample3 = ComponentExample(
  title: 'Failed state',
  builder: _buildStepperExample3,
  code:
      '''StepperController(stepStates: {1: StepState.failed}, currentStep: 1)''',
);

Widget _buildStepperExample3(BuildContext context) {
  return const _StepperExample3();
}

class _StepperExample3 extends StatefulWidget {
  const _StepperExample3();

  @override
  State<_StepperExample3> createState() => _StepperExample3State();
}

class _StepperExample3State extends State<_StepperExample3> {
  final shadcn_stepper.StepperController controller =
      shadcn_stepper.StepperController(
    stepStates: {
      1: shadcn_stepper.StepState.failed,
    },
    currentStep: 1,
  );

  @override
  Widget build(BuildContext context) {
    return shadcn_stepper.Stepper(
      controller: controller,
      direction: Axis.horizontal,
      steps: [
        shadcn_stepper.Step(
          title: const Text('Step 1'),
          contentBuilder: (context) {
            return const shadcn_stepper.StepContainer(
              actions: [
                shadcn_buttons.SecondaryButton(child: Text('Prev')),
                shadcn_buttons.PrimaryButton(child: Text('Next')),
              ],
              child: NumberedContainer(index: 1, height: 200),
            );
          },
        ),
        shadcn_stepper.Step(
          title: const Text('Step 2'),
          contentBuilder: (context) {
            return const shadcn_stepper.StepContainer(
              actions: [
                shadcn_buttons.SecondaryButton(child: Text('Prev')),
                shadcn_buttons.PrimaryButton(child: Text('Next')),
              ],
              child: NumberedContainer(index: 2, height: 200),
            );
          },
        ),
        shadcn_stepper.Step(
          title: const Text('Step 3'),
          contentBuilder: (context) {
            return const shadcn_stepper.StepContainer(
              actions: [
                shadcn_buttons.SecondaryButton(child: Text('Prev')),
                shadcn_buttons.PrimaryButton(child: Text('Finish')),
              ],
              child: NumberedContainer(index: 3, height: 200),
            );
          },
        ),
      ],
    );
  }
}
