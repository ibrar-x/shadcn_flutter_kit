import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'select_example_1.dart';
import 'select_example_2.dart';
import 'select_example_3.dart';
import 'select_example_4.dart';

const ComponentExample selectExample1 = ComponentExample(
  title: "Example",
  builder: _buildSelectExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass SelectExample1 extends StatefulWidget {\n  const SelectExample1({super.key});\n\n  @override\n  State<SelectExample1> createState() => _SelectExample1State();\n}\n\nclass _SelectExample1State extends State<SelectExample1> {\n  String? selectedValue;\n  @override\n  Widget build(BuildContext context) {\n    return Select<String>(\n      // How to render each selected item as text in the field.\n      itemBuilder: (context, item) {\n        return Text(item);\n      },\n      // Limit the popup size so it doesn't grow too large in the docs view.\n      popupConstraints: const BoxConstraints(\n        maxHeight: 300,\n        maxWidth: 200,\n      ),\n      onChanged: (value) {\n        setState(() {\n          // Save the currently selected value (or null to clear).\n          selectedValue = value;\n        });\n      },\n      // The current selection bound to this field.\n      value: selectedValue,\n      placeholder: const Text('Select a fruit'),\n      popup: const SelectPopup(\n        items: SelectItemList(\n          children: [\n            // A simple static list of options.\n            SelectItemButton(\n              value: 'Apple',\n              child: Text('Apple'),\n            ),\n            SelectItemButton(\n              value: 'Banana',\n              child: Text('Banana'),\n            ),\n            SelectItemButton(\n              value: 'Cherry',\n              child: Text('Cherry'),\n            ),\n          ],\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildSelectExample1(BuildContext context) {
  return const SelectExample1();
}

const ComponentExample selectExample2 = ComponentExample(
  title: "Example with search",
  builder: _buildSelectExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass SelectExample2 extends StatefulWidget {\n  const SelectExample2({super.key});\n\n  @override\n  State<SelectExample2> createState() => _SelectExample2State();\n}\n\nclass _SelectExample2State extends State<SelectExample2> {\n  final Map<String, List<String>> fruits = {\n    'Apple': ['Red Apple', 'Green Apple'],\n    'Banana': ['Yellow Banana', 'Brown Banana'],\n    'Lemon': ['Yellow Lemon', 'Green Lemon'],\n    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],\n  };\n  String? selectedValue;\n\n  Iterable<MapEntry<String, List<String>>> _filteredFruits(\n      String searchQuery) sync* {\n    // Yield entries whose key or children match the current search query.\n    for (final entry in fruits.entries) {\n      final filteredValues = entry.value\n          .where((value) => _filterName(value, searchQuery))\n          .toList();\n      if (filteredValues.isNotEmpty) {\n        yield MapEntry(entry.key, filteredValues);\n      } else if (_filterName(entry.key, searchQuery)) {\n        yield entry;\n      }\n    }\n  }\n\n  bool _filterName(String name, String searchQuery) {\n    // Case-insensitive substring filter.\n    return name.toLowerCase().contains(searchQuery);\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return Select<String>(\n      itemBuilder: (context, item) {\n        return Text(item);\n      },\n      popup: SelectPopup.builder(\n        // Provide a search field inside the popup.\n        searchPlaceholder: const Text('Search fruit'),\n        builder: (context, searchQuery) {\n          // Filter entries by the user's search.\n          final filteredFruits = searchQuery == null\n              ? fruits.entries\n              : _filteredFruits(searchQuery);\n          return SelectItemList(\n            children: [\n              for (final entry in filteredFruits)\n                SelectGroup(\n                  // Group by category (e.g., Apple, Banana) with a header label.\n                  headers: [\n                    SelectLabel(\n                      child: Text(entry.key),\n                    ),\n                  ],\n                  children: [\n                    for (final value in entry.value)\n                      SelectItemButton(\n                        value: value,\n                        child: Text(value),\n                      ),\n                  ],\n                ),\n            ],\n          );\n        },\n      ),\n      onChanged: (value) {\n        setState(() {\n          selectedValue = value;\n        });\n      },\n      constraints: const BoxConstraints(\n        minWidth: 200,\n      ),\n      value: selectedValue,\n      placeholder: const Text('Select a fruit'),\n    );\n  }\n}\n",
);

Widget _buildSelectExample2(BuildContext context) {
  return const SelectExample2();
}

const ComponentExample selectExample3 = ComponentExample(
  title: "Asynchronous infinite example",
  builder: _buildSelectExample3,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass SelectExample3 extends StatefulWidget {\n  const SelectExample3({super.key});\n\n  @override\n  State<SelectExample3> createState() => _SelectExample3State();\n}\n\nclass _SelectExample3State extends State<SelectExample3> {\n  final Map<String, List<String>> fruits = {\n    'Apple': ['Red Apple', 'Green Apple'],\n    'Banana': ['Yellow Banana', 'Brown Banana'],\n    'Lemon': ['Yellow Lemon', 'Green Lemon'],\n    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],\n  };\n  String? selectedValue;\n\n  Iterable<MapEntry<String, List<String>>> _filteredFruits(\n      String searchQuery) sync* {\n    for (final entry in fruits.entries) {\n      final filteredValues = entry.value\n          .where((value) => _filterName(value, searchQuery))\n          .toList();\n      if (filteredValues.isNotEmpty) {\n        yield MapEntry(entry.key, filteredValues);\n      } else if (_filterName(entry.key, searchQuery)) {\n        yield entry;\n      }\n    }\n  }\n\n  bool _filterName(String name, String searchQuery) {\n    return name.toLowerCase().contains(searchQuery);\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return Select<String>(\n      itemBuilder: (context, item) {\n        return Text(item);\n      },\n      popup: SelectPopup.builder(\n        // Popup with async data loading and custom empty/loading UI.\n        searchPlaceholder: const Text('Search fruit'),\n        emptyBuilder: (context) {\n          return const Center(\n            child: Text('No fruit found'),\n          );\n        },\n        loadingBuilder: (context) {\n          return const Center(\n            child: CircularProgressIndicator(),\n          );\n        },\n        builder: (context, searchQuery) async {\n          final filteredFruits = searchQuery == null\n              ? fruits.entries.toList()\n              : _filteredFruits(searchQuery).toList();\n          // Simulate a delay for loading\n          // In a real-world scenario, you would fetch data from an API or database\n          await Future.delayed(const Duration(milliseconds: 500));\n          return SelectItemBuilder(\n            // When 0, the popup renders the emptyBuilder; otherwise the builder lazily builds rows.\n            childCount: filteredFruits.isEmpty ? 0 : null,\n            builder: (context, index) {\n              final entry = filteredFruits[index % filteredFruits.length];\n              return SelectGroup(\n                headers: [\n                  SelectLabel(\n                    child: Text(entry.key),\n                  ),\n                ],\n                children: [\n                  for (final value in entry.value)\n                    SelectItemButton(\n                      value: value,\n                      child: Text(value),\n                    ),\n                ],\n              );\n            },\n          );\n        },\n      ),\n      onChanged: (value) {\n        setState(() {\n          selectedValue = value;\n        });\n      },\n      constraints: const BoxConstraints(\n        minWidth: 200,\n      ),\n      value: selectedValue,\n      placeholder: const Text('Select a fruit'),\n    );\n  }\n}\n",
);

Widget _buildSelectExample3(BuildContext context) {
  return const SelectExample3();
}

const ComponentExample selectExample4 = ComponentExample(
  title: "Example with no virtualization",
  builder: _buildSelectExample4,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass SelectExample4 extends StatefulWidget {\n  const SelectExample4({super.key});\n\n  @override\n  State<SelectExample4> createState() => _SelectExample4State();\n}\n\nclass _SelectExample4State extends State<SelectExample4> {\n  String? selectedValue;\n  @override\n  Widget build(BuildContext context) {\n    return Select<String>(\n      itemBuilder: (context, item) {\n        return Text(item);\n      },\n      popupConstraints: const BoxConstraints(\n        maxHeight: 300,\n        maxWidth: 200,\n      ),\n      onChanged: (value) {\n        setState(() {\n          selectedValue = value;\n        });\n      },\n      value: selectedValue,\n      placeholder: const Text('Select a fruit'),\n      // Constrain popup width to its intrinsic content size (no virtualization in this variant).\n      popupWidthConstraint: PopoverConstraint.intrinsic,\n      // Use a simple non-virtualized popup; suitable for small lists.\n      popup: const SelectPopup.noVirtualization(\n        items: SelectItemList(\n          children: [\n            SelectItemButton(\n              value: 'Apple',\n              child: Text('Apple'),\n            ),\n            SelectItemButton(\n              value: 'Banana',\n              child: Text('Banana'),\n            ),\n            SelectItemButton(\n              value: 'Cherry',\n              child: Text('Cherry'),\n            ),\n          ],\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildSelectExample4(BuildContext context) {
  return const SelectExample4();
}

const List<ComponentExample> selectExamples = [
  selectExample1,
  selectExample2,
  selectExample3,
  selectExample4,
];
