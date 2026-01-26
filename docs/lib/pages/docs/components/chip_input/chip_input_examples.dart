import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'chip_input_example_1.dart';

const ComponentExample chipInputExample1 = ComponentExample(
  title: "Example",
  builder: _buildChipInputExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// ChipInput with inline autocomplete suggestions.\n///\n/// Shows how to:\n/// - Listen to a [ChipEditingController] to compute suggestions based on\n///   the current token being typed (using [textAtCursor]).\n/// - Wrap [ChipInput] with [AutoComplete] to display suggestions.\n/// - Transform submitted chips (here we prepend '@').\nclass ChipInputExample1 extends StatefulWidget {\n  const ChipInputExample1({super.key});\n\n  @override\n  State<ChipInputExample1> createState() => _ChipInputExample1State();\n}\n\nclass _ChipInputExample1State extends State<ChipInputExample1> {\n  // Current filtered suggestions for the token at the cursor.\n  List<String> _suggestions = [];\n  // Controller manages both chips and text entry.\n  final ChipEditingController<String> _controller = ChipEditingController();\n  // Static suggestion pool to match against.\n  static const List<String> _availableSuggestions = [\n    'hello world',\n    'lorem ipsum',\n    'do re mi',\n    'foo bar',\n    'flutter dart',\n  ];\n\n  @override\n  void initState() {\n    super.initState();\n    _controller.addListener(\n      () {\n        setState(() {\n          // IMPORTANT: use textAtCursor instead of text so we only consider\n          // the current token under the caret when filtering suggestions.\n          var value = _controller.textAtCursor;\n          if (value.isNotEmpty) {\n            _suggestions = _availableSuggestions.where((element) {\n              return element.startsWith(value);\n            }).toList();\n          } else {\n            _suggestions = [];\n          }\n        });\n      },\n    );\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        AutoComplete(\n          // Provide suggestions to show below the input as the user types.\n          suggestions: _suggestions,\n          child: ChipInput<String>(\n            controller: _controller,\n            onChipSubmitted: (value) {\n              setState(() {\n                _suggestions = [];\n              });\n              // Transform the chip value before storing it.\n              return '@\$value';\n            },\n            chipBuilder: (context, chip) {\n              return Text(chip);\n            },\n          ),\n        ),\n        gap(24),\n        ListenableBuilder(\n          listenable: _controller,\n          builder: (context, child) {\n            // Reflect the current chip list for demonstration.\n            return Text('Current chips: \${_controller.chips.join(', ')}');\n          },\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildChipInputExample1(BuildContext context) {
  return const ChipInputExample1();
}

const List<ComponentExample> chipInputExamples = [
  chipInputExample1,
];