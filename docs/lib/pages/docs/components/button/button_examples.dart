import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'button_example_1.dart';
import 'button_example_10.dart';
import 'button_example_11.dart';
import 'button_example_12.dart';
import 'button_example_13.dart';
import 'button_example_14.dart';
import 'button_example_15.dart';
import 'button_example_16.dart';
import 'button_example_17.dart';
import 'button_example_2.dart';
import 'button_example_3.dart';
import 'button_example_4.dart';
import 'button_example_5.dart';
import 'button_example_6.dart';
import 'button_example_7.dart';
import 'button_example_8.dart';
import 'button_example_9.dart';

const ComponentExample buttonExample1 = ComponentExample(
  title: "Primary Button Example",
  builder: _buildButtonExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Primary button.\n///\n/// Use for the main call-to-action on a screen.\nclass ButtonExample1 extends StatelessWidget {\n  const ButtonExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      onPressed: () {},\n      child: const Text('Primary'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample1(BuildContext context) {
  return const ButtonExample1();
}

const ComponentExample buttonExample2 = ComponentExample(
  title: "Secondary Button Example",
  builder: _buildButtonExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Secondary button.\n///\n/// A lower-emphasis action compared to [PrimaryButton].\nclass ButtonExample2 extends StatelessWidget {\n  const ButtonExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return SecondaryButton(\n      onPressed: () {},\n      child: const Text('Secondary'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample2(BuildContext context) {
  return const ButtonExample2();
}

const ComponentExample buttonExample3 = ComponentExample(
  title: "Outline Button Example",
  builder: _buildButtonExample3,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Outline button.\n///\n/// Uses an outlined border for a minimal visual weight.\nclass ButtonExample3 extends StatelessWidget {\n  const ButtonExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return OutlineButton(\n      onPressed: () {},\n      child: const Text('Outlined'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample3(BuildContext context) {
  return const ButtonExample3();
}

const ComponentExample buttonExample4 = ComponentExample(
  title: "Ghost Button Example",
  builder: _buildButtonExample4,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Ghost button.\n///\n/// Very subtle styling for least-emphasis or inline actions.\nclass ButtonExample4 extends StatelessWidget {\n  const ButtonExample4({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return GhostButton(\n      onPressed: () {},\n      child: const Text('Ghost'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample4(BuildContext context) {
  return const ButtonExample4();
}

const ComponentExample buttonExample5 = ComponentExample(
  title: "Destructive Button Example",
  builder: _buildButtonExample5,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Destructive button.\n///\n/// Use to represent dangerous or irreversible actions (e.g., delete).\nclass ButtonExample5 extends StatelessWidget {\n  const ButtonExample5({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return DestructiveButton(\n      onPressed: () {},\n      child: const Text('Destructive'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample5(BuildContext context) {
  return const ButtonExample5();
}

