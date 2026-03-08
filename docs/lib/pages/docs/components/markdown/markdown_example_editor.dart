import 'package:flutter/material.dart';

import '../../../../ui/shadcn/components/display/markdown/markdown.dart'
    as shadcn_markdown;

class MarkdownExampleEditor extends StatefulWidget {
  const MarkdownExampleEditor({super.key});

  @override
  State<MarkdownExampleEditor> createState() => _MarkdownExampleEditorState();
}

class _MarkdownExampleEditorState extends State<MarkdownExampleEditor> {
  static const String _seed = '''# Live Markdown Editor

Select text and use the toolbar to combine styles in any order.

- Toggle **bold** and *italic*
- Add > quote or code fence
- Insert table, links, and images

| Column 1 | Column 2 | Column 3 |
| --- | --- | --- |
| Value | Value | Value |
''';

  late final shadcn_markdown.MarkdownEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = shadcn_markdown.MarkdownEditingController(text: _seed);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 940,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _buildEditorPanel()),
                const SizedBox(width: 12),
                Expanded(child: _buildPreviewPanel()),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildEditorPanel(),
              const SizedBox(height: 12),
              _buildPreviewPanel(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEditorPanel() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            shadcn_markdown.MarkdownEditingBar(
              controller: _controller,
              focusNode: _focusNode,
              actions: <shadcn_markdown.MarkdownEditingBarAction>[
                shadcn_markdown.MarkdownEditingBarAction.undo(),
                shadcn_markdown.MarkdownEditingBarAction.redo(),
                shadcn_markdown.MarkdownEditingBarAction.divider(),
                shadcn_markdown.MarkdownEditingBarAction.bold(),
                shadcn_markdown.MarkdownEditingBarAction.italic(),
                shadcn_markdown.MarkdownEditingBarAction.strikethrough(),
                shadcn_markdown.MarkdownEditingBarAction.heading(level: 2),
                shadcn_markdown.MarkdownEditingBarAction.heading(level: 3),
                shadcn_markdown.MarkdownEditingBarAction.inlineCode(),
                shadcn_markdown.MarkdownEditingBarAction.divider(),
                shadcn_markdown.MarkdownEditingBarAction.bulletList(),
                shadcn_markdown.MarkdownEditingBarAction.orderedList(),
                shadcn_markdown.MarkdownEditingBarAction.taskList(),
                shadcn_markdown.MarkdownEditingBarAction.quote(),
                shadcn_markdown.MarkdownEditingBarAction.codeFence(
                  language: 'dart',
                ),
                shadcn_markdown.MarkdownEditingBarAction.horizontalRule(),
                shadcn_markdown.MarkdownEditingBarAction.table(),
                shadcn_markdown.MarkdownEditingBarAction.link(),
                shadcn_markdown.MarkdownEditingBarAction.image(),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 320,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                expands: true,
                minLines: null,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontFamily: 'GeistMono', fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'Markdown source',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewPanel() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 386,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: shadcn_markdown.MarkdownLivePreview(
            controller: _controller,
            shrinkWrap: false,
            selectable: true,
            followLinks: true,
            viewportStorageId: 'docs-markdown-editor-preview',
            debounce: const Duration(milliseconds: 110),
            statusBuilder: (context, details) {
              if (!details.hasPendingChanges && !details.isValidating) {
                return null;
              }
              final label = details.isValidating
                  ? 'Updating preview...'
                  : 'Preview synced';
              return Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFF166534),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
