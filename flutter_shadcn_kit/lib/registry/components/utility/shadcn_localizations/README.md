# Shadcn Localizations (`shadcn_localizations`)

Full localization delegate and base translations.

---

## When to use

- Use this when:
  - you need the base localization delegate for the library.
  - you want access to localized strings via `ShadcnLocalizations`.
- Avoid when:
  - you only need a single language (use `shadcn_localizations_en`).

---

## Install

```bash
flutter_shadcn add shadcn_localizations
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/shadcn_localizations/shadcn_localizations.dart';
```

---

## Minimal example

```dart
MaterialApp(
  localizationsDelegates: ShadcnLocalizations.localizationsDelegates,
  supportedLocales: ShadcnLocalizations.supportedLocales,
  home: const MyApp(),
)
```

---

## API

### Core types

- `ShadcnLocalizations`
- `ShadcnLocalizations.delegate`
- `ShadcnLocalizations.localizationsDelegates`
- `ShadcnLocalizations.supportedLocales`

---

## Theming

- Not applicable; this is a localization layer.

---

## Accessibility

- Localization improves readability for users in their preferred language.

---

## Do / Don’t

**Do**
- ✅ Add the delegate and supported locales to your app.

**Don’t**
- ❌ Ship without adding `flutter_localizations` and `intl` dependencies.

---

## Related components

- `shadcn_localizations_en`
- `shadcn_localizations_extensions`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
