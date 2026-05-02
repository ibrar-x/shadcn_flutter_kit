# Forms And Inputs

Install form-heavy screens as a coherent stack, not one widget at a time.

```bash
flutter_shadcn dry-run \
  @shadcn/form \
  @shadcn/form_field \
  @shadcn/input \
  @shadcn/text_field \
  @shadcn/text_area \
  @shadcn/select \
  @shadcn/checkbox \
  @shadcn/radio_group \
  @shadcn/switch \
  @shadcn/slider \
  --json
```

```bash
flutter_shadcn add \
  @shadcn/form \
  @shadcn/form_field \
  @shadcn/input \
  @shadcn/text_field \
  @shadcn/text_area \
  @shadcn/select \
  @shadcn/checkbox \
  @shadcn/radio_group \
  @shadcn/switch \
  @shadcn/slider
```

## Specialized Inputs

- Search/typeahead: `form/autocomplete`, `form/chip_input`
- Dates/times: `display/calendar`, `form/date_picker`, `form/time_picker`, `form/object_input`
- Color: `form/color_picker`, `form/color_input`, `form/hsv`, `form/hsl`, `form/history`
- Files: `form/file_picker`, `form/file_input`, `form/dropzone`
- Phone: `form/phone_input`
- OTP: `form/input_otp`
- Rating/choice: `form/star_rating`, `form/multiple_choice`, `form/item_picker`
- Formatting/validation: `form/formatter`, `form/validated`, `form/control`

## Validation Rule

Keep validation in form primitives and shared helpers. Do not spread duplicate ad-hoc flags through wrapper widgets when `form`, `form_field`, `validated`, and controlled primitives can own the state.

## Verify

```bash
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```
