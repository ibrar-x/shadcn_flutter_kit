# Current vs Target: Component Theming (Detailed)

## 1) What You Want (Goal)
You want a **single replaceable theme config file per component**.

Example user flow:
1. User customizes `button` on website.
2. Website generates one Dart config file for `button`.
3. User replaces one local file.
4. New button theme applies globally.

Key requirements:
- No multi-file edits for a single component theme update.
- Defaults should be explicit and understandable.
- Config should be clean, typed, and easy to copy/paste.
- Global theme dependencies (like scaling/radius) should still work predictably.

---

## 2) What You Currently Have

## 2.1 Architecture in place
You now have a 3-layer theme layout per component:

- `base/` theme data classes
- `variants/` variant theme classes (if component has variants)
- `config/` replaceable component token config

Example (button):
- `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/components/control/button/_impl/themes/base/`
- `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/components/control/button/_impl/themes/variants/`
- `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/components/control/button/_impl/themes/config/button_theme_tokens.config.dart`

This exists across components.

## 2.2 Global registration in place
Component config classes are globally registered through:
- `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/components/component_theme_global_configs.dart`
- `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/shared/theme/component_theme_global_registry.dart`

So component overrides can be resolved globally.

## 2.3 Config format currently improved
You already moved from raw `Map<String, Object?>` blocks to typed classes inside each component config file.

Current style (example pattern):
```dart
class CheckboxThemeTokensConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? activeColor;
  final Object? borderColor;
  final Object? size;
  final Object? gap;
  final Object? borderRadius;

  const CheckboxThemeTokensConfigGlobalDefaults({
    this.backgroundColor = 'theme.colorScheme.input.scaleAlpha(0.3)',
    this.activeColor = 'theme.colorScheme.primary',
    this.borderColor = 'theme.colorScheme.border',
    this.size = '16 * scaling',
    this.gap = '8 * scaling',
    this.borderRadius = 'BorderRadius.circular(theme.radiusSm)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'backgroundColor': backgroundColor,
    'activeColor': activeColor,
    'borderColor': borderColor,
    'size': size,
    'gap': gap,
    'borderRadius': borderRadius,
  };
}
```

## 2.4 Current gap to your ideal
You still have defaults represented as expression strings in many places:
- `'16 * scaling'`
- `'theme.radiusSm'`
- similar expression-like strings

You specifically want cleaner/literal defaults and less confusion.

---

## 3) The Target You Asked For

## 3.1 One-file replace contract per component
For each component, one canonical file:
- `.../_impl/themes/config/<component>_theme_tokens.config.dart`

The website should generate this full file, and replacing it should be enough.

## 3.2 Clean typed config with literal defaults
Preferred config style:
```dart
class CheckboxDefaults {
  final double size;
  final double gap;
  final String radiusToken;

  const CheckboxDefaults({
    this.size = 16.0,
    this.gap = 8.0,
    this.radiusToken = 'sm',
  });
}

class CheckboxTokens {
  final double? size;
  final double? gap;
  final String? radiusToken;

  const CheckboxTokens({
    this.size,
    this.gap,
    this.radiusToken,
  });
}

class CheckboxThemeTokensConfig {
  static const String globalType = 'CheckboxTheme';
  static const CheckboxDefaults globalDefaults = CheckboxDefaults();
  static const CheckboxTokens globalTokens = CheckboxTokens();
}
```

Notes:
- Defaults are literals (`16.0`, `8.0`) or semantic refs (`'sm'`), not runtime expressions.
- Tokens are user overrides.

## 3.3 Runtime should apply global-theme dependency
When values depend on global theme (`scaling`, `radius`, etc.), do it in resolver/runtime code.

Example resolver pattern:
```dart
final defaults = CheckboxThemeTokensConfig.globalDefaults;
final tokens = CheckboxThemeTokensConfig.globalTokens;

final rawSize = tokens.size ?? defaults.size;          // 16.0
final resolvedSize = rawSize * theme.scaling;          // apply global scaling at runtime

final radiusName = tokens.radiusToken ?? defaults.radiusToken; // 'sm'
final resolvedRadius = switch (radiusName) {
  'xs' => theme.radiusXs,
  'sm' => theme.radiusSm,
  'md' => theme.radiusMd,
  'lg' => theme.radiusLg,
  _ => theme.radiusSm,
};
```

This keeps config clean while still honoring global theming behavior.

---

## 4) Current vs Target Summary

## 4.1 Current
- 3-layer structure exists.
- One config file per component exists.
- Global registry wiring exists.
- Config is typed (improved from plain maps).
- Some defaults are expression strings and still feel noisy/confusing.

## 4.2 Target
- Keep one-file-per-component replacement.
- Keep typed config.
- Use literal defaults and semantic token refs.
- Move all theme-context math (`* scaling`, `radius lookup`) to runtime resolvers.
- Make website output directly replaceable and human-readable.

---

## 5) Recommended Data Model for Global-Dependent Values

Instead of storing runtime expressions in config, use one of these:

1. Literal + scale flag
```dart
size: 16.0
scaleWithTheme: true
```

2. Semantic token reference
```dart
radiusToken: 'sm'
spaceToken: 'md'
```

3. Enum/union for mode-based defaults
```dart
heightMode: 'compact' | 'default' | 'comfortable'
```

Then runtime resolves to actual numbers from `Theme.of(context)`.

---

## 6) File Structure You Should Keep

Per component:
- `base/` -> theme data classes
- `variants/` -> variant theme data (if needed)
- `config/` -> one replaceable tokens config file

Global:
- `component_theme_global_configs.dart` -> registers all config entries
- `component_theme_global_registry.dart` -> lookup by theme type name

---

## 7) Final Definition of Done
A component is complete when:
1. Website generates one config file for that component.
2. Replacing that one file changes component theme globally.
3. No extra widget/state file edits are needed.
4. Defaults are readable literals/semantic refs.
5. Global dependency behavior is applied at runtime resolver level.

