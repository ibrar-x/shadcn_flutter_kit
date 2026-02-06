import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'steps_example_1.dart';

const ComponentExample stepsExample1 = ComponentExample(
  title: "Steps Example",
  builder: _buildStepsExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass StepsExample1 extends StatelessWidget {\n  const StepsExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const Steps(\n      // Static steps list with titles and supporting content lines.\n      children: [\n        StepItem(\n          title: Text('Create a project'),\n          content: [\n            Text('Create a new project in the project manager.'),\n            Text('Add the required files to the project.'),\n          ],\n        ),\n        StepItem(\n          title: Text('Add dependencies'),\n          content: [\n            Text('Add the required dependencies to the project.'),\n          ],\n        ),\n        StepItem(\n          title: Text('Run the project'),\n          content: [\n            Text('Run the project in the project manager.'),\n          ],\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildStepsExample1(BuildContext context) {
  return const StepsExample1();
}

const List<ComponentExample> stepsExamples = [
  stepsExample1,
];
