import 'package:docs/shadcn_ui.dart';

/// CodeSnippet for showing read-only command or code blocks.
///
/// `mode` controls syntax highlighting; here we show a shell command.
class CodeSnippetExample1 extends StatelessWidget {
  const CodeSnippetExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const CodeSnippet(
      code: Text('flutter pub get'),
    );
  }
}
