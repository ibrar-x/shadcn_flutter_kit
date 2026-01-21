# Date Picker

Single-date and date-range pickers that launch a calendar via popover or dialog prompts.

Use `DatePicker` or `ControlledDatePicker` for single selection with optional calendar view,
popover alignment, and custom `DateStateBuilder` support. The companion `DateRangePicker`
works inside the same prompt system but renders a range selection view that adapts to narrow
and wide layouts.

Wrap the component with a `ControlledComponentAdapter` when you need form integration, and
provide `DatePickerController`/`DateRangePicker` callbacks to react to the chosen dates.
