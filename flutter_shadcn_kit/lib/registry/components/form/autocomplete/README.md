# AutoComplete

`AutoComplete` wraps any text input and surfaces suggestions in a popover overlay. The widget supports keyboard navigation, multiple replacement modes, theme overrides (popover constraints, alignment, width behavior), and a customizable completer (for formatting the selected suggestion before it is applied).

Example:

```dart
AutoComplete(
  suggestions: ['apple', 'apricot', 'banana'],
  mode: AutoCompleteMode.replaceWord,
  completer: (value) => '$value ',
  child: TextField(
    decoration: const InputDecoration(hintText: 'Search fruits'),
  ),
)
```
