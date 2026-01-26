# Form Field

`ObjectFormField` wraps content in a button-like trigger that opens a dialog or popover editor. It wires `ObjectFormHandler` into the tree so nested editors can update the parent value, and it ships with templated save/cancel buttons that use the existing button themes. Use `mode` to pick between a modal dialog or an inline popover, and pass `editorBuilder` plus optional hooks such as `dialogActions`, `popoverAlignment`, or `immediateValueChange` to customize the experience.

```dart
ObjectFormField<DateTime>(
  value: selectedDate,
  placeholder: const Text('Pick a date'),
  builder: (context, date) => Text(DateFormat.yMMMd().format(date)),
  mode: PromptMode.popover,
  editorBuilder: (context, handler) => CalendarWidget(
    onDateSelected: (value) {
      handler.value = value;
    },
  ),
);
```