const ComponentExample buttonExample6 = ComponentExample(
  title: "Link Button Example",
  builder: _buildButtonExample6,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample6 extends StatelessWidget {\n  const ButtonExample6({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return LinkButton(\n      onPressed: () {},\n      child: const Text('Link'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample6(BuildContext context) {
  return const ButtonExample6();
}

const ComponentExample buttonExample7 = ComponentExample(
  title: "Text Button Example",
  builder: _buildButtonExample7,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample12 extends StatelessWidget {\n  const ButtonExample12({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return TextButton(\n      onPressed: () {},\n      child: const Text('Text Button'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample7(BuildContext context) {
  return const ButtonExample12();
}

const ComponentExample buttonExample8 = ComponentExample(
  title: "Disabled Button Example",
  builder: _buildButtonExample8,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample7 extends StatelessWidget {\n  const ButtonExample7({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const Wrap(\n      spacing: 8,\n      runSpacing: 8,\n      children: [\n        PrimaryButton(\n          child: Text('Disabled'),\n        ),\n        SecondaryButton(\n          child: Text('Disabled'),\n        ),\n        OutlineButton(\n          child: Text('Disabled'),\n        ),\n        GhostButton(\n          child: Text('Disabled'),\n        ),\n        TextButton(\n          child: Text('Disabled'),\n        ),\n        DestructiveButton(\n          child: Text('Disabled'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildButtonExample8(BuildContext context) {
  return const ButtonExample7();
}

const ComponentExample buttonExample9 = ComponentExample(
  title: "Icon Button Example",
  builder: _buildButtonExample9,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample8 extends StatelessWidget {\n  const ButtonExample8({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      runSpacing: 8,\n      spacing: 8,\n      children: [\n        IconButton.primary(\n          onPressed: () {},\n          density: ButtonDensity.icon,\n          icon: const Icon(Icons.add),\n        ),\n        IconButton.secondary(\n          onPressed: () {},\n          density: ButtonDensity.icon,\n          icon: const Icon(Icons.add),\n        ),\n        IconButton.outline(\n          onPressed: () {},\n          density: ButtonDensity.icon,\n          icon: const Icon(Icons.add),\n        ),\n        IconButton.ghost(\n          onPressed: () {},\n          density: ButtonDensity.icon,\n          icon: const Icon(Icons.add),\n        ),\n        IconButton.text(\n          onPressed: () {},\n          density: ButtonDensity.icon,\n          icon: const Icon(Icons.add),\n        ),\n        IconButton.destructive(\n          onPressed: () {},\n          density: ButtonDensity.icon,\n          icon: const Icon(Icons.add),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildButtonExample9(BuildContext context) {
  return const ButtonExample8();
}

const ComponentExample buttonExample10 = ComponentExample(
  title: "Icon Button with Label Example",
  builder: _buildButtonExample10,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample9 extends StatelessWidget {\n  const ButtonExample9({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      spacing: 8,\n      runSpacing: 8,\n      children: [\n        PrimaryButton(\n          onPressed: () {},\n          trailing: const Icon(Icons.add),\n          child: const Text('Add'),\n        ),\n        SecondaryButton(\n          onPressed: () {},\n          trailing: const Icon(Icons.add),\n          child: const Text('Add'),\n        ),\n        OutlineButton(\n          onPressed: () {},\n          trailing: const Icon(Icons.add),\n          child: const Text('Add'),\n        ),\n        GhostButton(\n          onPressed: () {},\n          trailing: const Icon(Icons.add),\n          child: const Text('Add'),\n        ),\n        TextButton(\n          onPressed: () {},\n          trailing: const Icon(Icons.add),\n          child: const Text('Add'),\n        ),\n        DestructiveButton(\n          onPressed: () {},\n          trailing: const Icon(Icons.add),\n          child: const Text('Add'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildButtonExample10(BuildContext context) {
  return const ButtonExample9();
}

const ComponentExample buttonExample11 = ComponentExample(
  title: "Button Size Example",
  builder: _buildButtonExample11,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample10 extends StatelessWidget {\n  const ButtonExample10({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      spacing: 8,\n      runSpacing: 8,\n      alignment: WrapAlignment.center,\n      runAlignment: WrapAlignment.center,\n      children: [\n        PrimaryButton(\n          size: ButtonSize.xSmall,\n          onPressed: () {},\n          child: const Text('Extra Small'),\n        ),\n        PrimaryButton(\n          onPressed: () {},\n          size: ButtonSize.small,\n          child: const Text('Small'),\n        ),\n        PrimaryButton(\n          size: ButtonSize.normal,\n          onPressed: () {},\n          child: const Text('Normal'),\n        ),\n        PrimaryButton(\n          size: ButtonSize.large,\n          onPressed: () {},\n          child: const Text('Large'),\n        ),\n        PrimaryButton(\n          size: ButtonSize.xLarge,\n          onPressed: () {},\n          child: const Text('Extra Large'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildButtonExample11(BuildContext context) {
  return const ButtonExample10();
}

const ComponentExample buttonExample12 = ComponentExample(
  title: "Button Density Example",
  builder: _buildButtonExample12,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample11 extends StatelessWidget {\n  const ButtonExample11({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      spacing: 8,\n      runSpacing: 8,\n      alignment: WrapAlignment.center,\n      runAlignment: WrapAlignment.center,\n      children: [\n        PrimaryButton(\n          onPressed: () {},\n          density: ButtonDensity.compact,\n          child: const Text('Compact'),\n        ),\n        PrimaryButton(\n          onPressed: () {},\n          density: ButtonDensity.dense,\n          child: const Text('Dense'),\n        ),\n        PrimaryButton(\n          onPressed: () {},\n          density: ButtonDensity.normal,\n          child: const Text('Normal'),\n        ),\n        PrimaryButton(\n          onPressed: () {},\n          density: ButtonDensity.comfortable,\n          child: const Text('Comfortable'),\n        ),\n        PrimaryButton(\n          onPressed: () {},\n          density: ButtonDensity.icon,\n          child: const Text('Icon'),\n        ),\n        PrimaryButton(\n          onPressed: () {},\n          density: ButtonDensity.iconComfortable,\n          child: const Text('Icon Comfortable'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildButtonExample12(BuildContext context) {
  return const ButtonExample11();
}

const ComponentExample buttonExample13 = ComponentExample(
  title: "Button Shape Example",
  builder: _buildButtonExample13,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample13 extends StatelessWidget {\n  const ButtonExample13({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      spacing: 8,\n      runSpacing: 8,\n      alignment: WrapAlignment.center,\n      runAlignment: WrapAlignment.center,\n      children: [\n        PrimaryButton(\n          onPressed: () {},\n          shape: ButtonShape.circle,\n          child: const Icon(Icons.add),\n        ),\n        PrimaryButton(\n          onPressed: () {},\n          shape: ButtonShape.rectangle,\n          child: const Text('Rectangle'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildButtonExample13(BuildContext context) {
  return const ButtonExample13();
}

const ComponentExample buttonExample14 = ComponentExample(
  title: "Button Group Example",
  builder: _buildButtonExample14,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample14 extends StatelessWidget {\n  const ButtonExample14({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return ButtonGroup(\n      children: [\n        PrimaryButton(\n          child: const Text('Primary'),\n          onPressed: () {},\n        ),\n        SecondaryButton(\n          child: const Text('Secondary'),\n          onPressed: () {},\n        ),\n        DestructiveButton(\n          child: const Text('Destructive'),\n          onPressed: () {},\n        ),\n        OutlineButton(\n          child: const Text('Outlined'),\n          onPressed: () {},\n        ),\n        GhostButton(\n          child: const Text('Ghost'),\n          onPressed: () {},\n        ),\n        IconButton.primary(\n          icon: const Icon(Icons.add),\n          onPressed: () {},\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildButtonExample14(BuildContext context) {
  return const ButtonExample14();
}

const ComponentExample buttonExample15 = ComponentExample(
  title: "Button Stated Example",
  builder: _buildButtonExample15,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample15 extends StatelessWidget {\n  const ButtonExample15({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      leading: const StatedWidget.map(\n        states: {\n          'disabled': Icon(Icons.close),\n          {WidgetState.hovered, WidgetState.focused}:\n              Icon(Icons.add_a_photo_rounded),\n          WidgetState.hovered: Icon(Icons.add_a_photo),\n        },\n        child: Icon(Icons.add_a_photo_outlined),\n      ),\n      onPressed: () {},\n      child: const StatedWidget(\n        focused: Text('Focused'),\n        hovered: Text('Hovered'),\n        pressed: Text('Pressed'),\n        child: Text('Normal'),\n      ),\n    );\n  }\n}\n",
);

Widget _buildButtonExample15(BuildContext context) {
  return const ButtonExample15();
}

const ComponentExample buttonExample16 = ComponentExample(
  title: "Card Button Example",
  builder: _buildButtonExample16,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample16 extends StatelessWidget {\n  const ButtonExample16({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return CardButton(\n      onPressed: () {},\n      child: const Basic(\n        title: Text('Project #1'),\n        subtitle: Text('Project description'),\n        content:\n            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),\n      ),\n    );\n  }\n}\n",
);

Widget _buildButtonExample16(BuildContext context) {
  return const ButtonExample16();
}

const ComponentExample buttonExample17 = ComponentExample(
  title: "Custom Button Example",
  builder: _buildButtonExample17,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ButtonExample17 extends StatelessWidget {\n  const ButtonExample17({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Button(\n      style: const ButtonStyle.primary()\n          .withBackgroundColor(color: Colors.red, hoverColor: Colors.purple)\n          .withForegroundColor(color: Colors.white)\n          .withBorderRadius(hoverBorderRadius: BorderRadius.circular(16)),\n      onPressed: () {},\n      leading: const Icon(Icons.sunny),\n      child: const Text('Custom Button'),\n    );\n  }\n}\n",
);

Widget _buildButtonExample17(BuildContext context) {
  return const ButtonExample17();
}

const List<ComponentExample> buttonExamples = [
  buttonExample1,
  buttonExample2,
  buttonExample3,
  buttonExample4,
  buttonExample5,
  buttonExample6,
  buttonExample7,
  buttonExample8,
  buttonExample9,
  buttonExample10,
  buttonExample11,
  buttonExample12,
  buttonExample13,
  buttonExample14,
  buttonExample15,
  buttonExample16,
  buttonExample17,
];
