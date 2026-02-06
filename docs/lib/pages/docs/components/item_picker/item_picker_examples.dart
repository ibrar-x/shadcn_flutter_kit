import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'item_picker_example_1.dart';
import 'item_picker_example_2.dart';
import 'item_picker_example_3.dart';
import 'item_picker_example_4.dart';
import 'item_picker_example_5.dart';

const ComponentExample itemPickerExample1 = ComponentExample(
  title: "Item Picker Example",
  builder: _buildItemPickerExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ItemPickerExample1 extends StatelessWidget {\n  const ItemPickerExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      onPressed: () {\n        // Show a popover item picker (non-dialog) with a virtual list of 1000 items.\n        showItemPicker<int>(\n          context,\n          title: const Text('Pick an item'),\n          items: ItemBuilder(\n            itemCount: 1000,\n            itemBuilder: (index) {\n              return index;\n            },\n          ),\n          builder: (context, item) {\n            return ItemPickerOption(\n                value: item, child: Text(item.toString()).large);\n          },\n        ).then(\n          (value) {\n            if (value != null && context.mounted) {\n              // Feedback via toast when a selection is made.\n              showToast(\n                context: context,\n                builder: (context, overlay) {\n                  return SurfaceCard(\n                    child: Text('You picked \$value!'),\n                  );\n                },\n              );\n            } else if (context.mounted) {\n              showToast(\n                context: context,\n                builder: (context, overlay) {\n                  return const SurfaceCard(\n                    child: Text('You picked nothing!'),\n                  );\n                },\n              );\n            }\n          },\n        );\n      },\n      child: const Text('Show Item Picker'),\n    );\n  }\n}\n",
);

Widget _buildItemPickerExample1(BuildContext context) {
  return const ItemPickerExample1();
}

const ComponentExample itemPickerExample2 = ComponentExample(
  title: "Dialog Example",
  builder: _buildItemPickerExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass ItemPickerExample2 extends StatelessWidget {\n  const ItemPickerExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      onPressed: () {\n        // Dialog variant of the item picker for a more prominent selection flow.\n        showItemPickerDialog<int>(\n          context,\n          title: const Text('Pick a number'),\n          items: ItemBuilder(\n            itemBuilder: (index) {\n              return index;\n            },\n          ),\n          builder: (context, item) {\n            return ItemPickerOption(\n                value: item, child: Text(item.toString()).large);\n          },\n        ).then(\n          (value) {\n            if (value != null && context.mounted) {\n              showToast(\n                context: context,\n                builder: (context, overlay) {\n                  return SurfaceCard(\n                    child: Text('You picked \$value!'),\n                  );\n                },\n              );\n            } else if (context.mounted) {\n              showToast(\n                context: context,\n                builder: (context, overlay) {\n                  return const SurfaceCard(\n                    child: Text('You picked nothing!'),\n                  );\n                },\n              );\n            }\n          },\n        );\n      },\n      child: const Text('Show Item Picker'),\n    );\n  }\n}\n",
);

Widget _buildItemPickerExample2(BuildContext context) {
  return const ItemPickerExample2();
}

const ComponentExample itemPickerExample3 = ComponentExample(
  title: "Fixed List Item Example",
  builder: _buildItemPickerExample3,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass NamedColor {\n  final String name;\n  final Color color;\n\n  const NamedColor(this.name, this.color);\n}\n\nclass ItemPickerExample3 extends StatefulWidget {\n  const ItemPickerExample3({super.key});\n\n  @override\n  State<ItemPickerExample3> createState() => _ItemPickerExample3State();\n}\n\nclass _ItemPickerExample3State extends State<ItemPickerExample3> {\n  final List<NamedColor> colors = const [\n    NamedColor('Red', Colors.red),\n    NamedColor('Green', Colors.green),\n    NamedColor('Blue', Colors.blue),\n    NamedColor('Yellow', Colors.yellow),\n    NamedColor('Purple', Colors.purple),\n    NamedColor('Cyan', Colors.cyan),\n    NamedColor('Orange', Colors.orange),\n    NamedColor('Pink', Colors.pink),\n    NamedColor('Teal', Colors.teal),\n    NamedColor('Amber', Colors.amber),\n  ];\n  int selectedColor = 0;\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      onPressed: () {\n        showItemPickerDialog<NamedColor>(\n          context,\n          items: ItemList(colors),\n          initialValue: colors[selectedColor],\n          title: const Text('Pick a color'),\n          builder: (context, item) {\n            return ItemPickerOption(\n              value: item,\n              selectedStyle: const ButtonStyle.primary(\n                shape: ButtonShape.circle,\n              ),\n              style: const ButtonStyle.ghost(\n                shape: ButtonShape.circle,\n              ),\n              label: Text(item.name),\n              child: Container(\n                padding: const EdgeInsets.all(8),\n                width: 100,\n                height: 100,\n                alignment: Alignment.center,\n                decoration:\n                    BoxDecoration(color: item.color, shape: BoxShape.circle),\n              ),\n            );\n          },\n        ).then(\n          (value) {\n            if (value != null) {\n              selectedColor = colors.indexOf(value);\n              if (context.mounted) {\n                showToast(\n                  context: context,\n                  builder: (context, overlay) {\n                    return SurfaceCard(\n                      child: Text('You picked \${value.name}!'),\n                    );\n                  },\n                );\n              }\n            } else if (context.mounted) {\n              showToast(\n                context: context,\n                builder: (context, overlay) {\n                  return const SurfaceCard(\n                    child: Text('You picked nothing!'),\n                  );\n                },\n              );\n            }\n          },\n        );\n      },\n      child: const Text('Show Item Picker'),\n    );\n  }\n}\n",
);

Widget _buildItemPickerExample3(BuildContext context) {
  return const ItemPickerExample3();
}

const ComponentExample itemPickerExample4 = ComponentExample(
  title: "List Layout Example",
  builder: _buildItemPickerExample4,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass NamedColor {\n  final String name;\n  final Color color;\n\n  const NamedColor(this.name, this.color);\n}\n\nclass ItemPickerExample4 extends StatefulWidget {\n  const ItemPickerExample4({super.key});\n\n  @override\n  State<ItemPickerExample4> createState() => _ItemPickerExample4State();\n}\n\nclass _ItemPickerExample4State extends State<ItemPickerExample4> {\n  final List<NamedColor> colors = const [\n    NamedColor('Red', Colors.red),\n    NamedColor('Green', Colors.green),\n    NamedColor('Blue', Colors.blue),\n    NamedColor('Yellow', Colors.yellow),\n    NamedColor('Purple', Colors.purple),\n    NamedColor('Cyan', Colors.cyan),\n    NamedColor('Orange', Colors.orange),\n    NamedColor('Pink', Colors.pink),\n    NamedColor('Teal', Colors.teal),\n    NamedColor('Amber', Colors.amber),\n  ];\n  int selectedColor = 0;\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      onPressed: () {\n        showItemPickerDialog<NamedColor>(\n          context,\n          items: ItemList(colors),\n          initialValue: colors[selectedColor],\n          // Force a list layout instead of a grid for narrower rows.\n          layout: ItemPickerLayout.list,\n          title: const Text('Pick a color'),\n          builder: (context, item) {\n            return ItemPickerOption(\n                value: item,\n                label: Text(item.name),\n                child: Container(\n                  width: 40,\n                  height: 40,\n                  decoration: BoxDecoration(\n                    color: item.color,\n                    shape: BoxShape.circle,\n                  ),\n                ));\n          },\n        ).then(\n          (value) {\n            if (value != null) {\n              selectedColor = colors.indexOf(value);\n              if (context.mounted) {\n                showToast(\n                  context: context,\n                  builder: (context, overlay) {\n                    return SurfaceCard(\n                      child: Text('You picked \${value.name}!'),\n                    );\n                  },\n                );\n              }\n            } else if (context.mounted) {\n              showToast(\n                context: context,\n                builder: (context, overlay) {\n                  return const SurfaceCard(\n                    child: Text('You picked nothing!'),\n                  );\n                },\n              );\n            }\n          },\n        );\n      },\n      child: const Text('Show Item Picker'),\n    );\n  }\n}\n",
);

Widget _buildItemPickerExample4(BuildContext context) {
  return const ItemPickerExample4();
}

const ComponentExample itemPickerExample5 = ComponentExample(
  title: "Form Example",
  builder: _buildItemPickerExample5,
  code: "import 'package:flutter/foundation.dart';\nimport 'package:docs/shadcn_ui.dart';\n\nclass NamedColor {\n  final String name;\n  final Color color;\n\n  const NamedColor(this.name, this.color);\n}\n\nclass ItemPickerExample5 extends StatefulWidget {\n  const ItemPickerExample5({super.key});\n\n  @override\n  State<ItemPickerExample5> createState() => _ItemPickerExample5State();\n}\n\nclass _ItemPickerExample5State extends State<ItemPickerExample5> {\n  final List<NamedColor> colors = const [\n    NamedColor('Red', Colors.red),\n    NamedColor('Green', Colors.green),\n    NamedColor('Blue', Colors.blue),\n    NamedColor('Yellow', Colors.yellow),\n    NamedColor('Purple', Colors.purple),\n    NamedColor('Cyan', Colors.cyan),\n    NamedColor('Orange', Colors.orange),\n    NamedColor('Pink', Colors.pink),\n    NamedColor('Teal', Colors.teal),\n    NamedColor('Amber', Colors.amber),\n  ];\n  int selectedColor = 0;\n  @override\n  Widget build(BuildContext context) {\n    return ItemPicker<NamedColor>(\n      items: ItemList(colors),\n      mode: PromptMode.popover,\n      title: const Text('Pick a color'),\n      builder: (context, item) {\n        return ItemPickerOption(\n          value: item,\n          label: Text(item.name),\n          style: const ButtonStyle.ghostIcon(\n            shape: ButtonShape.circle,\n          ),\n          selectedStyle: const ButtonStyle.primary(\n            shape: ButtonShape.circle,\n          ),\n          child: Container(\n            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),\n            decoration: BoxDecoration(\n              color: item.color,\n              shape: BoxShape.circle,\n            ),\n          ),\n        );\n      },\n      value: colors[selectedColor],\n      placeholder: const Text('Pick a color'),\n      onChanged: (value) {\n        if (kDebugMode) {\n          print('You picked \$value!');\n        }\n        if (value != null) {\n          setState(() {\n            selectedColor = colors.indexOf(value);\n          });\n        }\n      },\n    );\n  }\n}\n",
);

Widget _buildItemPickerExample5(BuildContext context) {
  return const ItemPickerExample5();
}

const List<ComponentExample> itemPickerExamples = [
  itemPickerExample1,
  itemPickerExample2,
  itemPickerExample3,
  itemPickerExample4,
  itemPickerExample5,
];