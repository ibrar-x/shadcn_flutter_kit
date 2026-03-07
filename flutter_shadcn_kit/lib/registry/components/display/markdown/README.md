# Markdown

Standalone markdown renderer with no `flutter_markdown` dependency.

## Features

- Headings, paragraphs, block quotes, horizontal rules
- Ordered/unordered/nested lists + task lists (`- [x]`)
- Fenced code blocks with optional language labels
- Indented code blocks
- Tables with alignment (`:--`, `:--:`, `--:`) and compact rendering in narrow/chat-bubble layouts
- Images (`![alt](url)`), links, auto-links
- Reference links/images, footnotes, definition lists
- Details blocks, inline/block math, basic HTML tags (`<br>`, `<kbd>`, `<strong>`, `<em>`, `<code>`)
- Inline bold/italic/code/strikethrough, escaped characters, HTML entities
- Component-level theming via `MarkdownTheme`
- Built-in HTML sanitization strategies
- Rich image preview on tap, with overridable preview builder
- Dependency-free markdown editing helpers for editor toolbars
- Multiple data sources:
  - direct string (`Markdown(data: ...)`)
  - asset file (`Markdown.asset(asset: ...)`)
  - filesystem file (`Markdown.file(path: ...)`)

## Basic Usage

```dart
Markdown(
  data: '# Hello\n\nThis is **markdown**.',
)
```

## Asset/File Sources

```dart
Markdown.asset(asset: 'assets/markdown/advanced_markdown.md');

Markdown.file(path: '/absolute/path/to/doc.md');
```

## Sanitization

```dart
Markdown(
  data: markdown,
  htmlSanitizationStrategy:
      MarkdownHtmlSanitizationStrategy.stripDangerousHtml,
)
```

Available strategies:

- `MarkdownHtmlSanitizationStrategy.permissive`
- `MarkdownHtmlSanitizationStrategy.stripDangerousHtml`
- `MarkdownHtmlSanitizationStrategy.stripAllHtml`

## Image Preview

```dart
Markdown(
  data: markdown,
  imagePreviewBehavior: MarkdownImagePreviewBehavior.dialog,
  imagePreviewBuilder: (context, details, close) {
    return Dialog(
      child: Column(
        children: [
          Text(details.alt),
          Expanded(child: Image.network(details.url)),
        ],
      ),
    );
  },
)
```

## Editing Helpers

```dart
final result = MarkdownEditingHelpers.toggleBold(
  text: controller.text,
  selection: controller.selection,
);

controller.value = controller.value.copyWith(
  text: result.text,
  selection: result.selection,
);
```

## Optional Streaming (Extension)

```dart
import '../text_animate/_impl/extensions/markdown_streaming_extension.dart';

Markdown(
  data: streamedMarkdown,
).withTextStreaming(
  effect: const BlurInEffect(maxBlurSigma: 12),
  typewriter: const TypewriterEffect(enabled: false),
  animateByWord: true,
)
```

Streaming is opt-in and separate from markdown rendering.

When used with `.withTextStreaming(...)`, the widget now commits completed markdown blocks incrementally and only reparses the active streaming tail, which reduces visible churn and keeps memory bounded.

## Theming

```dart
ComponentTheme(
  data: const MarkdownTheme(
    linkStyle: TextStyle(color: Color(0xFF0E7490)),
    codeBackgroundColor: Color(0xFFF5EEE2),
    tableBorderColor: Color(0xFFD6C5AB),
    quoteBorderColor: Color(0xFFD97706),
    heading1Style: TextStyle(fontSize: 31, fontWeight: FontWeight.w800),
  ),
  child: Markdown.asset(asset: 'assets/markdown/markdown_feature_showcase.md'),
)
```
