# Form Field (`form_field`)

Modal or popover editor field for complex objects.

---

## When to use

- Use this when:
  - you need a button-like field that opens a custom editor.
  - you want a consistent dialog/popover prompt pattern.
- Avoid when:
  - a standard text field is sufficient.

---

## Install

```bash
flutter_shadcn add form_field
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/form_field/form_field.dart';
```

---

## Minimal example

```dart
ObjectFormField<DateTime>(
  value: selectedDate,
  placeholder: const Text('Select date'),
  builder: (context, value) => Text(value.toString()),
  editorBuilder: (context, handler) => Calendar(
    view: CalendarView.now(),
    selectionMode: CalendarSelectionMode.single,
    onChanged: (value) => handler.value = (value as SingleCalendarValue).date,
  ),
)
```

---

## API

### Constructor

- `ObjectFormField<T>`
  - `value` (`T?`, required)
  - `builder` (`Widget Function(BuildContext, T)`, required)
  - `editorBuilder` (`Widget Function(BuildContext, ObjectFormHandler<T>)`, required)
  - `mode` (`PromptMode`), `dialogTitle`, `popoverAlignment`, `popoverAnchorAlignment`, `popoverPadding`
  - `leading`, `trailing`, `size`, `density`, `shape`, `enabled`, `decorate`
- `ObjectFormHandler<T>` — interface for reading/updating value.
- `ObjectFormFieldDialogResult<T>` — dialog result wrapper.
- `PromptMode` — `dialog` or `popover`.

---

## Theming

- Uses shared dialog and card theming.

---

## Accessibility

- Ensure the editor content can be navigated by keyboard.

---

## Do / Don’t

**Do**
- ✅ Use `immediateValueChange` if you want live updates in popover mode.

**Don’t**
- ❌ Open heavy editors without constraints or scroll support.

---

## Related components

- `date_picker`
- `time_picker`
- `item_picker`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
