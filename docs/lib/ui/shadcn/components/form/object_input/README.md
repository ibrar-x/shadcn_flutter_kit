# Object Input

A collection of composite inputs for dates, times, and durations that combine formatted text fields, controllers, and pickers.

- `DateInput` pairs `FormattedObjectInput` fields with `DatePickerDialog`/popover integration and `DatePickerController` wiring so users can edit dates via keyboard or a calendar.
- `TimeInput` renders split hour/minute/second fields with `InputPart` helpers, optional seconds, and localized abbreviations from `ShadcnLocalizations`.
- `DurationInput` shares the same formatted input plumbing but works with `Duration` values delivered through the same controller architecture.

```dart
DateInput(
  controller: DatePickerController(DateTime.now()),
  placeholder: Text('Pick date'),
  parts: [
    InputPart.editable(length: 4, width: 60),
    InputPart.static('/'),
    InputPart.editable(length: 2, width: 40),
    InputPart.static('/'),
    InputPart.editable(length: 2, width: 40),
  ],
)
```

The component relies on shared utilities (`BiDirectionalConvert`, `ConvertedController`, `ShadcnLocalizations` extensions) to keep the formatted fields and logical values synchronized.
