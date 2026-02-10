# Input (`input`)

Input feature extensions for `TextField`: hint, clear/copy/paste, password toggle, autocomplete, spinner, stepper buttons, and above/below helpers.

## Install

```bash
flutter_shadcn add input
```

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/input/input.dart';
```

## Quick example

```dart
TextField(
  placeholder: const Text('Amount'),
  features: const [
    InputLeadingFeature(Icon(LucideIcons.dollarSign)),
    InputSpinnerFeature(step: 5, min: 0, max: 500),
    InputStepperButtonFeature.decrement(),
    InputStepperButtonFeature(),
  ],
)
```

## API

- `InputFeaturePosition`: `leading`, `trailing`, `above`, `below`.
- `SuggestionBuilder`: `FutureOr<Iterable<String>> Function(String query)`.
- Feature classes:
  - `InputHintFeature`
  - `InputPasswordToggleFeature`
  - `InputClearFeature`
  - `InputRevalidateFeature`
  - `InputAutoCompleteFeature`
  - `InputSpinnerFeature` (`step`, `invalidValue`, `min`, `max`, `enableGesture`)
  - `InputStepperButtonFeature` / `InputStepperButtonFeature.decrement`
  - `InputCopyFeature`
  - `InputPasteFeature`
  - `InputLeadingFeature`
  - `InputTrailingFeature`
  - `InputAboveBelowFeature` (`above`/`below`)

## Notes

- Spinner buttons are automatically disabled at min/max bounds.
- `InputAboveBelowFeature` wraps the field and places helper content above or below it.
