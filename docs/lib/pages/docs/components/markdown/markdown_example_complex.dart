import 'package:flutter/material.dart';

import '../../../../ui/shadcn/components/display/markdown/markdown.dart'
    as shadcn_markdown;

class MarkdownExampleComplex extends StatefulWidget {
  const MarkdownExampleComplex({super.key});

  @override
  State<MarkdownExampleComplex> createState() => _MarkdownExampleComplexState();
}

class _MarkdownExampleComplexState extends State<MarkdownExampleComplex> {
  static const String _content = '''# Complex Markdown Showcase

## Table of Contents
- [Typography](#typography)
- [Structured Blocks](#structured-blocks)
- [Data Table](#data-table)
- [Footnotes](#footnotes)

## Typography
Mix styles in any order: **bold**, *italic*, ~~strikethrough~~, `inline code`, and ***bold italic***.

Use links with callbacks: [Flutter](https://flutter.dev), [Email us](mailto:hello@example.com).

> Nested quote:
> - [x] Task list works
> - [ ] Hook custom tap handlers

## Structured Blocks
1. Ordered item
2. Another item
   - Nested bullet
   - Nested bullet with `code`

<details>
<summary>Expandable details</summary>
This section renders from HTML and still passes through sanitization.
</details>

## Data Table
| Feature | Status | Notes |
| :-- | :--: | --: |
| Headings | done | 6 levels |
| Tables | done | aligned cells |
| Editing helpers | done | toolbar + live preview |

## Footnotes
Inline footnote example.[^docs]

[^docs]: Footnotes are parsed and rendered with numbered labels.
''';

  final List<String> _events = <String>[];

  void _pushEvent(String value) {
    setState(() {
      _events.insert(0, value);
      if (_events.length > 6) {
        _events.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final panelColor = scheme.surfaceContainerHighest.withValues(alpha: 0.65);
    final panelBorder = scheme.outlineVariant.withValues(alpha: 0.7);
    return SizedBox(
      width: 760,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          shadcn_markdown.Markdown(
            data: _content,
            selectable: true,
            followLinks: true,
            viewportStorageId: 'docs-markdown-complex',
            onTapLinkDetails: (details) {
              _pushEvent('Link: ${details.url} (${details.kind.name})');
            },
            onTapHeading: (details) {
              _pushEvent('Heading: ${details.text} (#${details.level})');
            },
            onTapElement: (details) {
              _pushEvent('Element: ${details.kind.name} -> ${details.text}');
            },
          ),
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              color: panelColor,
              border: Border.all(color: panelBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Interaction log',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_events.isEmpty)
                    Text(
                      'Tap links, headings, or table cells to see callback payloads.',
                      style: TextStyle(color: scheme.onSurface),
                    )
                  else
                    for (final event in _events)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $event',
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
