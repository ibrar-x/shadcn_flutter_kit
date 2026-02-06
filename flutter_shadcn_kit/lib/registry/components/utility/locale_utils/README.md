# Locale Utils (`locale_utils`)

Date/time/duration unit helpers and file size formatting locales.

---

## When to use

- Use this when:
  - you need locale-aware file size labels.
  - you need date/time/duration part helpers for pickers.
- Avoid when:
  - you only need basic `DateTime` formatting.

---

## Install

```bash
flutter_shadcn add locale_utils
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/locale_utils/locale_utils.dart';
```

---

## Minimal example

```dart
final label = formatFileSize(1536, SizeUnitLocale.fileBytes);
```

---

## API

### Functions

- `formatFileSize`

### Types

- `SizeUnitLocale`
- `DatePart`, `TimePart`, `DurationPart`

---

## Theming

- No theme hooks; these utilities are pure helpers.

---

## Accessibility

- Use localized labels that users can read at a glance.

---

## Do / Don’t

**Do**
- ✅ Use `SizeUnitLocale.fileBytes` or `SizeUnitLocale.fileBits` consistently.

**Don’t**
- ❌ Mix binary and decimal units without clarifying.

---

## Related components

- `shadcn_localizations`
- `shadcn_localizations_extensions`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
