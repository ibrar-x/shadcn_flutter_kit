import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../carousel/carousel_shared.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/navigation/stepper/stepper.dart'
    as shadcn_stepper;

const ComponentExample stepperExample5 = ComponentExample(
  title: 'Custom icons',
  builder: _buildStepperExample5,
  code: '''Step(icon: StepNumber(icon: Icon(Icons.person)))''',
);

Widget _buildStepperExample5(BuildContext context) {
  return const _StepperExample5();
}

class _StepperExample5 extends StatefulWidget {
  const _StepperExample5();

  @override
  State<_StepperExample5> createState() => _StepperExample5State();
}

class _StepperExample5State extends State<_StepperExample5> {
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
          icon: const shadcn_stepper.StepNumber(
            icon: Icon(Icons.person),
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
          icon: const shadcn_stepper.StepNumber(
            icon: Icon(Icons.house_outlined),
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
          icon: const shadcn_stepper.StepNumber(
            icon: Icon(Icons.work_outline),
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
