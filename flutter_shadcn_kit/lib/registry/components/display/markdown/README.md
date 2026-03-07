# Markdown

Standalone markdown renderer with no `flutter_markdown` dependency.

## Features

- Headings, paragraphs, block quotes, horizontal rules
- Ordered/unordered/nested lists + task lists (`- [x]`)
- Fenced code blocks with optional language labels
- Indented code blocks
- Tables with alignment (`:--`, `:--:`, `--:`)
- Images (`![alt](url)`), links, auto-links
- Reference links/images, footnotes, definition lists
- Details blocks, inline/block math, basic HTML tags (`<br>`, `<kbd>`, `<strong>`, `<em>`, `<code>`)
- Inline bold/italic/code/strikethrough, escaped characters, HTML entities
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
