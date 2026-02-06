import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'autocomplete_example_1.dart';

const ComponentExample autocompleteExample1 = ComponentExample(
  title: "Example",
  builder: _buildAutocompleteExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// AutoComplete with a TextField and filtered suggestions.\n///\n/// Typing in the field updates the current word under the caret using\n/// [TextEditingController.currentWord] and filters a static list of fruits.\n/// The [AutoComplete] widget displays suggestions provided via `suggestions`.\nclass AutoCompleteExample1 extends StatefulWidget {\n  const AutoCompleteExample1({super.key});\n\n  @override\n  State<AutoCompleteExample1> createState() => _AutoCompleteExample1State();\n}\n\nclass _AutoCompleteExample1State extends State<AutoCompleteExample1> {\n  // Source data for suggestions.\n  final List<String> suggestions = [\n    'Apple',\n    'Banana',\n    'Cherry',\n    'Date',\n    'Grape',\n    'Kiwi',\n    'Lemon',\n    'Mango',\n    'Orange',\n    'Peach',\n    'Pear',\n    'Pineapple',\n    'Strawberry',\n    'Watermelon',\n  ];\n\n  // Filtered suggestions for the current input word.\n  List<String> _currentSuggestions = [];\n  // Controller for reading the current text and word at the caret.\n  final TextEditingController _controller = TextEditingController();\n\n  // Update the filtered suggestions based on the current word being typed.\n  void _updateSuggestions(String value) {\n    String? currentWord = _controller.currentWord;\n    if (currentWord == null || currentWord.isEmpty) {\n      setState(() {\n        _currentSuggestions = [];\n      });\n      return;\n    }\n    setState(() {\n      _currentSuggestions = suggestions\n          .where((element) =>\n              element.toLowerCase().contains(currentWord.toLowerCase()))\n          .toList();\n    });\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return AutoComplete(\n      // Provide the list to be shown in the overlay.\n      suggestions: _currentSuggestions,\n      child: TextField(\n        controller: _controller,\n        // Each keystroke recalculates the suggestions.\n        onChanged: _updateSuggestions,\n        features: const [\n          InputFeature.clear(),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildAutocompleteExample1(BuildContext context) {
  return const AutoCompleteExample1();
}

const List<ComponentExample> autocompleteExamples = [
  autocompleteExample1,
];
