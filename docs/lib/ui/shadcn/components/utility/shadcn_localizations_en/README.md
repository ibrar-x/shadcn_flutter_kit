# Shadcn Localizations (EN) (`shadcn_localizations_en`)

English translation bundle for ShadcnLocalizations.

---

## When to use

- Use this when:
  - you need the default English strings for the library.
- Avoid when:
  - you want to provide a custom locale implementation.

---

## Install

```bash
flutter_shadcn add shadcn_localizations_en
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/shadcn_localizations_en/shadcn_localizations_en.dart';
```

---

## Minimal example

```dart
final strings = ShadcnLocalizationsEn();
print(strings.formNotEmpty);
```

---

## API

### Types

- `ShadcnLocalizationsEn`

---

## Theming

- Not applicable.

---

## Accessibility

- Ensure localized strings are concise and clear.

---

## Do / Don’t

**Do**
- ✅ Use as the default locale implementation.

**Don’t**
- ❌ Modify generated strings without regenerating the bundle.

---

## Related components

- `shadcn_localizations`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
