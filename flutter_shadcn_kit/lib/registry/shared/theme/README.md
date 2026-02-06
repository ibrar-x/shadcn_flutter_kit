# Theme (`shared/theme`)

Theme data, color schemes, typography, and presets used by the registry.

---

## When to use

- Use this when:
  - you need shared theme tokens or component theming support.
  - you want access to preset themes and typography scales.
- Avoid when:
  - a component can use `Theme.of(context)` without extra helpers.

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/shared/theme/theme.dart';
```

---

## API (selected)

- `ThemeData`
- `Theme`
- `ComponentTheme`, `ComponentThemeData`
- `AnimatedTheme`
- `AdaptiveScaling`, `AdaptiveScaler`
- `Typography`
- `ColorScheme`
- `RegistryThemePreset`

---

## Related modules

- `shared/fonts`
- `shared/primitives`
