# Icon (`icon`)

Theme-driven icon size/color helpers and WrappedIcon.

---

## When to use

- Use this when:
  - you want consistent icon sizing and colors from the theme.
  - you need fluent icon modifiers (small, large, muted, etc.).
- Avoid when:
  - a local `IconTheme` override is sufficient.

---

## Install

```bash
flutter_shadcn add icon
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/icon/icon.dart';
```

---

## Minimal example

```dart
Icon(Icons.star).iconSmall
```

---

## Common patterns

### Pattern: Size and color helpers

```dart
Icon(Icons.settings)
  .iconLarge
  .iconMutedForeground
```

---

## API

### Constructor

- `WrappedIcon` — wraps an icon theme around a child.
- `IconExtension` — provides helpers:
  - size: `iconXSmall`, `iconSmall`, `iconMedium`, `iconLarge`, `iconXLarge`
  - color: `iconMutedForeground`, `iconPrimary`, `iconSecondary`, `iconPrimaryForeground`

---

## Theming

- Icon sizes and colors resolve from `ThemeData.iconTheme` and `ThemeData.colorScheme`.

---

## Accessibility

- Keep icon sizes large enough for touch targets when interactive.

---

## Do / Don’t

**Do**
- ✅ Use the icon helpers to keep sizes consistent.

**Don’t**
- ❌ Mix arbitrary icon sizes within the same control group.

---

## Related components

- `text`
- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
