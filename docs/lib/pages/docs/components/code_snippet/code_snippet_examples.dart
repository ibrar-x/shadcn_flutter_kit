import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'code_snippet_example_1.dart';

const ComponentExample codeSnippetExample1 = ComponentExample(
  title: "Code Snippet Example",
  builder: _buildCodeSnippetExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// CodeSnippet for showing read-only command or code blocks.\n///\n/// `mode` controls syntax highlighting; here we show a shell command.\nclass CodeSnippetExample1 extends StatelessWidget {\n  const CodeSnippetExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const CodeSnippet(\n      code: Text('flutter pub get'),\n    );\n  }\n}\n",
);

Widget _buildCodeSnippetExample1(BuildContext context) {
  return const CodeSnippetExample1();
}

const List<ComponentExample> codeSnippetExamples = [
  codeSnippetExample1,
];
