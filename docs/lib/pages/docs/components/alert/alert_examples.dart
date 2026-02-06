import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'alert_example_1.dart';

const ComponentExample alertExample1 = ComponentExample(
  title: "Alert Example",
  builder: _buildAlertExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Basic Alert example.\n///\n/// This shows a non-destructive [Alert] with a title, content, and a\n/// leading icon. Use alerts to communicate a status or message that\n/// doesn't necessarily require immediate user action.\nclass AlertExample1 extends StatelessWidget {\n  const AlertExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // `Alert` supports optional leading/trailing widgets for icons or actions.\n    return const Alert(\n      title: Text('Alert title'),\n      content: Text('This is alert content.'),\n      leading: Icon(Icons.info_outline),\n    );\n  }\n}\n",
);

Widget _buildAlertExample1(BuildContext context) {
  return const AlertExample1();
}

const List<ComponentExample> alertExamples = [
  alertExample1,
];
