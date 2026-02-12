import 'package:flutter/material.dart';
import '../code_snippet/code_snippet.dart';

/// Core class used by the code snippet component.
class CodeSnippetPreview extends StatelessWidget {
  const CodeSnippetPreview({super.key});

  /// Builds the widget tree for code snippet.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CodeSnippet(code: Text('flutter pub get'))),
    );
  }
}
