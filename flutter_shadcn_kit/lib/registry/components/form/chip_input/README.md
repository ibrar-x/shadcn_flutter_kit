# Chip Input

`ChipInput` builds on `TextInputStatefulWidget` so users can type and submit chips that render as `Chip` widgets with removable `ChipButton` controls. Provide a `chipBuilder` plus an `onChipSubmitted` callback (or integrate with `AutoCompleteIntent/AutoComplete` suggestions) to convert typed text into chips, and consume `ChipEditingController` for advanced cursor manipulation (`appendChip`, `insertChipAtCursor`, etc.).

Theme values (`ChipInputTheme`) control whether chips render with close buttons, the spacing between chips, and can be supplied through `ComponentTheme<ChipInputTheme>`.

```dart
ChipInput<String>(
  chipBuilder: (context, chip) => Text(chip),
  onChipSubmitted: (text) => text.isNotEmpty ? text : null,
  onChipsChanged: (chips) => print('chips: $chips'),
);
```
