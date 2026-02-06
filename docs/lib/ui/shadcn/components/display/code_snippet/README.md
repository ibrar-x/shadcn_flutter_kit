# CodeSnippet

Displays syntax-ready code with optional action buttons at the top-right corner.

## Usage

Wrap the actual code inside any text widget (e.g., `Text` or `RichText`) and pass it to `CodeSnippet`:

```dart
CodeSnippet(
  code: const Text('print("Hello")'),
  actions: [
    IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
  ],
);
```

The component respects `ComponentTheme<CodeSnippetTheme>` for background, border, radius, and padding overrides.
