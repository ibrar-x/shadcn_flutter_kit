import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'tooltip_example_1.dart';

const ComponentExample tooltipExample1 = ComponentExample(
  title: "Tooltip Example",
  builder: _buildTooltipExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n// Demonstrates a Tooltip wrapping a button; shows tooltip content on\n// hover/focus.\n\nclass TooltipExample1 extends StatelessWidget {\n  const TooltipExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Tooltip(\n      // Tooltip wraps a target widget and shows TooltipContainer on hover/focus.\n      tooltip: const TooltipContainer(\n        child: Text('This is a tooltip.'),\n      ),\n      child: PrimaryButton(\n        onPressed: () {},\n        child: const Text('Hover over me'),\n      ),\n    );\n  }\n}\n",
);

Widget _buildTooltipExample1(BuildContext context) {
  return const TooltipExample1();
}

const List<ComponentExample> tooltipExamples = [
  tooltipExample1,
];
