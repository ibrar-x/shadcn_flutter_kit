import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/steps/steps.dart'
    as shadcn_steps;

const ComponentExample stepsExample1 = ComponentExample(
  title: 'Basic',
  builder: _buildStepsExample1,
  code: '''Steps(
  children: [
    StepItem(title: Text('Create a project'), content: [...]),
    StepItem(title: Text('Add dependencies'), content: [...]),
    StepItem(title: Text('Run the project'), content: [...]),
  ],
)''',
);

Widget _buildStepsExample1(BuildContext context) {
  return const shadcn_steps.Steps(
    children: [
      shadcn_steps.StepItem(
        title: Text('Create a project'),
        content: [
          Text('Create a new project in the project manager.'),
          Text('Add the required files to the project.'),
        ],
      ),
      shadcn_steps.StepItem(
        title: Text('Add dependencies'),
        content: [
          Text('Add the required dependencies to the project.'),
        ],
      ),
      shadcn_steps.StepItem(
        title: Text('Run the project'),
        content: [
          Text('Run the project in the project manager.'),
        ],
      ),
    ],
  );
}
