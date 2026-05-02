import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import 'theme/docs_theme.dart';
import 'ui/shadcn/components/control/button/button.dart' as shadcn_buttons;
import 'ui/shadcn/components/display/code_snippet/code_snippet.dart';
import 'ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import 'ui/shadcn/components/overlay/toast/toast.dart';
import 'ui/shadcn/shared/theme/color_scheme.dart' as shadcn_colors;

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
  static final Map<String, Future<HighlighterTheme>> _initializedThemes = {};

  static const Set<String> supportedLanguages = {
    'css',
    'dart',
    'html',
    'javascript',
    'json',
    'typescript',
    'yaml',
  };

  static String? _resolveMode(String mode) {
    if (mode == 'bash' || mode == 'shell' || mode == 'sh') {
      return null;
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
    if (resolvedMode == null) {
      return Future.value(false);
    }
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

  static Future<HighlighterTheme> initializeTheme(
    shadcn_colors.ColorScheme colorScheme,
  ) {
    final cacheKey = [
      colorScheme.brightness.name,
      colorScheme.foreground.toARGB32(),
      colorScheme.background.toARGB32(),
      colorScheme.primary.toARGB32(),
      colorScheme.accent.toARGB32(),
      colorScheme.mutedForeground.toARGB32(),
    ].join(':');
    final current = _initializedThemes[cacheKey];
    if (current != null) {
      return current;
    }
    final future = Future.value(_buildTheme(colorScheme));
    _initializedThemes[cacheKey] = future;
    return future;
  }

  static HighlighterTheme _buildTheme(shadcn_colors.ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;
    final wrapperColor = _mix(
      colorScheme.foreground,
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      isDark ? 0.08 : 0.04,
    );
    final commentColor = _mix(
      colorScheme.mutedForeground,
      wrapperColor,
      isDark ? 0.22 : 0.12,
    );
    final keywordColor =
        isDark ? const Color(0xFFFF7B72) : const Color(0xFFB42318);
    final functionColor =
        isDark ? const Color(0xFFD2A8FF) : const Color(0xFF8250DF);
    final typeColor =
        isDark ? const Color(0xFF79C0FF) : const Color(0xFF0550AE);
    final stringColor =
        isDark ? const Color(0xFFA5D6FF) : const Color(0xFF0A6E31);
    final numberColor =
        isDark ? const Color(0xFFFFA657) : const Color(0xFF9A4D00);
    final constantColor =
        isDark ? const Color(0xFF7EE787) : const Color(0xFF116329);
    final punctuationColor = _mix(
      wrapperColor,
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      isDark ? 0.18 : 0.08,
    );

    final themeJson = jsonEncode({
      'name': isDark ? 'Docs Dark' : 'Docs Light',
      'settings': [
        {
          'settings': {
            'foreground': _hex(wrapperColor),
          },
        },
        {
          'scope': 'comment',
          'settings': {
            'foreground': _hex(commentColor),
            'fontStyle': 'italic',
          },
        },
        {
          'scope': [
            'keyword',
            'keyword.control',
            'storage',
            'storage.type',
            'storage.modifier',
          ],
          'settings': {
            'foreground': _hex(keywordColor),
          },
        },
        {
          'scope': [
            'entity.name.function',
            'support.function',
            'meta.function-call',
          ],
          'settings': {
            'foreground': _hex(functionColor),
          },
        },
        {
          'scope': [
            'entity.name.type',
            'entity.name.class',
            'support.class',
            'support.type',
            'meta.return-type',
          ],
          'settings': {
            'foreground': _hex(typeColor),
          },
        },
        {
          'scope': [
            'string',
            'string.quoted',
            'markup.inline.raw',
          ],
          'settings': {
            'foreground': _hex(stringColor),
          },
        },
        {
          'scope': [
            'constant.numeric',
            'constant.language',
            'constant.regexp',
          ],
          'settings': {
            'foreground': _hex(numberColor),
          },
        },
        {
          'scope': [
            'constant',
            'support.constant',
            'variable.language',
          ],
          'settings': {
            'foreground': _hex(constantColor),
          },
        },
        {
          'scope': [
            'variable',
            'meta.definition.variable.name',
            'support.variable',
            'meta.object-literal.key',
            'entity.other.attribute-name',
          ],
          'settings': {
            'foreground': _hex(wrapperColor),
          },
        },
        {
          'scope': [
            'punctuation',
            'meta.brace',
            'punctuation.definition.tag',
          ],
          'settings': {
            'foreground': _hex(punctuationColor),
          },
        },
      ],
    });

    return HighlighterTheme.fromConfiguration(
      themeJson,
      TextStyle(color: wrapperColor),
    );
  }

  static Color _mix(Color a, Color b, double amount) {
    return Color.lerp(a, b, amount.clamp(0.0, 1.0)) ?? a;
  }

  static String _hex(Color color) {
    final value = color.toARGB32() & 0x00FFFFFF;
    return '#${value.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  Future<_HighlighterResult> _request() async {
    final colorScheme = DocsThemeScope.of(context).colorScheme;
    final success = await initializeLanguage(widget.mode);
    final theme = await initializeTheme(colorScheme);
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
            !data.success || resolvedMode == null
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
