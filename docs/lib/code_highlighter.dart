import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import 'ui/shadcn/components/control/button/button.dart' as shadcn_buttons;
import 'ui/shadcn/components/display/code_snippet/code_snippet.dart';
import 'ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import 'ui/shadcn/components/overlay/toast/toast.dart';

class CodeHighlighter extends StatefulWidget {
  final String code;
  final String mode;

  const CodeHighlighter({
    super.key,
    required this.code,
    required this.mode,
  });

  @override
  State<CodeHighlighter> createState() => _CodeHighlighterState();
}

class _HighlighterResult {
  final bool success;
  final HighlighterTheme theme;

  _HighlighterResult({
    required this.success,
    required this.theme,
  });
}

class _CodeHighlighterState extends State<CodeHighlighter> {
  static final Map<String, Future<bool>> _initializedLanguages = {};
  static final Map<Brightness, Future<HighlighterTheme>> _initializedThemes =
      {};

  static const Set<String> supportedLanguages = {
    'css',
    'dart',
    'html',
    'javascript',
    'json',
    'typescript',
    'yaml',
  };

  static String _resolveMode(String mode) {
    if (mode == 'bash' || mode == 'shell' || mode == 'sh') {
      return 'javascript';
    }
    if (mode == 'js') {
      return 'javascript';
    }
    if (mode == 'ts') {
      return 'typescript';
    }
    if (mode == 'yml') {
      return 'yaml';
    }
    return mode;
  }

  static Future<bool> initializeLanguage(String mode) {
    final resolvedMode = _resolveMode(mode);
    final current = _initializedLanguages[resolvedMode];
    if (current != null) {
      return current;
    }
    if (!supportedLanguages.contains(resolvedMode)) {
      return Future.value(false);
    }
    final future =
        Highlighter.initialize([resolvedMode]).then((_) => true).catchError(
      (err, stackTrace) {
        if (kDebugMode) {
          print(err);
          print(stackTrace);
        }
        return false;
      },
    );
    _initializedLanguages[resolvedMode] = future;
    return future;
  }

  static Future<HighlighterTheme> initializeTheme(Brightness brightness) {
    final current = _initializedThemes[brightness];
    if (current != null) {
      return current;
    }
    final future = HighlighterTheme.loadForBrightness(brightness);
    _initializedThemes[brightness] = future;
    return future;
  }

  Future<_HighlighterResult> _request() async {
    final brightness = Theme.of(context).brightness;
    final success = await initializeLanguage(widget.mode);
    final theme = await initializeTheme(brightness);
    return _HighlighterResult(success: success, theme: theme);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_HighlighterResult>(
      future: _request(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        if (snapshot.hasData) {
          final data = snapshot.requireData;
          final resolvedMode = _resolveMode(widget.mode);
          return SelectableText.rich(
            !data.success
                ? TextSpan(text: widget.code)
                : Highlighter(language: resolvedMode, theme: data.theme)
                    .highlight(widget.code),
          );
        }
        return const Text('Empty');
      },
    );
  }
}

class CodeBlock extends StatelessWidget {
  final String code;
  final String mode;
  final List<Widget> actions;

  const CodeBlock({
    super.key,
    required this.code,
    required this.mode,
    this.actions = const [],
  });

  void _showCopiedToast(BuildContext context) {
    final controller = ToastController();
    controller.show(
      context: context,
      builder: (toastContext) {
        return const shadcn_card.Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check),
              SizedBox(width: 8),
              Text('Copied to clipboard'),
            ],
          ),
        );
      },
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CodeSnippet(
      code: CodeHighlighter(code: code, mode: mode),
      actions: [
        ...actions,
        shadcn_buttons.IconButton.ghost(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: code)).then((_) {
              if (context.mounted) {
                _showCopiedToast(context);
              }
            });
          },
          icon: const Icon(Icons.copy, size: 16),
        ),
      ],
    );
  }
}
