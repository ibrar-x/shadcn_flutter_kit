import 'package:flutter/material.dart';
import '../code_snippet/code_snippet.dart';

class CodeSnippetPreview extends StatelessWidget {
  const CodeSnippetPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CodeSnippet(
          code: Text('flutter pub get'),
        ),
      ),
    );
  }
}
