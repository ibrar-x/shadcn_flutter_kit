import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../carousel/carousel_shared.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/navigation/stepper/stepper.dart'
    as shadcn_stepper;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample stepperExample6 = ComponentExample(
  title: 'Variants and sizes',
  builder: _buildStepperExample6,
  code: '''Stepper(
  variant: StepVariant.circle,
  size: StepSize.medium,
  steps: [...],
)''',
);

Widget _buildStepperExample6(BuildContext context) {
  return const _StepperExample6();
}

class _StepperExample6 extends StatefulWidget {
  const _StepperExample6();

  @override
  State<_StepperExample6> createState() => _StepperExample6State();
}

class _StepperExample6State extends State<_StepperExample6> {
  static const List<shadcn_stepper.StepVariant> _variants = [
    shadcn_stepper.StepVariant.circle,
    shadcn_stepper.StepVariant.circleAlt,
    shadcn_stepper.StepVariant.line,
  ];
  static const List<String> _variantNames = [
    'Circle',
    'Circle Alt',
    'Line',
  ];
  static const List<shadcn_stepper.StepSize> _stepSize =
      shadcn_stepper.StepSize.values;
  static const List<String> _stepSizeNames = [
    'Small',
    'Medium',
    'Large',
  ];
  final shadcn_stepper.StepperController controller =
      shadcn_stepper.StepperController();
  int _currentVariant = 0;
  int _currentStepSize = 0;
  Axis direction = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    final divider = Container(
      width: 1,
      height: 16,
      color: shadcn_theme.Theme.of(context).colorScheme.border,
    );
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            shadcn_buttons.Toggle(
              value: direction == Axis.horizontal,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    direction = Axis.horizontal;
                  });
                } else {
                  setState(() {
                    direction = Axis.vertical;
                  });
                }
              },
              child: const Text('Horizontal'),
            ),
            shadcn_buttons.Toggle(
              value: direction == Axis.vertical,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    direction = Axis.vertical;
                  });
                } else {
                  setState(() {
                    direction = Axis.horizontal;
                  });
                }
              },
              child: const Text('Vertical'),
            ),
            divider,
            for (var i = 0; i < _variants.length; i++)
              shadcn_buttons.Toggle(
                value: _currentVariant == i,
                onChanged: (value) {
                  setState(() {
                    _currentVariant = i;
                  });
                },
                child: Text(_variantNames[i]),
              ),
            divider,
            for (var i = 0; i < _stepSize.length; i++)
              shadcn_buttons.Toggle(
                value: _currentStepSize == i,
                onChanged: (value) {
                  setState(() {
                    _currentStepSize = i;
                  });
                },
                child: Text(_stepSizeNames[i]),
              ),
            divider,
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return shadcn_buttons.Toggle(
                  value: controller.value.stepStates[1] ==
                      shadcn_stepper.StepState.failed,
                  onChanged: (value) {
                    if (value) {
                      controller.setStatus(1, shadcn_stepper.StepState.failed);
                    } else {
                      controller.setStatus(1, null);
                    }
                  },
                  child: const Text('Toggle Error'),
                );
              },
            ),
          ],
        ),
        gap(16),
        shadcn_stepper.Stepper(
          controller: controller,
          direction: direction,
          size: _stepSize[_currentStepSize],
          variant: _variants[_currentVariant],
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
              title: const shadcn_stepper.StepTitle(
                title: Text('Step 2'),
                subtitle: Text('Optional Step'),
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
        ),
      ],
    );
  }
}
