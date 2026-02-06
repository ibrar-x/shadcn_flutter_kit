# Localizations (`shared/localizations`)

Minimal localization values and helper extensions used by registry components.

---

## When to use

- Use this when:
  - you need the shared `ShadcnLocalizations` in internal components.
  - you want object-input formatting helpers.
- Avoid when:
  - you need the full public localization bundle (use the utility components).

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/shared/localizations/shadcn_localizations.dart';
import 'package:<your_app>/ui/shadcn/shared/localizations/shadcn_localizations_extensions.dart';
```

---

## Minimal example

```dart
final strings = ShadcnLocalizations.of(context);
print(strings.commandSearch);
```

---

## API

### Core types

- `ShadcnLocalizations`
- `ShadcnLocalizations.delegate`
- `ShadcnLocalizations.localizationsDelegates`
- `ShadcnLocalizations.supportedLocales`

### Extensions

- `ShadcnLocalizationsObjectInputExtensions`

---

## Related modules

- `shared/utils`
- `components/utility/shadcn_localizations`
