# Command Palette

Interactive command palette with search, keyboard navigation, and custom builders.

## Usage

```dart
showCommandDialog<String>(
  context: context,
  builder: (context, query) async* {
    final matches = commands
        .where((cmd) => cmd.toLowerCase().contains(query?.toLowerCase() ?? ''))
        .map((cmd) => CommandItem(
              title: Text(cmd),
              onTap: () => Navigator.of(context).pop(cmd),
            ))
        .toList();
    yield matches;
  },
); 
```

You can configure empty, loading, and error states via the relevant builders on [Command], and theme the palette by wrapping the dialog with a `Theme` or overriding `ComponentTheme` instances such as `FocusOutlineTheme`.
