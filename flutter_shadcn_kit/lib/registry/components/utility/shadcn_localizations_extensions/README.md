# Shadcn Localizations Extensions (`shadcn_localizations_extensions`)

Formatting helpers for localized dates, times, durations, and picker labels.

---

## When to use

- Use this when:
  - you need date/time formatting helpers tied to `ShadcnLocalizations`.
  - you want picker labels for months, weekdays, and color modes.
- Avoid when:
  - you need full ICU formatting (use `intl` directly).

---

## Install

```bash
flutter_shadcn add shadcn_localizations_extensions
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/shadcn_localizations_extensions/shadcn_localizations_extensions.dart';
```

---

## Minimal example

```dart
final strings = ShadcnLocalizations.of(context);
final label = strings.formatDateTime(DateTime.now());
```

---

## API

### Extensions

- `ShadcnLocalizationsExtensions`
  - `formatDateTime`
  - `formatTimeOfDay`
  - `getMonth`, `getAbbreviatedMonth`
  - `getAbbreviatedWeekday`
  - `getColorPickerMode`

---

## Theming

- Not applicable.

---

## Accessibility

- Keep localized labels clear and consistent with user expectations.

---

## Do / Don’t

**Do**
- ✅ Use locale-aware labels in pickers and calendars.

**Don’t**
- ❌ Hardcode month/day labels when localization is required.

---

## Related components

- `shadcn_localizations`
- `locale_utils`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
