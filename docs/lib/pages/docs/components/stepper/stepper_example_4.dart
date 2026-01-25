import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../carousel/carousel_shared.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/navigation/stepper/stepper.dart'
    as shadcn_stepper;

const ComponentExample stepperExample4 = ComponentExample(
  title: 'Jump to step',
  builder: _buildStepperExample4,
  code: '''Step(icon: StepNumber(onPressed: () => controller.jumpToStep(0)))''',
);

Widget _buildStepperExample4(BuildContext context) {
  return const _StepperExample4();
}

class _StepperExample4 extends StatefulWidget {
  const _StepperExample4();

  @override
  State<_StepperExample4> createState() => _StepperExample4State();
}

class _StepperExample4State extends State<_StepperExample4> {
  final shadcn_stepper.StepperController controller =
      shadcn_stepper.StepperController();

  @override
  Widget build(BuildContext context) {
    return shadcn_stepper.Stepper(
      controller: controller,
      direction: Axis.vertical,
      steps: [
        shadcn_stepper.Step(
          title: const Text('Step 1'),
          icon: shadcn_stepper.StepNumber(
            onPressed: () => controller.jumpToStep(0),
          ),
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
          icon: shadcn_stepper.StepNumber(
            onPressed: () => controller.jumpToStep(1),
          ),
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
          icon: shadcn_stepper.StepNumber(
            onPressed: () => controller.jumpToStep(2),
          ),
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
